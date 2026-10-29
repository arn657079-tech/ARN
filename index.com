<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ARN - Alliance Renaissance Nutritionnelle</title>
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:Arial,sans-serif}
body{background:#f1f5f9;color:#1e293b}
header{background:#fff;padding:12px 16px;display:flex;justify-content:space-between;align-items:center;box-shadow:0 2px 8px rgba(0,0,0,.1);position:sticky;top:0;z-index:10}
.logo{width:44px;height:44px;background:#1e3a8a;color:#fff;border-radius:50%;display:flex;align-items:center;justify-content:center;font-weight:900}
.card{width:96%;max-width:750px;margin:16px auto;background:#fff;padding:20px;border-radius:16px;box-shadow:0 4px 12px rgba(0,0,0,.08)}
.btn{width:100%;padding:14px;border:none;border-radius:10px;font-weight:bold;font-size:15px;margin-top:10px;cursor:pointer}
.btn-bleu{background:#1e40af;color:#fff}
.btn-vert{background:#16a34a;color:#fff}
.btn-noir{background:#0f172a;color:#fff}
.btn-gris{background:#e2e8f0;color:#334155}
input,select{width:100%;padding:12px;margin:6px 0;border:1px solid #cbd5e1;border-radius:8px;font-size:15px}
.top-qr{display:flex;gap:20px;align-items:center;justify-content:space-between;border:2px solid #1e3a8a;border-radius:14px;padding:16px;background:#f8fafc}
.qr-box img{width:140px;height:140px;border-radius:12px;background:#fff;padding:4px;border:1px solid #e2e8f0}
.photo-rond{width:110px;height:110px;border-radius:50%;object-fit:cover;border:4px solid #1e3a8a;background:#e2e8f0}
.badge{display:inline-block;background:#dbeafe;color:#1e40af;padding:4px 10px;border-radius:20px;font-size:12px;font-weight:bold;margin-top:4px}
.label{font-size:13px;color:#64748b;font-weight:bold;margin-top:10px;display:block}
</style>
</head>
<body>
<header>
<div style="display:flex;gap:10px;align-items:center"><div class="logo">ARN</div><div><b>Alliance Renaissance Nutritionnelle</b><br><small style="color:#64748b">Là où commence la vie, nous agissons</small></div></div>
<div style="font-size:22px">☰</div>
</header>

<div id="page-accueil" class="card" style="text-align:center">
<div style="background:linear-gradient(135deg,#1e3a8a,#16a34a);color:#fff;padding:24px;border-radius:14px">
<h2>ARN</h2><p style="margin-top:8px">Là où commence la vie nous agissons</p>
</div>
<button class="btn btn-vert" onclick="afficherPage('page-creation')">✅ Vérification matricule</button>
<button class="btn btn-bleu" onclick="afficherPage('page-creation')">Créer mon compte</button>
<button class="btn btn-noir" onclick="afficherPage('page-connexion')">Se connecter</button>
<button class="btn btn-gris" onclick="afficherPage('page-secretaire-login')">⚙️ Secrétaire</button>
</div>

<div id="page-creation" class="card" style="display:none">
<h3 style="color:#1e3a8a">Créer mon compte</h3>
<span class="label">MATRICULE</span>
<input id="input-crea-mat" placeholder="Ex: ARN 2026 PRS 0001">
<span class="label">MOT DE PASSE</span>
<input id="input-crea-pass" type="password" placeholder="Minimum 4 caractères">
<button class="btn btn-vert" onclick="actionCreerCompte()">Créer mon compte</button>
<button class="btn btn-gris" onclick="afficherPage('page-accueil')">Retour</button>
</div>

<div id="page-connexion" class="card" style="display:none">
<h3 style="color:#1e3a8a">Connexion</h3>
<span class="label">MATRICULE</span>
<input id="input-login-mat" placeholder="Votre matricule">
<span class="label">MOT DE PASSE</span>
<input id="input-login-pass" type="password">
<button class="btn btn-bleu" onclick="actionLogin()">Entrer</button>
<button class="btn btn-gris" onclick="afficherPage('page-accueil')">Retour</button>
</div>

<div id="page-secretaire-login" class="card" style="display:none">
<h3 style="color:#1e3a8a">Accès Secrétaire</h3>
<span class="label">MOT DE PASSE SECRÉTAIRE</span>
<input id="input-sec-pass" type="password" placeholder="ARN2026">
<button class="btn btn-bleu" onclick="actionLoginSec()">Entrer</button>
<button class="btn btn-gris" onclick="afficherPage('page-accueil')">Retour</button>
</div>

<div id="page-admin" class="card" style="display:none">
<h3 style="color:#1e3a8a">Gestion Secrétaire</h3>
<div style="display:flex;gap:8px;margin-top:12px"><input id="input-add-mat" placeholder="Nouveau matricule"><button onclick="actionAjouter()" style="background:#2563eb;color:#fff;border:none;border-radius:8px;padding:0 18px;font-weight:bold">Ajouter</button></div>
<input id="input-search" placeholder="Rechercher matricule ou nom..." oninput="actionRender()" style="margin-top:12px;border:2px solid #1e40af">
<div id="zone-liste" style="margin-top:12px"></div>

<div id="zone-detail" style="display:none;margin-top:18px;border:2px solid #1e3a8a;border-radius:14px;padding:16px">
<h3 id="detail-mat" style="color:#1e3a8a;text-align:center"></h3>
<div class="top-qr" style="margin-top:12px">
<img id="detail-photo" class="photo-rond" style="display:none">
<div id="detail-qr" class="qr-box"></div>
</div>
<div id="detail-infos" style="margin-top:16px"></div>
<button class="btn btn-gris" onclick="document.getElementById('zone-detail').style.display='none'">Fermer</button>
</div>
<button class="btn btn-gris" onclick="afficherPage('page-accueil')" style="margin-top:20px">Déconnexion</button>
</div>

<div id="page-fiche" class="card" style="display:none">
<h3 style="color:#1e3a8a">Ma Fiche - <span id="fiche-mat"></span></h3>
<span class="label">PHOTO DE PROFIL</span>
<input type="file" accept="image/*" onchange="actionSavePhoto(this)">
<img id="fiche-photo" class="photo-rond" style="display:none;margin:10px auto">
<span class="label">NOM COMPLET</span>
<input id="fiche-nom" placeholder="Ex: DIALLO Mamadou">
<span class="label">FONCTION</span>
<input id="fiche-fonc" placeholder="Ex: Agent Nutrition">
<span class="label">AFFECTATION</span>
<input id="fiche-aff" placeholder="Ex: Conakry">
<span class="label">SIGNATURE</span>
<canvas id="canvas-sig" width="600" height="200" style="border:2px dashed #1e40af;border-radius:10px;width:100%;background:#fff;margin-top:6px"></canvas>
<div style="display:flex;gap:8px;margin-top:8px">
<button class="btn btn-gris" style="width:50%" onclick="actionClearSig()">Effacer</button>
<button class="btn btn-bleu" style="width:50%" onclick="actionSaveSig()">Valider Signature</button>
</div>
<img id="fiche-sig-img" style="display:none;width:100%;margin-top:10px;border:1px solid #ccc;border-radius:8px;background:#fff">
<button class="btn btn-vert" onclick="actionSaveFiche()">💾 Enregistrer ma fiche</button>
<button class="btn btn-gris" onclick="afficherPage('page-accueil')">Déconnexion</button>
</div>

<script>
var listeMatricules = JSON.parse(localStorage.getItem('arn_liste')||'[]');
var listeUsers = JSON.parse(localStorage.getItem('arn_users')||'{}');
if(listeMatricules.length==0){
listeMatricules=[];
for(var i=1;i<=1000;i++){var s='000'+i;listeMatricules.push('ARN 2026 '+s.slice(-4));}
listeMatricules.push('ARN 2026 PRS 0001');
}
var matriculeCourant=null;
function afficherPage(id){
var pages=['page-accueil','page-creation','page-connexion','page-secretaire-login','page-admin','page-fiche'];
for(var k=0;k<pages.length;k++){var e=document.getElementById(pages[k]);if(e)e.style.display='none';}
document.getElementById(id).style.display='block';
}
function normaliser(t){return t.trim().toUpperCase().replace(/\s+/g,' ');}
function estValide(t){return /^ARN \d{4}( [A-Z]+)* \d{1,8}$/.test(t);}
function sauvegarder(){
localStorage.setItem('arn_liste',JSON.stringify(listeMatricules));
localStorage.setItem('arn_users',JSON.stringify(listeUsers));
}
function actionCreerCompte(){
var m=normaliser(document.getElementById('input-crea-mat').value);
var p=document.getElementById('input-crea-pass').value;
if(!estValide(m)||listeMatricules.indexOf(m)===-1){alert('Matricule invalide ou non autorisé');return;}
if(p.length<4){alert('Mot de passe trop court');return;}
if(!listeUsers[m])listeUsers[m]={};
listeUsers[m].password=p;
listeUsers[m].matricule=m;
sauvegarder();
matriculeCourant=m;
document.getElementById('fiche-mat').textContent=m;
chargerFiche();
afficherPage('page-fiche');
}
function actionLogin(){
var m=normaliser(document.getElementById('input-login-mat').value);
var p=document.getElementById('input-login-pass').value;
if(!listeUsers[m]||listeUsers[m].password!==p){alert('Matricule ou mot de passe incorrect');return;}
matriculeCourant=m;
document.getElementById('fiche-mat').textContent=m;
chargerFiche();
afficherPage('page-fiche');
}
function actionLoginSec(){
if(document.getElementById('input-sec-pass').value==='ARN2026'){
afficherPage('page-admin');
actionRender();
}else{alert('Mot de passe secrétaire incorrect');}
}
function actionAjouter(){
var m=normaliser(document.getElementById('input-add-mat').value);
if(!estValide(m)){alert('Format invalide. Ex: ARN 2026 PRS 0001');return;}
if(listeMatricules.indexOf(m)===-1){listeMatricules.push(m);listeMatricules.sort();sauvegarder();}
document.getElementById('input-search').value=m;
actionRender();
}
function actionRender(){
var filtre=document.getElementById('input-search').value.toUpperCase();
var aff=[];
if(filtre){
for(var i=0;i<listeMatricules.length;i++){if(listeMatricules[i].indexOf(filtre)!==-1||(listeUsers[listeMatricules[i]]&&listeUsers[listeMatricules[i]].nom&&listeUsers[listeMatricules[i]].nom.toUpperCase().indexOf(filtre)!==-1)){aff.push(listeMatricules[i]);}}
}else{aff=listeMatricules.slice().reverse().slice(0,120);}
var html='<small style=color:#64748b>'+listeMatricules.length+' matricules enregistrés</small>';
for(var j=0;j<aff.length;j++){
var mm=aff[j];
var u=listeUsers[mm]||{};
var nomAffiche=u.nom?u.nom:'<span style=color:#94a3b8>Fiche vide</span>';
html=html+'<div style="border:1px solid #e2e8f0;padding:10px;margin-top:8px;border-radius:10px;display:flex;justify-content:space-between;align-items:center"><div><b>'+mm+'</b><br>'+nomAffiche+'</div><button onclick="actionVoirDetail(\''+mm+'\')" style="background:#1e40af;color:#fff;border:none;padding:8px 14px;border-radius:8px;font-weight:bold">Voir</button></div>';
}
document.getElementById('zone-liste').innerHTML=html;
}
function actionVoirDetail(m){
var u=listeUsers[m]||{};
document.getElementById('zone-detail').style.display='block';
document.getElementById('detail-mat').textContent=m;
var ph=document.getElementById('detail-photo');
if(u.photoProfil){ph.src=u.photoProfil;ph.style.display='block';}else{ph.style.display='none';}
var infos='';
if(u.nom){infos=infos+'<div style=padding:6px 0;border-bottom:1px solid #f1f5f9><b>Nom:</b> '+u.nom+'</div>';}
if(u.fonc){infos=infos+'<div style=padding:6px 0;border-bottom:1px solid #f1f5f9><b>Fonction:</b> '+u.fonc+'</div>';}
if(u.aff){infos=infos+'<div style=padding:6px 0;border-bottom:1px solid #f1f5f9><b>Affectation:</b> '+u.aff+'</div>';}
if(u.signature){infos=infos+'<div style=margin-top:12px><b>Signature:</b><br><img src='+u.signature+' style=width:100%;border:1px solid #000;border-radius:8px;background:#fff;margin-top:6px></div>';}
if(infos==''){infos='<i style=color:#94a3b8>Fiche non remplie</i>';}
document.getElementById('detail-infos').innerHTML=infos;
var nomPourQR=u.nom?u.nom:m;
var lienVerif='https://arn657079-tech.github.io/ARN/?verif='+encodeURIComponent(m);
var contenuQR=nomPourQR+'\n'+lienVerif;
document.getElementById('detail-qr').innerHTML='<img src=https://api.qrserver.com/v1/create-qr-code/?size=240x240&data='+encodeURIComponent(contenuQR)+'>';
}
function chargerFiche(){
var u=listeUsers[matriculeCourant]||{};
document.getElementById('fiche-nom').value=u.nom||'';
document.getElementById('fiche-fonc').value=u.fonc||'';
document.getElementById('fiche-aff').value=u.aff||'';
var img=document.getElementById('fiche-photo');
if(u.photoProfil){img.src=u.photoProfil;img.style.display='block';}else{img.style.display='none';}
var sig=document.getElementById('fiche-sig-img');
if(u.signature){sig.src=u.signature;sig.style.display='block';}else{sig.style.display='none';}
}
function actionSavePhoto(inp){
var f=inp.files[0];if(!f)return;
var r=new FileReader();
r.onload=function(e){
if(!listeUsers[matriculeCourant])listeUsers[matriculeCourant]={};
listeUsers[matriculeCourant].photoProfil=e.target.result;
sauvegarder();
var im=document.getElementById('fiche-photo');im.src=e.target.result;im.style.display='block';
};
r.readAsDataURL(f);
}
function actionSaveFiche(){
if(!listeUsers[matriculeCourant])listeUsers[matriculeCourant]={};
listeUsers[matriculeCourant].nom=document.getElementById('fiche-nom').value;
listeUsers[matriculeCourant].fonc=document.getElementById('fiche-fonc').value;
listeUsers[matriculeCourant].aff=document.getElementById('fiche-aff').value;
listeUsers[matriculeCourant].matricule=matriculeCourant;
sauvegarder();
alert('Fiche enregistrée avec succès Chef !');
}
function actionClearSig(){
var c=document.getElementById('canvas-sig');
c.getContext('2d').clearRect(0,0,c.width,c.height);
}
function actionSaveSig(){
var c=document.getElementById('canvas-sig');
var data=c.toDataURL();
if(data.length<1500){alert('Veuillez dessiner votre signature');return;}
if(!listeUsers[matriculeCourant])listeUsers[matriculeCourant]={};
listeUsers[matriculeCourant].signature=data;
sauvegarder();
var im=document.getElementById('fiche-sig-img');im.src=data;im.style.display='block';
}
(function initSig(){
var c=document.getElementById('canvas-sig');
if(!c)return;
var ctx=c.getContext('2d');
var draw=false;
function getPos(e){
var rect=c.getBoundingClientRect();
var t=e.touches?e.touches[0]:e;
return {x:(t.clientX-rect.left)*(c.width/rect.width), y:(t.clientY-rect.top)*(c.height/rect.height)};
}
c.addEventListener('mousedown',function(e){draw=true;var p=getPos(e);ctx.beginPath();ctx.moveTo(p.x,p.y);});
c.addEventListener('mousemove',function(e){if(!draw)return;var p=getPos(e);ctx.lineTo(p.x,p.y);ctx.lineWidth=2;ctx.stroke();});
c.addEventListener('mouseup',function(){draw=false;});
c.addEventListener('touchstart',function(e){e.preventDefault();draw=true;var p=getPos(e);ctx.beginPath();ctx.moveTo(p.x,p.y);});
c.addEventListener('touchmove',function(e){e.preventDefault();if(!draw)return;var p=getPos(e);ctx.lineTo(p.x,p.y);ctx.lineWidth=2;ctx.stroke();});
c.addEventListener('touchend',function(){draw=false;});
})();
</script>
</body>
</html>
