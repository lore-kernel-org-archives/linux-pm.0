From: <rasmit.ranjan@wipro.com>
Subject: swsusp1 not working
Date: Fri, 30 Dec 2005 09:57:50 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB2012F4CFC@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============052669730686415894=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format...

--===============052669730686415894==
Content-Type: multipart/alternative;
    boundary="----------=_1135917005-28570-631"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1135917005-28570-631
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,
    i am new to linux power management system. my requirement is to put
my system in low power mode.
so i tried swsusp1 and suspend2. in my system suspend2 works properly.
but i am getting problem with
swsusp1.
i am using linux-2.6.13.3. stpes i followed for swsusp1 are:
    -- compiled my kernel with software suspend,power management and
acpi enabled
    -- added the following line to my grub.conf as kernel parameter.
            resume=3Dswap:/dev/hdb2     ( /dev/hdb2 is my swap partition )
    --executed the following command=20
            echo shutdown > /sys/power/disk
            echo disk > /sys/power/state
=20
my system did not suspend and i got the following message ( looking into
dmesg )
=20=20=20=20=20=20
    PM: suspend-to-disk mode set to 'shutdown'
    Freeing memory...  ^H-^Hdone (6139 pages freed)
    ACPI: PCI interrupt for device 0000:00:0c.0 disabled
    PM: Attempting to suspend to disk.
    PM: snapshotting memory.
    swsusp: FATAL: cannot find swap device, try swapon -a!

        then i thought my swap partition is not active. so i executed
"swapon -a" command to do so.
but still i got the same set of messages. i hope my swap space is enough
to store the image as=20
suspend2 is working properly.
       another thing is standby option is working properly.that is when
i executed the following=20
            echo standby > /sys/power/state.
This worked and my system suspended and resumed as well.
so please suggest where things went wrong in doing swsusp1. Thanks in
advance.
=20
Thanks and regards,
=20
Rasmit Ranjan Swain.
Project Engineer.=20
Semiconductors and Consumer Electronics.
Wipro Technologies.
=20
=20

------------=_1135917005-28570-631
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2769" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D021305902-30122005>Hello,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D021305902-30122005>&nbsp;&nb=
sp;&nbsp; i=20
am new to linux power management system. my requirement is to put my system=
 in=20
low power mode.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D021305902-30122005>so i trie=
d swsusp1=20
and suspend2. in my system suspend2 works properly. but i am getting proble=
m=20
with</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D021305902-30122005>swsusp1.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D021305902-30122005>i am usin=
g=20
linux-2.6.13.3. </SPAN></FONT><FONT face=3DArial size=3D2><SPAN=20
class=3D021305902-30122005>stpes i followed for swsusp1 are:</SPAN></FONT><=
/DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D021305902-30122005>&nbsp;&nb=
sp;&nbsp;=20
-- compiled my kernel with software suspend,power management and acpi=20
enabled</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D021305902-30122005>&nbsp;&nb=
sp;&nbsp;=20
-- added the following line to my grub.conf as kernel=20
parameter.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D021305902-30122005>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;=20
resume=3Dswap:/dev/hdb2&nbsp;&nbsp;&nbsp;&nbsp; ( /dev/hdb2 is my swap part=
ition=20
)</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D021305902-30122005>&nbsp;&nb=
sp;&nbsp;=20
--executed the following command </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D021305902-30122005>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;=20
echo shutdown &gt; /sys/power/disk</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D021305902-30122005>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;=20
echo disk &gt; /sys/power/state</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D021305902-30122005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D021305902-30122005>my system=
 did not=20
suspend and i got the following message ( looking into dmesg=20
)</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D021305902-30122005>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</SPAN></FON=
T></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D021305902-30122005>&nbsp;&nb=
sp;&nbsp;=20
<STRONG>PM: suspend-to-disk mode set to 'shutdown'<BR>&nbsp;&nbsp;&nbsp; Fr=
eeing=20
memory...&nbsp; ^H-^Hdone (6139 pages freed)<BR>&nbsp;&nbsp;&nbsp; ACPI: PC=
I=20
interrupt for device 0000:00:0c.0 disabled<BR>&nbsp;&nbsp;&nbsp; PM: Attemp=
ting=20
to suspend to disk.<BR>&nbsp;&nbsp;&nbsp; PM: snapshotting=20
memory.<BR>&nbsp;&nbsp;&nbsp; swsusp: FATAL: cannot find swap device, try s=
wapon=20
-a!<BR></STRONG></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D021305902-30122005>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; then =
i=20
thought my swap partition is not active. so i&nbsp;executed "swapon -a" com=
mand=20
to do so.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D021305902-30122005>but still=
 i got the=20
same set of messages. i hope my swap space is enough to store the image as=
=20
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D021305902-30122005>suspend2 =
is working=20
properly.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D021305902-30122005>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;anothe=
r thing=20
is standby option is working properly.that is when i executed the following=
=20
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D021305902-30122005>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;=20
echo standby &gt; /sys/power/state.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D021305902-30122005>This work=
ed and my=20
system suspended and resumed as well.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D021305902-30122005>so please=
 suggest=20
where things went wrong in doing swsusp1. Thanks in advance.</SPAN></FONT><=
/DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D021305902-30122005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D021305902-30122005>Thanks an=
d=20
regards,</SPAN></FONT></DIV>
<DIV><FONT><SPAN class=3D021305902-30122005>
<DIV align=3Dleft><FONT face=3DArial color=3D#0080ff size=3D2></FONT>&nbsp;=
</DIV>
<DIV align=3Dleft><FONT><FONT face=3DArial><FONT color=3D#0080ff><FONT size=
=3D2>Rasmit=20
Ranjan Swain<SPAN=20
class=3D021305902-30122005>.</SPAN></FONT></FONT></FONT></FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial color=3D#0080ff size=3D2>Project Engin=
eer<SPAN=20
class=3D021305902-30122005>.</SPAN> </FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial><FONT color=3D#0080ff><FONT=20
size=3D2>Semiconductor<SPAN class=3D021305902-30122005>s</SPAN> and Consume=
r=20
Electronics<SPAN class=3D021305902-30122005>.</SPAN></FONT></FONT></FONT></=
DIV>
<DIV align=3Dleft><FONT face=3DArial><FONT color=3D#0080ff><FONT size=3D2>W=
ipro=20
Technologies<SPAN class=3D021305902-30122005>.</SPAN></FONT></FONT></FONT><=
/DIV>
<DIV align=3Dleft><FONT face=3DArial color=3D#0080ff size=3D2><SPAN=20
class=3D021305902-30122005></SPAN></FONT>&nbsp;</DIV>
<DIV align=3Dleft><FONT face=3DArial color=3D#0080ff=20
size=3D2></FONT>&nbsp;</DIV></DIV></SPAN></FONT></BODY></HTML>

------------=_1135917005-28570-631--

--===============052669730686415894==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============052669730686415894==--
