From: "David GIGUET" <david.giguet@sagem.com>
Subject: New comer in the linux-pm list
Date: Thu, 20 Nov 2008 13:40:56 +0100
Message-ID: <OF87B4B960.116849D3-ONC1257507.00457478-C1257507.0045AAE5@sagem.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0826026101782601763=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Olivier LE ROY <olivier.leroy@sagem.com>, Kanider GUENDOUZI <kanider.guendouzi@sagem.com>
List-Id: linux-pm@vger.kernel.org

--===============0826026101782601763==
Content-Type: multipart/alternative; boundary="=_alternative 0045AAE1C1257507_="

--=_alternative 0045AAE1C1257507_=
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

I am forwarding an e-mail from N. PAJANI, one of our collaborator.

Hi all

I have made some googling and read some code from the kernel, but I did=20
not managed to find a "power management scheme" outside of APM or ACPI to=20
fit my needs.
My goal is to have something relevent for embeded devices (or at least=20
battery powered), not only servers, desktop or laptops, though it may=20
apply to these.

For example on a cellphone, when you switch to "silent mode" what need do=20
you have to power the audio amplifier, and maybe the audio module inside=20
the SOC may be stopped, saving more power.
Or fully powering Wifi or Ethernet when they are not in use on a "netbook" =

is also an unuseful loss of power.

But from my trips on the net I did not find any way to stop drivers=20
individually.

I'm working on ARM right now, but this is relevent for any architecture,=20
even x86 (from what I understand, ACPI does system level power management, =

not device level, but using an ACPI compliant way would be best if=20
possible).
I have thought of not loading the drivers for the unwanted devices, but I=20
figured out that this is not the right solution, first because we don't=20
know the state of the device when we come to run on the hardware, secondly =

because most of the drivers just unregister themselves upon unload, and=20
don't really turn off the device.

I have not yet gone deep inside the kernel to look for what's already=20
there, but I'd like some advices from others on how to create the new=20
functionnality I need.
If in fact I'm asking something that has already been discussed somewhere=20
else, please let me know where, so I can have a look.

Here is what I have planned for the implementation:

Use the existing functionnalities and layout created by=20
"drivers/base/power/main.c" and implement some callbacks in sysfs so that=20
any device may be suspended or resumed individually.

First,
The sysfs tree will gain a /sys/*pm*/ directory (replace *pm* by a name we =

should define)
This directory will contain links to some of the=20
/sys/****per=5Fdevice***/power/ directories (those able to perform=20
powermanagement). The goal behind this is to allow userspace programs to=20
find quickly which devices are "individual power management capable". It=20
may be a complete bus (PCI for example) if the bus is capable of handling=20
dependencies (shutting down all of his devices for example).

Then,
* Add in the device's power dir a way to call the suspend and resume, so=20
that the device can be shut down and resumed individually.
* Move any existing callback related to power management in the device's=20
dir to the power dir (in my case for example, the LCD backlight brightness =

and backlight power callbacks).
* Add a /sys/****per=5Fdevice***/power/capabilities/ directory containing=20
read-only files with a syntax to be defined to advertise for capabilities=20
(min/max levels, on/off, ... ?)

If anyone is interrested in this, can contribute ideas, or has already=20
done this (even in another way), please feel free to give some info here.

If you want to say this is madness, but don't give hint of what's the=20
better way, please save your time (and mine).

Thanks.
And have fun :)
+++


" Ce courriel et les documents qui y sont attaches peuvent contenir des inf=
ormations confidentielles. Si vous n'etes  pas le destinataire escompte, me=
rci d'en informer l'expediteur immediatement et de detruire ce courriel  ai=
nsi que tous les documents attaches de votre systeme informatique. Toute di=
vulgation, distribution ou copie du present courriel et des documents attac=
hes sans autorisation prealable de son emetteur est interdite."=20

" This e-mail and any attached documents may contain confidential or propri=
etary information. If you are not the intended recipient, please advise the=
 sender immediately and delete this e-mail and all attached documents from =
your computer system. Any unauthorised disclosure, distribution or copying =
hereof is prohibited."
--=_alternative 0045AAE1C1257507_=
Content-Type: text/html; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">I am forwarding an e-mail from N. PA=
JANI,
one of our collaborator.</font><div><br><br><font size=3D3>Hi all</font><br=
><br><font size=3D3>I have made some googling and read some code from the
kernel, but I did not managed to find a &quot;power management scheme&quot;
outside of APM or ACPI to fit my needs.</font><br><font size=3D3>My goal is=
 to have something relevent for embeded devices
(or at least battery powered), not only servers, desktop or laptops, though
it may apply to these.</font><br><br><font size=3D3>For example on a cellph=
one, when you switch to &quot;silent
mode&quot; what need do you have to power the audio amplifier, and maybe
the audio module inside the SOC may be stopped, saving more power.</font><b=
r><font size=3D3>Or fully powering Wifi or Ethernet when they are not in
use on a &quot;netbook&quot; is also an unuseful loss of power.</font><br><=
br><font size=3D3>But from my trips on the net I did not find any way to
stop drivers individually.</font><br><br><font size=3D3>I'm working on ARM =
right now, but this is relevent for
any architecture, even x86 (from what I understand, ACPI does system level
power management, not device level, but using an ACPI compliant way would
be best if possible).</font><br><font size=3D3>I have thought of not loadin=
g the drivers for the unwanted
devices, but I figured out that this is not the right solution, first becau=
se
we don't know the state of the device when we come to run on the hardware,
secondly because most of the drivers just unregister themselves upon unload,
and don't really turn off the device.</font><br><br><font size=3D3>I have n=
ot yet gone deep inside the kernel to look for
what's already there, but I'd like some advices from others on how to create
the new functionnality I need.</font><br><font size=3D3>If in fact I'm aski=
ng something that has already been
discussed somewhere else, please let me know where, so I can have a look.</=
font><br><br><font size=3D3>Here is what I have planned for the implementat=
ion:</font><br><br><font size=3D3>Use the existing functionnalities and lay=
out created by
&quot;drivers/base/power/main.c&quot; and implement some callbacks in sysfs
so that any device may be suspended or resumed individually.</font><br><br>=
<font size=3D3>First,</font><br><font size=3D3>The sysfs tree will gain a /=
sys/*pm*/ directory (replace
*pm* by a name we should define)</font><br><font size=3D3>This directory wi=
ll contain links to some of the /sys/****per=5Fdevice***/power/
directories (those able to perform powermanagement). The goal behind this
is to allow userspace programs to find quickly which devices are &quot;indi=
vidual
power management capable&quot;. It may be a complete bus (PCI for example)
if the bus is capable of handling dependencies (shutting down all of his
devices for example).</font><br><br><font size=3D3>Then,</font><br><font si=
ze=3D3>* Add in the device's power dir a way to call the suspend
and resume, so that the device can be shut down and resumed individually.</=
font><br><font size=3D3>* Move any existing callback related to power manag=
ement
in the device's dir to the power dir (in my case for example, the LCD backl=
ight
brightness and backlight power callbacks).</font><br><font size=3D3 face=3D=
"Times New Roman">* Add a </font><font size=3D3>/sys/****per=5Fdevice***/po=
wer/capabilities/
directory containing read-only files with a syntax to be defined to adverti=
se
for capabilities (min/max levels, on/off, ... ?)</font><br><br><font size=
=3D3>If anyone is interrested in this, can contribute ideas,
or has already done this (even in another way), please feel free to give
some info here.</font><br><br><font size=3D3>If you want to say this is mad=
ness, but don't give hint
of what's the better way, please save your time (and mine).</font><br><br><=
font size=3D3>Thanks.</font><br><font size=3D3>And have fun :)</font><br><f=
ont size=3D3>+++</font></div><BR>
<BR>
&quot; Ce courriel et les documents qui y sont attaches peuvent contenir de=
s informations confidentielles. Si vous n'etes  pas le destinataire escompt=
e, merci d'en informer l'expediteur immediatement et de detruire ce courrie=
l  ainsi que tous les documents attaches de votre systeme informatique. Tou=
te divulgation, distribution ou copie du present courriel et des documents =
attaches sans autorisation prealable de son emetteur est interdite.&quot; <=
BR>
<BR>
&quot; This e-mail and any attached documents may contain confidential or p=
roprietary information. If you are not the intended recipient, please advis=
e the sender immediately and delete this e-mail and all attached documents =
from your computer system. Any unauthorised disclosure, distribution or cop=
ying hereof is prohibited.&quot;<BR>
--=_alternative 0045AAE1C1257507_=--

--===============0826026101782601763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0826026101782601763==--
