<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ARN - Alliance pour la Renaissance Nutritionnelle</title>
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:Arial,sans-serif}
body{background:#f5f6f8}
header{display:flex;justify-content:space-between;align-items:center;padding:8px 12px;background:white;position:sticky;top:0;z-index:1000;box-shadow:0 2px 6px rgba(0,0,0,.1)}
.logo{display:flex;align-items:center;gap:8px}
.logo .cercle{width:52px;height:52px;background:#0d47a1;color:white;border-radius:50%;display:flex;align-items:center;justify-content:center;font-weight:900;font-size:18px}
.logo b{font-size:15px;line-height:1.2}
.logo i{color:#2e7d32;font-size:11px;font-style:normal;font-weight:bold}
#btnMenu{font-size:28px;padding:10px;cursor:pointer}
#menu{position:fixed;top:0;right:0;width:270px;height:100%;background:white;z-index:2000;box-shadow:-2px 0 10px rgba(0,0,0,.2);display:none;padding:15px}
#menu div{padding:14px 10px;border-bottom:1px solid #eee;cursor:pointer}
.hero{background:linear-gradient(90deg,#0d47a1,#2e9e5b);margin:12px;border-radius:14px;padding:22px;text-align:center;color:white}
.hero h1{font-size:22px;line-height:1.3}
.hero img{width:100%;height:320px;object-fit:cover;border-radius:14px;margin:12px 0}
.btn{padding:14px;border-radius:8px;font-weight:800;text-align:center;margin:8px 14px;cursor:pointer;font-size:15px}
.vert{background:#2e9e5b;color:white}.bleu{background:#0d47a1;color:white}.noir{background:#1a2340;color:white}.gris{background:#fff;border:1px solid #ddd;color:#333}
.box{background:white;margin:12px;border-radius:14px;padding:16px}
.box h2{margin-bottom:12px;font-size:18px}
.box input,.box select,.box textarea{width:100%;padding:12px;border:1px solid #ddd;border-radius:10px;margin-bottom:10px;font-size:14px}
.ligne{display:flex;justify-content:space-between;align-items:center;border:1px solid #eee;border-radius:10px;padding:10px;margin-bottom:8px}
.petit{background:#0d47a1;color:white;border:none;padding:8px 12px;border-radius:8px;font-weight:700}
.rouge{background:#ffebee;color:#e53935;border:none;padding:8px 10px;border-radius:8px}
.fiche{display:flex;gap:12px;align-items:flex-start}
.fiche img{width:110px;height:130px;object-fit:cover;border-radius:10px;border:2px solid #0d47a1}
.qr{width:110px;height:110px}
.badge{padding:5px 10px;border-radius:20px;font-size:12px;font-weight:800}
.valide{background:#e8f5e9;color:#2e7d32}.attente{background:#fff3e0;color:#ef6c00}
</style>
</head>
<body>

<header>
<div class="logo"><div class="cercle">ARN</div><div><b>Alliance pour la<br>Renaissance Nutritionnelle</b><br><i>FORMER - ACCOMPAGNER - IMPACTER</i></div></div>
<div id="btnMenu" onclick="ouvrirMenu()">☰</div>
</header>

<div id="menu">
<div style="text-align:right;font-size:22px;border:none" onclick="fermerMenu()">✕</div>
<div onclick="go('accueil')">🏠 Accueil</div>
<div onclick="go('verif')">✅ Vérification matricule</div>
<div onclick="go('creer')">➕ Créer mon compte</div>
<div onclick="go('login')">🔑 Se connecter</div>
<div onclick="go('secret')">🔐 Zone Secrétaire</div>
<div onclick="go('bulletin')">📄 Retirer mon bulletin</div>
</div>

<!-- ACCUEIL -->
<div id="p-accueil">
<div class="hero"><h1>ARN là où commence la vie<br>nous agissons</h1>
<img src="https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=800">
</div>
<div class="btn vert" onclick="go('verif')">✅ Vérification matricule</div>
<div class="btn bleu" onclick="go('creer')">Créer mon compte</div>
<div class="btn noir" onclick="go('login')">Se connecter</div>
<div class="box" style="text-align:center;color:#555;font-size:13px;line-height:1.6"><b style="color:#111">Alliance pour la Renaissance Nutritionnelle</b><br>FORMER - ACCOMPAGNER - IMPACTER<br>Là où commence la vie, nous agissons.<br><br>Avec l'ensemble des médecins nutritionnistes, nous poursuivrons les actions pour renforcer la qualité nutritionnelle, promouvoir une alimentation saine au service du développement de notre pays.</div>
<div class="btn gris" onclick="go('secret')">🔐 Zone Secrétaire</div>
</div>

<!-- VERIF -->
<div id="p-verif" style="display:none"><div class="box"><h2>✅ Vérification matricule</h2><p style="font-size:13px;color:#666;margin-bottom:10px">Format : ARN 2026 0001</p><input id="vMat" placeholder="Ex: ARN 2026 0001"><div class="btn vert" onclick="verifier()">VÉRIFIER</div><div id="resVerif"></div></div></div>

<!-- CREER -->
<div id="p-creer" style="display:none"><div class="box"><h2>➕ Créer mon compte</h2><p style="font-size:13px;color:#666;margin-bottom:10px">Tu dois avoir reçu ton matricule de la secrétaire.</p><input id="cMat" placeholder="Matricule : ARN 2026 0001"><input id="cPass" type="password" placeholder="Crée ton mot de passe"><input id="cPass2" type="password" placeholder="Confirme mot de passe"><div class="btn bleu" onclick="creerCompte()">CRÉER MON COMPTE</div><div id="resCreer"></div></div></div>

<!-- LOGIN -->
<div id="p-login" style="display:none"><div class="box"><h2>🔑 Se connecter</h2><input id="lMat" placeholder="Matricule : ARN 2026 0001"><input id="lPass" type="password" placeholder="Mot de passe"><div class="btn bleu" onclick="login()">SE CONNECTER</div><div id="resLogin"></div></div></div>

<!-- SECRET -->
<div id="p-secret" style="display:none"><div class="box"><h2>🔐 Zone Secrétaire</h2><p style="font-size:13px">Code secrétaire : <b>ARN2026</b></p><input id="codeSec" placeholder="Code secrétaire"><div class="btn noir" onclick="ouvrirSecret()">ENTRER</div><div id="zoneSec" style="display:none">
<h3 style="margin:12px 0">Ajouter un matricule</h3>
<input id="newMat" placeholder="ARN 2026 0001"><div class="btn vert" onclick="ajouterMat()">+ AJOUTER MATRICULE</div>
<h3 style="margin:12px 0">Liste des matricules (<span id="nbMat">0</span> / 10000)</h3>
<input placeholder="Rechercher..." oninput="afficherMat(this.value)">
<div id="listeMat"></div>
<h3 style="margin:14px 0">📄 Gérer les bulletins</h3>
<input id="bMat" placeholder="Matricule du membre"><input id="bTitre" placeholder="Titre bulletin : Ex Bulletin Janvier 2026"><textarea id="bTexte" placeholder="Contenu du bulletin..."></textarea><div class="btn bleu" onclick="ajouterBulletin()">ENVOYER BULLETIN</div>
<div id="listeBulletinsSec"></div>
</div></div></div>

<!-- BULLETIN -->
<div id="p-bulletin" style="display:none"><div class="box"><h2>📄 Retirer mon bulletin</h2><input id="bulMat" placeholder="Ton matricule"><div class="btn bleu" onclick="voirBulletins()">VOIR MES BULLETINS</div><div id="resBulletin"></div></div></div>

<!-- ESPACE MEMBRE -->
<div id="p-membre" style="display:none"><div class="box">
<div style="display:flex;justify-content:space-between"><h2>Mon Espace ARN</h2><span id="statutBadge" class="badge attente">EN ATTENTE</span></div>
<p id="mMat" style="font-weight:800;color:#0d47a1"></p>
<div class="fiche"><img id="mPhoto" src="https://via.placeholder.com/110x130?text=PHOTO"><div><img id="mQR" class="qr" src=""><p style="font-size:11px;text-align:center">Scanne pour vérifier</p></div></div>
<h3 style="margin-top:14px">📋 Compléter ma fiche - ARCHITECTURE SÉCURISÉE</h3>
<p style="font-size:12px;color:#666;margin:6px 0">NIVEAU 1 : ACCÈS ET SÉCURITÉ - Chaque personne reçoit son Matricule → se connecte → doit compléter sa fiche. Elle ne voit ses infos complètes qu'une fois validée par l'Admin.</p>
<input id="fNom" placeholder="Nom complet *"><input id="fPrenom" placeholder="Prénom *"><input id="fNaiss" type="date" placeholder="Date de naissance"><select id="fSexe"><option value="">Sexe</option><option>Homme</option><option>Femme</option></select>
<input id="fTel" placeholder="Téléphone *"><input id="fEmail" placeholder="Email"><input id="fAdresse" placeholder="Adresse / Quartier"><input id="fCommune" placeholder="Commune"><input id="fVille" placeholder="Ville / Préfecture - Ex: Soumambossia"><input id="fProf" placeholder="Profession"><input id="fEtude" placeholder="Niveau d'étude">
<label style="font-size:13px">Photo (elle sera à côté du QR)</label><input id="fPhoto" type="file" accept="image/*">
<div class="btn vert" onclick="sauverFiche()">💾 ENREGISTRER MA FICHE</div>
<div id="resFiche"></div>
<div class="btn gris" onclick="go('bulletin')">📄 Voir mes bulletins</div>
<div class="btn rouge" style="display:block;text-align:center" onclick="logout()">Déconnexion</div>
</div></div>

<!-- FICHE PUBLIQUE VERIF -->
<div id="p-public" style="display:none"><div class="box"><h2>✅ Fiche Vérifiée ARN</h2><div id="resPublic"></div></div></div>

<script>
// BASE 10000 PERSONNES - localStorage
let mats = JSON.parse(localStorage.getItem('arn_mats')||'["ARN 2026 0001","ARN 2026 0002","ARN 2026 0003"]');
let users = JSON.parse(localStorage.getItem('arn_users')||'{}');
let fiches = JSON.parse(localStorage.getItem('arn_fiches')||'{}');
let bulletins = JSON.parse(localStorage.getItem('arn_bulletins')||'[]');
let session = null;
function save(){localStorage.setItem('arn_mats',JSON.stringify(mats));localStorage.setItem('arn_users',JSON.stringify(users));localStorage.setItem('arn_fiches',JSON.stringify(fiches));localStorage.setItem('arn_bulletins',JSON.stringify(bulletins));}
function ouvrirMenu(){document.getElementById('menu').style.display='block'}
function fermerMenu(){document.getElementById('menu').style.display='none'}
function go(id){fermerMenu();['accueil','verif','creer','login','secret','bulletin','membre','public'].forEach(x=>document.getElementById('p-'+x).style.display='none');document.getElementById('p-'+id).style.display='block';window.scrollTo(0,0)}
function norm(m){return m.trim().toUpperCase().replace(/\s+/g,' ')}
function verifier(){let m=norm(document.getElementById('vMat').value);let ok=mats.includes(m);document.getElementById('resVerif').innerHTML= ok ? '<div class="box" style="background:#e8f5e9"><b>✅ Matricule valide : '+m+'</b><br>Tu peux créer ton compte.</div><div class="btn bleu" onclick="go(\'creer\')">Créer mon compte</div>' : '<div class="box" style="background:#ffebee"><b>❌ Matricule introuvable.</b><br>Contacte la secrétaire.</div>';}
function creerCompte(){let m=norm(document.getElementById('cMat').value),p=document.getElementById('cPass').value,p2=document.getElementById('cPass2').value;if(!mats.includes(m))return document.getElementById('resCreer').innerHTML='<b style="color:red">Matricule invalide.</b>';if(users[m])return document.getElementById('resCreer').innerHTML='<b style="color:red">Compte déjà créé. Connecte-toi.</b>';if(!p||p!==p2)return document.getElementById('resCreer').innerHTML='<b style="color:red">Mots de passe différents.</b>';users[m]=p;save();document.getElementById('resCreer').innerHTML='<b style="color:green">✅ Compte créé ! Connecte-toi.</b>';setTimeout(()=>go('login'),800);}
function login(){let m=norm(document.getElementById('lMat').value),p=document.getElementById('lPass').value;if(users[m]!==p)return document.getElementById('resLogin').innerHTML='<b style="color:red">Matricule ou mot de passe faux.</b>';session=m;go('membre');document.getElementById('mMat').innerText=m;let f=fiches[m]||{};document.getElementById('fNom').value=f.nom||'';document.getElementById('fPrenom').value=f.prenom||'';document.getElementById('fTel').value=f.tel||'';document.getElementById('fEmail').value=f.email||'';document.getElementById('fAdresse').value=f.adresse||'';document.getElementById('fCommune').value=f.commune||'';document.getElementById('fVille').value=f.ville||'';document.getElementById('fProf').value=f.prof||'';document.getElementById('fEtude').value=f.etude||'';majQR();document.getElementById('statutBadge').innerText=f.valide?'VALIDÉ':'EN ATTENTE';document.getElementById('statutBadge').className='badge '+(f.valide?'valide':'attente');if(f.photo)document.getElementById('mPhoto').src=f.photo;}
function majQR(){if(!session)return;let url=location.origin+location.pathname+'?id='+encodeURIComponent(session);document.getElementById('mQR').src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data='+encodeURIComponent(url);}
function sauverFiche(){if(!session)return;let file=document.getElementById('fPhoto').files[0];let data={nom:document.getElementById('fNom').value,prenom:document.getElementById('fPrenom').value,tel:document.getElementById('fTel').value,email:document.getElementById('fEmail').value,adresse:document.getElementById('fAdresse').value,commune:document.getElementById('fCommune').value,ville:document.getElementById('fVille').value,prof:document.getElementById('fProf').value,etude:document.getElementById('fEtude').value,photo:fiches[session]?.photo||'',valide:false};let fin=()=>{fiches[session]=data;save();majQR();if(data.photo)document.getElementById('mPhoto').src=data.photo;document.getElementById('resFiche').innerHTML='<b style="color:green">✅ Fiche enregistrée. En attente de validation Admin. Ton QR est généré.</b>';};if(file){let r=new FileReader();r.onload=e=>{data.photo=e.target.result;fin();};r.readAsDataURL(file);}else fin();}
function ouvrirSecret(){if(document.getElementById('codeSec').value!=='ARN2026')return alert('Code faux');document.getElementById('zoneSec').style.display='block';afficherMat('');}
function ajouterMat(){let m=norm(document.getElementById('newMat').value);if(!m.startsWith('ARN 2026 '))return alert('Format : ARN 2026 0001');if(mats.includes(m))return alert('Déjà existant');mats.push(m);save();document.getElementById('newMat').value='';afficherMat('');}
function afficherMat(f=''){document.getElementById('nbMat').innerText=mats.length;let h='';mats.filter(m=>m.includes(f.toUpperCase())).forEach(m=>{h+='<div class="ligne"><b>'+m+'</b><button class="rouge" onclick="retirerMat(\''+m+'\')">Retirer</button></div>'});document.getElementById('listeMat').innerHTML=h;let hb='';bulletins.forEach((b,i)=>{hb+='<div class="ligne"><b>'+b.mat+' - '+b.titre+'</b><button class="rouge" onclick="suppBul('+i+')">X</button></div>'});document.getElementById('listeBulletinsSec').innerHTML=hb;}
function retirerMat(m){if(!confirm('Retirer '+m+' ?'))return;mats=mats.filter(x=>x!==m);delete users[m];delete fiches[m];save();afficherMat('');}
function ajouterBulletin(){let m=norm(document.getElementById('bMat').value),t=document.getElementById('bTitre').value,tx=document.getElementById('bTexte').value;if(!mats.includes(m))return alert('Matricule introuvable');bulletins.push({mat:m,titre:t,texte:tx,date:new Date().toLocaleDateString()});save();alert('Bulletin envoyé à '+m);afficherMat('');}
function suppBul(i){bulletins.splice(i,1);save();afficherMat('');}
function voirBulletins(){let m=norm(document.getElementById('bulMat').value);let list=bulletins.filter(b=>b.mat===m);if(!list.length)return document.getElementById('resBulletin').innerHTML='<b>Aucun bulletin pour '+m+'</b>';let h='';list.forEach(b=>{h+='<div class="box" style="border:1px solid #eee"><b>'+b.titre+'</b><br><small>'+b.date+'</small><p style="margin:8px 0">'+b.texte+'</p><button class="petit" onclick="window.print()">🖨️ Imprimer / Télécharger</button></div>'});document.getElementById('resBulletin').innerHTML=h;}
function logout(){session=null;go('accueil');}
// Lien QR public ?id=
let params=new URLSearchParams(location.search);if(params.get('id')){let m=norm(params.get('id'));let f=fiches[m];go('public');document.getElementById('resPublic').innerHTML=f?'<div class="fiche"><img src="'+(f.photo||'https://via.placeholder.com/110x130?text=PHOTO')+'"><div><b>'+m+'</b><br>'+f.prenom+' '+f.nom+'<br>'+f.ville+' - '+f.commune+'<br>'+f.prof+'<br><span class="badge valide">✅ Vérifié ARN</span></div></div>':'<b>Matricule introuvable</b>';}
</script>
</body>
</html>
