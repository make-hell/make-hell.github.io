
const words=['Embedded Engineer','PCB Designer','Automation Developer','Product Builder'];
let i=0,j=0,deleting=false;
const el=document.getElementById('typing');

function tick(){
const word=words[i];
el.textContent=word.substring(0,j);

if(!deleting){j++; if(j>word.length){deleting=true;setTimeout(tick,1000);return;}}
else{j--; if(j===0){deleting=false;i=(i+1)%words.length;}}

setTimeout(tick,deleting?50:100);
}
tick();
