From: Arioch <the_Arioch-SYPjacQAEmk@public.gmane.org>
Subject: potential pitfall? changing configuration while PC in
	hibernate
Date: Mon, 21 Mar 2005 11:02:04 +0300
Message-ID: <d1lutv$iuj$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============57636913761618747=="
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============57636913761618747==
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

AS: where it counts, by hibernate i mean Suspend-to-disk, not 
suspend-to-RAM.

I wonder, if hardware configuration asked for changes when resuming from 
hibernate ?

I have a notebook with USB1 keyboard-and-hub (Cherry) and an USB2 Flash 
drive.

Keyboard reports it can give 100 mA of current per-port.
USB disk reports it consumes 200 mA.

So de jure this disk is not to be turned on, or at least Linux is to ask 
user if he wants to run this device, even he understands it is risky.
Ok, this question is not for Power-Management forum.

But i remember a couple of pitfalls i met on Windows and do not want to 
see them in Linux.

When i plug this USB dirve into keyboard when Win2003 is running, 
Windows rejects the device since it requests too much power.
But if i put Windows to hibernate, then plug the USB Drive and then 
resume Windows - it forgets to check for power requirements and tunrs 
device on (which is useful, but which is a bug :-) )

So i wonder if there are (planned) some measures to test for hardware 
changes, why PC was hibernated.

Another pitfall was with Win2000 and old notebook (iP266MMX, 64 MB RAM).
I put Win2000 into hibernate.
Then i went to service and upgraded memory.
There was 32Mb onboard + 32Mb as SO-DIMM.
So i changed that module for 128Mb one, and tried to resume Windows 
(yes, a dumb idea and i had to think beforehand - but what if i did not?)

And what i've got was a blocker.
When i resume Windows it usually allows me to enter Advanced options and 
choose to kill hibernated session and to do a cold boot.
This time i just got an error message that RAM amount changed and resume 
is not possible. If i did not try to resume Windows at the service 
center, where i could ask my RAM back to shutdown windows - i would be 
in a very hard situation :-)

IMHO correct behaviour then would be at least to allow user to make a 
cold boot, and the most correct would be giving warning, but them 
resuming and using only 64 MB of total new 160Mb RAM, untill reboot.

Yes, both this examples are quite perverted, but i hope Linux would be 
able to couple even such pitfalls :-)


--===============57636913761618747==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============57636913761618747==--
