From: <rasmit.ranjan@wipro.com>
Subject: Problem with kernel recompilation
Date: Tue, 11 Apr 2006 19:59:46 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB201AFC27E@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============66928915649468257=="
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

--===============66928915649468257==
Content-Type: multipart/alternative;
    boundary="----------=_1144765869-11158-836"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1144765869-11158-836
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

I have a laptop which doesn't have a brandname. It is a 'china make' and
I think is assembled laptop. This laptop uses a promise SATA card, to
which a harddisk is connected. So, during booting it requires a promise
SATA card driver, otherwise Harddisk is not detected properly. I faced
this problem with Windows and Linux installation. I could install  linux
in 3rd attempt. Anyways now the problem is that when i recompiled kernel
2.6.15.4 on the same machine it gives the following kernel panic
message:

****************************************************************

Booting  'Fedora Core 4 (2.16.15.4)'

Root (hd0,4)

 Filesystem type is ext2fs, partition type 0x83

Kernel /boot/vmlinuz-2.6.15.4 ro root=3DLABEL=3D/1 rootfstype=3Dext3
enforcing=3D0 rhgb quiet

 [Linux-bzImage, setup=3D0x1e00, size=3D0x19f457]

Initrd /boot/initrd-2.6.15.4.img

 [Linux-initrd @ 0x1fd67000, 0x128da7 bytes ]

=20

Uncompressing Linux . . . Ok, booting kernel.

PCI: Failed to allocate mem resource #6:20000@d0000000 for 0000:01:00.0

Red Hat nash version 4.2.15 starting

Mkrootdev: label / not found

Mount: error 2 mounting ext3

ERROR opening /dev/console!!!!: 2

Error dup2'ing fd of 0 to 0

Error dup2'ing fd of 0 to 1

Error dup2'ing fd of 0 to 2

Switchroot: mount failed: 22

Kernel Panic - not syncing: Attempted to kill init!

=20
************************************************************************
******************************************************

My grub.conf looks this way:

=20

#boot=3D/dev/sda5

default=3D3

timeout=3D5

splashimage=3D(hd0,4)/boot/grub/splash.xpm.gz

hiddenmenu

title Fedora Core (2.6.11-1.1369_FC4smp)

root (hd0,4)

kernel /boot/vmlinuz-2.6.11-1.1369_FC4smp ro root=3DLABEL=3D/ rhgb quiet

initrd /boot/initrd-2.6.11-1.1369_FC4smp.img

title Fedora Core-up (2.6.11-1.1369_FC4)

root (hd0,4)

kernel /boot/vmlinuz-2.6.11-1.1369_FC4 ro root=3DLABEL=3D/ rhgb quiet

initrd /boot/initrd-2.6.11-1.1369_FC4.img

title Fedora Core 4 (2.6.15.4)

root (hd0,4)

kernel /boot/vmlinuz-2.6.15.4 ro root=3D/dev/sda5 rhgb quiet

initrd /boot/initrd-2.6.15.4.img

title Other

rootnoverify (hd0,0)

chainloader +1

************************************************************************
**

My fdisk -l looks like this:

Disk /dev/sda: 60.0 GB, 60011642880 bytes

255 heads, 63 sectors/track, 7296 cylinders

Units =3D cylinders of 16065 * 512 =3D 8225280 bytes

Device Boot Start End Blocks Id System

/dev/sda1 * 1 3824 30716248+ c W95 FAT32 (LBA)

/dev/sda2 3825 7295 27880807+ f W95 Ext'd (LBA)

/dev/sda5 3825 7167 26852616 83 Linux

/dev/sda6 7168 7294 1020096 82 Linux swap / Solaris

And the fstab entry looks like this :

# This file is edited by fstab-sync - see 'man fstab-sync' for details

LABEL=3D/ / ext3 defaults 1 1

/dev/devpts /dev/pts devpts gid=3D5,mode=3D620 0 0

/dev/shm /dev/shm tmpfs defaults 0 0

/dev/proc /proc proc defaults 0 0

/dev/sys /sys sysfs defaults 0 0

LABEL=3DSWAP-sda6 swap swap defaults 0 0

/dev/hdb /media/cdrecorder auto pamconsole,exec,noauto,managed 0 0

************************************************************************
****************************************************

What could be the reason for this??

Regards,

Rasmit Ranjan Swain.


------------=_1144765869-11158-836
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2>
<DIV>
<P class=3DMsoNormal><SPAN=20
DEFANGED_style=3D"FONT-SIZE: 10pt; COLOR: blue; FONT-FAMILY: 'Trebuchet MS'=
"><SPAN=20
class=3D254140814-11042006><SPAN class=3D176022914-11042006>Hi=20
all,</SPAN></SPAN></SPAN></P>
<P class=3DMsoNormal><SPAN=20
DEFANGED_style=3D"FONT-SIZE: 10pt; COLOR: blue; FONT-FAMILY: 'Trebuchet MS'=
"><SPAN=20
class=3D254140814-11042006><SPAN class=3D176022914-11042006></SPAN>I have a=
=20
</SPAN>laptop&nbsp;<SPAN class=3D254140814-11042006>which</SPAN> doe<SPAN=
=20
class=3D254140814-11042006>s</SPAN>n&#8217;t have a brandname. It is a &#82=
16;china make&#8217; and=20
I think is assembled laptop. This laptop uses a promise SATA card, to which=
 a=20
harddisk is connected. So, during booting it requires a promise SATA card=
=20
driver, otherwise Harddisk is not detected properly. I faced this problem w=
ith=20
Windows and Linux installation. I could install&nbsp; linux in 3<SUP>rd</SU=
P>=20
attempt.&nbsp;<SPAN class=3D254140814-11042006>Anyways now the problem is t=
hat=20
when i recompiled kernel 2.6.15.4 on the same machine it gives the followin=
g=20
kernel panic message:</SPAN></SPAN></P><SPAN=20
DEFANGED_style=3D"FONT-SIZE: 10pt; COLOR: blue; FONT-FAMILY: 'Trebuchet MS'=
">
<P class=3DMsoNormal><SPAN=20
DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New'"><SPAN=20
class=3D254140814-11042006>************************************************=
****************</SPAN></SPAN></P>
<P class=3DMsoNormal><FONT face=3D"Courier New" size=3D3><SPAN=20
DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New'">Booting&nbsp=
; &#8216;Fedora Core 4=20
(2.16.15.4)&#8217;<?xml:namespace prefix =3D o ns =3D=20
"urn:schemas-microsoft-com:office:office" /><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D"Courier New" size=3D3><SPAN=20
DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New'">Root=20
(hd0,4)<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D"Courier New" size=3D3><SPAN=20
DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New'">&nbsp;Filesy=
stem type is=20
ext2fs, partition type 0x83<o:p></o:p></SPAN></FONT></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN-BOTTOM: 6pt"><FONT face=3D"=
Courier New"=20
size=3D3><SPAN DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New=
'">Kernel=20
/boot/vmlinuz-2.6.15.4 ro root=3DLABEL=3D/1 rootfstype=3Dext3 enforcing=3D0=
 rhgb=20
quiet<o:p></o:p></SPAN></FONT></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN-BOTTOM: 6pt"><FONT face=3D"=
Courier New"=20
size=3D3><SPAN=20
DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New'">&nbsp;[Linux=
-bzImage,=20
setup=3D0x1e00, size=3D0x19f457]<o:p></o:p></SPAN></FONT></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN-BOTTOM: 6pt"><FONT face=3D"=
Courier New"=20
size=3D3><SPAN DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New=
'">Initrd=20
/boot/initrd-2.6.15.4.img<o:p></o:p></SPAN></FONT></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN-BOTTOM: 6pt"><FONT face=3D"=
Courier New"=20
size=3D3><SPAN=20
DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New'">&nbsp;[Linux=
-initrd @=20
0x1fd67000, 0x128da7 bytes ]<o:p></o:p></SPAN></FONT></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN-BOTTOM: 6pt"><FONT face=3D"=
Courier New"=20
size=3D3><SPAN=20
DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New'"><o:p>&nbsp;<=
/o:p></SPAN></FONT></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN-BOTTOM: 6pt"><FONT face=3D"=
Courier New"=20
size=3D3><SPAN DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New=
'">Uncompressing=20
Linux . . . Ok, booting kernel.<o:p></o:p></SPAN></FONT></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN-BOTTOM: 6pt"><FONT face=3D"=
Courier New"=20
size=3D3><SPAN DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New=
'">PCI: Failed to=20
allocate mem resource #6:20000@d0000000 for=20
0000:01:00.0<o:p></o:p></SPAN></FONT></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN-BOTTOM: 6pt"><FONT face=3D"=
Courier New"=20
size=3D3><SPAN DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New=
'">Red Hat nash=20
version 4.2.15 starting<o:p></o:p></SPAN></FONT></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN-BOTTOM: 6pt"><FONT face=3D"=
Courier New"=20
size=3D3><SPAN DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New=
'">Mkrootdev:=20
label / not found<o:p></o:p></SPAN></FONT></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN-BOTTOM: 6pt"><FONT face=3D"=
Courier New"=20
size=3D3><SPAN DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New=
'">Mount: error 2=20
mounting ext3<o:p></o:p></SPAN></FONT></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN-BOTTOM: 6pt"><FONT face=3D"=
Courier New"=20
size=3D3><SPAN DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New=
'">ERROR opening=20
/dev/console!!!!: 2<o:p></o:p></SPAN></FONT></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN-BOTTOM: 6pt"><FONT face=3D"=
Courier New"=20
size=3D3><SPAN DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New=
'">Error dup2&#8217;ing=20
fd of 0 to 0<o:p></o:p></SPAN></FONT></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN-BOTTOM: 6pt"><FONT face=3D"=
Courier New"=20
size=3D3><SPAN DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New=
'">Error dup2&#8217;ing=20
fd of 0 to 1<o:p></o:p></SPAN></FONT></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN-BOTTOM: 6pt"><FONT face=3D"=
Courier New"=20
size=3D3><SPAN DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New=
'">Error dup2&#8217;ing=20
fd of 0 to 2<o:p></o:p></SPAN></FONT></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN-BOTTOM: 6pt"><FONT face=3D"=
Courier New"=20
size=3D3><SPAN DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New=
'">Switchroot:=20
mount failed: 22<o:p></o:p></SPAN></FONT></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN-BOTTOM: 6pt"><FONT face=3D"=
Courier New"=20
size=3D3><SPAN DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New=
'">Kernel Panic &#8211;=20
not syncing: Attempted to kill init!<o:p></o:p></SPAN></FONT></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN-BOTTOM: 6pt"><FONT face=3D"=
Courier New"=20
size=3D3><SPAN=20
DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New'"><o:p>&nbsp;<=
SPAN=20
class=3D254140814-11042006><FONT face=3DArial color=3D#000000=20
size=3D2>******************************************************************=
************************************************************</FONT></SPAN><=
/o:p></SPAN></FONT></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN-BOTTOM: 6pt"><FONT face=3DA=
rial color=3D#000000=20
size=3D2><SPAN DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New=
'"><o:p><SPAN=20
class=3D254140814-11042006>My grub.conf looks this=20
way:</SPAN></o:p></SPAN></FONT></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"MARGIN-BOTTOM: 6pt"><FONT face=3DA=
rial color=3D#000000=20
size=3D2><SPAN DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New=
'"><o:p><SPAN=20
class=3D254140814-11042006></SPAN></o:p></SPAN></FONT>&nbsp;</P><FONT face=
=3DArial=20
size=3D2><SPAN DEFANGED_style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Courier New=
'"><o:p><SPAN=20
class=3D254140814-11042006>
<P><FONT color=3D#000000 size=3D2>#boot=3D/dev/sda5</FONT></P>
<P><FONT color=3D#000000 size=3D2>default=3D3</FONT></P>
<P><FONT color=3D#000000 size=3D2>timeout=3D5</FONT></P>
<P><FONT color=3D#000000=20
size=3D2>splashimage=3D(hd0,4)/boot/grub/splash.xpm.gz</FONT></P>
<P><FONT color=3D#000000 size=3D2>hiddenmenu</FONT></P>
<P><FONT color=3D#000000 size=3D2>title Fedora Core=20
(2.6.11-1.1369_FC4smp)</FONT></P>
<P><FONT color=3D#000000 size=3D2>root (hd0,4)</FONT></P>
<P><FONT color=3D#000000 size=3D2>kernel /boot/vmlinuz-2.6.11-1.1369_FC4smp=
 ro=20
root=3DLABEL=3D/ rhgb quiet</FONT></P>
<P><FONT color=3D#000000 size=3D2>initrd=20
/boot/initrd-2.6.11-1.1369_FC4smp.img</FONT></P>
<P><FONT color=3D#000000 size=3D2>title Fedora Core-up=20
(2.6.11-1.1369_FC4)</FONT></P>
<P><FONT color=3D#000000 size=3D2>root (hd0,4)</FONT></P>
<P><FONT color=3D#000000 size=3D2>kernel /boot/vmlinuz-2.6.11-1.1369_FC4 ro=
=20
root=3DLABEL=3D/ rhgb quiet</FONT></P>
<P><FONT color=3D#000000 size=3D2>initrd=20
/boot/initrd-2.6.11-1.1369_FC4.img</FONT></P>
<P><FONT color=3D#000000 size=3D2>title Fedora Core 4 (2.6.15.4)</FONT></P>
<P><FONT color=3D#000000 size=3D2>root (hd0,4)</FONT></P>
<P><FONT color=3D#000000 size=3D2>kernel /boot/vmlinuz-2.6.15.4 ro root=3D/=
dev/sda5=20
rhgb quiet</FONT></P>
<P><FONT color=3D#000000 size=3D2>initrd /boot/initrd-2.6.15.4.img</FONT></=
P>
<P><FONT color=3D#000000 size=3D2>title Other</FONT></P>
<P><FONT color=3D#000000 size=3D2>rootnoverify (hd0,0)</FONT></P>
<P><FONT color=3D#000000 size=3D2>chainloader +1</FONT></P>
<P><SPAN class=3D254140814-11042006><FONT color=3D#000000=20
size=3D2>******************************************************************=
********</FONT></SPAN></P>
<P><SPAN class=3D254140814-11042006><FONT color=3D#000000 size=3D2>My fdisk=
&nbsp;-l=20
looks like this:</FONT></SPAN></P><SPAN class=3D254140814-11042006>
<P><FONT size=3D2>Disk /dev/sda: 60.0 GB, 60011642880 bytes</FONT></P>
<P><FONT size=3D2>255 heads, 63 sectors/track, 7296 cylinders</FONT></P>
<P><FONT size=3D2>Units =3D cylinders of 16065 * 512 =3D 8225280 bytes</FON=
T></P>
<P><FONT size=3D2>Device Boot Start End Blocks Id System</FONT></P>
<P><FONT size=3D2>/dev/sda1 * 1 3824 30716248+ c W95 FAT32 (LBA)</FONT></P>
<P><FONT size=3D2>/dev/sda2 3825 7295 27880807+ f W95 Ext'd (LBA)</FONT></P>
<P><FONT size=3D2>/dev/sda5 3825 7167 26852616 83 Linux</FONT></P>
<P><FONT size=3D2>/dev/sda6 7168 7294 1020096 82 Linux swap / Solaris</FONT=
></P>
<P><SPAN class=3D254140814-11042006><FONT face=3DArial color=3D#000000 size=
=3D2>And the=20
fstab entry looks like this :</FONT></SPAN></P><SPAN class=3D254140814-1104=
2006>
<P><FONT size=3D2># This file is edited by fstab-sync - see 'man fstab-sync=
' for=20
details</FONT></P>
<P><FONT size=3D2>LABEL=3D/ / ext3 defaults 1 1</FONT></P>
<P><FONT size=3D2>/dev/devpts /dev/pts devpts gid=3D5,mode=3D620 0 0</FONT>=
</P>
<P><FONT size=3D2>/dev/shm /dev/shm tmpfs defaults 0 0</FONT></P>
<P><FONT size=3D2>/dev/proc /proc proc defaults 0 0</FONT></P>
<P><FONT size=3D2>/dev/sys /sys sysfs defaults 0 0</FONT></P>
<P><FONT size=3D2>LABEL=3DSWAP-sda6 swap swap defaults 0 0</FONT></P>
<P><FONT size=3D2>/dev/hdb /media/cdrecorder auto pamconsole,exec,noauto,ma=
naged 0=20
0</FONT></P>
<P><SPAN class=3D254140814-11042006><FONT face=3DArial color=3D#000000=20
size=3D2>******************************************************************=
**********************************************************</FONT></SPAN></P>
<P><FONT face=3DArial color=3D#000000 size=3D2><SPAN class=3D254140814-1104=
2006>What=20
could be the reason for=20
this??</SPAN></FONT></P></SPAN></SPAN></SPAN></o:p></SPAN></FONT></SPAN>
<P class=3DMsoNormal><SPAN=20
DEFANGED_style=3D"FONT-SIZE: 10pt; COLOR: blue; FONT-FAMILY: 'Trebuchet MS'=
"></SPAN><EM><FONT=20
color=3D#ff0000>Regards<SPAN class=3D176022914-11042006>,</SPAN></FONT></EM=
></P>
<P class=3DMsoNormal><EM><FONT color=3D#ff0000><SPAN class=3D176022914-1104=
2006>Rasmit=20
Ranjan Swain.</SPAN></FONT></EM></P></DIV></FONT></DIV></BODY></HTML>

------------=_1144765869-11158-836--

--===============66928915649468257==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============66928915649468257==--
