From: zhan han <zhanhan.cn@gmail.com>
Subject: power_supply: bq27x00: suggest to add battery_lock to
	bq27x00_read.
Date: Thu, 17 Nov 2011 11:59:25 +0800
Message-ID: <CAKyoWo89Khk830hStof5vYOBs7-xn4u0NchUHV5vPHO8MaKGEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7225437631921905704=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============7225437631921905704==
Content-Type: multipart/alternative; boundary=20cf305640cf138c7304b1e63f47

--20cf305640cf138c7304b1e63f47
Content-Type: text/plain; charset=ISO-8859-1

bq27x00 could return abnormal data when bq27x00_read called by multiple
processes at the same time,
when applications access capacity, voltage and temperature frequently.
to make sure that not running bq27x00_read before previous return, add
battery_lock to avoid this:

--- bq27x00_battery.c.orig      2011-11-17 09:53:51.564690000 +0800
+++ bq27x00_battery.c   2011-11-17 10:00:26.768690000 +0800
@@ -129,10 +129,19 @@
  * Common code for BQ27x00 devices
  */

-static inline int bq27x00_read(struct bq27x00_device_info *di, u8 reg,
+/* To avoid running multiple bq27x00_read return with abnormal data,
+   add battery_lock mutex. --H.Z
+*/
+static DEFINE_MUTEX(battery_lock);
+
+static int bq27x00_read(struct bq27x00_device_info *di, u8 reg,
                bool single)
 {
-       return di->bus.read(di, reg, single);
+       int ret;
+       mutex_lock(&battery_lock);
+       ret = di->bus.read(di, reg, single);
+       mutex_unlock(&battery_lock);
+       return ret;
 }

--20cf305640cf138c7304b1e63f47
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div style=3D"border-collapse: collapse; font-family: arial, sans-serif; fo=
nt-size: 13px; ">bq27x00 could return abnormal data when bq27x00_read calle=
d by multiple processes at the same time,</div><div style=3D"border-collaps=
e: collapse; font-family: arial, sans-serif; font-size: 13px; ">
when applications access capacity, voltage and temperature frequently.=A0</=
div><div style=3D"border-collapse: collapse; font-family: arial, sans-serif=
; font-size: 13px; ">to make sure that not running bq27x00_read before prev=
ious return, add battery_lock to avoid this:</div>
<div style=3D"border-collapse: collapse; font-family: arial, sans-serif; fo=
nt-size: 13px; "><meta http-equiv=3D"content-type" content=3D"text/html; ch=
arset=3Dutf-8"><br></div><div><div><font class=3D"Apple-style-span" face=3D=
"arial, sans-serif"><span class=3D"Apple-style-span" style=3D"border-collap=
se: collapse;">--- bq27x00_battery.c.orig =A0 =A0 =A02011-11-17 09:53:51.56=
4690000 +0800</span></font></div>
<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span clas=
s=3D"Apple-style-span" style=3D"border-collapse: collapse;">+++ bq27x00_bat=
tery.c =A0 2011-11-17 10:00:26.768690000 +0800</span></font></div><div><fon=
t class=3D"Apple-style-span" face=3D"arial, sans-serif"><span class=3D"Appl=
e-style-span" style=3D"border-collapse: collapse;">@@ -129,10 +129,19 @@</s=
pan></font></div>
<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span clas=
s=3D"Apple-style-span" style=3D"border-collapse: collapse;">=A0=A0* Common =
code for BQ27x00 devices</span></font></div><div><font class=3D"Apple-style=
-span" face=3D"arial, sans-serif"><span class=3D"Apple-style-span" style=3D=
"border-collapse: collapse;">=A0=A0*/</span></font></div>
<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span clas=
s=3D"Apple-style-span" style=3D"border-collapse: collapse;"><br></span></fo=
nt></div><div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><=
span class=3D"Apple-style-span" style=3D"border-collapse: collapse;">-stati=
c inline int bq27x00_read(struct bq27x00_device_info *di, u8 reg,</span></f=
ont></div>
<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span clas=
s=3D"Apple-style-span" style=3D"border-collapse: collapse;">+/* To avoid ru=
nning multiple bq27x00_read return with abnormal data,</span></font></div><=
div>
<font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span class=3D"=
Apple-style-span" style=3D"border-collapse: collapse;">+ =A0 add battery_lo=
ck mutex. --H.Z</span></font></div><div><font class=3D"Apple-style-span" fa=
ce=3D"arial, sans-serif"><span class=3D"Apple-style-span" style=3D"border-c=
ollapse: collapse;">+*/</span></font></div>
<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span clas=
s=3D"Apple-style-span" style=3D"border-collapse: collapse;">+static DEFINE_=
MUTEX(battery_lock);</span></font></div><div><font class=3D"Apple-style-spa=
n" face=3D"arial, sans-serif"><span class=3D"Apple-style-span" style=3D"bor=
der-collapse: collapse;">+</span></font></div>
<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span clas=
s=3D"Apple-style-span" style=3D"border-collapse: collapse;">+static int bq2=
7x00_read(struct bq27x00_device_info *di, u8 reg,</span></font></div><div><=
font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span class=3D"A=
pple-style-span" style=3D"border-collapse: collapse;">=A0=A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0bool single)</span></font></div>
<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span clas=
s=3D"Apple-style-span" style=3D"border-collapse: collapse;">=A0{</span></fo=
nt></div><div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><=
span class=3D"Apple-style-span" style=3D"border-collapse: collapse;">- =A0 =
=A0 =A0 return di-&gt;bus.read(di, reg, single);</span></font></div>
<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span clas=
s=3D"Apple-style-span" style=3D"border-collapse: collapse;">+ =A0 =A0 =A0 i=
nt ret;</span></font></div><div><font class=3D"Apple-style-span" face=3D"ar=
ial, sans-serif"><span class=3D"Apple-style-span" style=3D"border-collapse:=
 collapse;">+ =A0 =A0 =A0 mutex_lock(&amp;battery_lock);</span></font></div=
>
<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span clas=
s=3D"Apple-style-span" style=3D"border-collapse: collapse;">+ =A0 =A0 =A0 r=
et =3D di-&gt;bus.read(di, reg, single);</span></font></div><div><font clas=
s=3D"Apple-style-span" face=3D"arial, sans-serif"><span class=3D"Apple-styl=
e-span" style=3D"border-collapse: collapse;">+ =A0 =A0 =A0 mutex_unlock(&am=
p;battery_lock);</span></font></div>
<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span clas=
s=3D"Apple-style-span" style=3D"border-collapse: collapse;">+ =A0 =A0 =A0 r=
eturn ret;</span></font></div><div><font class=3D"Apple-style-span" face=3D=
"arial, sans-serif"><span class=3D"Apple-style-span" style=3D"border-collap=
se: collapse;">=A0}</span></font></div>
</div><div style=3D"border-collapse: collapse; font-family: arial, sans-ser=
if; font-size: 13px; "><br></div>

--20cf305640cf138c7304b1e63f47--

--===============7225437631921905704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7225437631921905704==--
