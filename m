From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Fri, 6 Jan 2006 01:12:52 +0100
Message-ID: <20060106001252.GE3339@elf.ucw.cz>
References: <20060104213405.GC1761@elf.ucw.cz>
	<Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net>
	<20060105215528.GF2095@elf.ucw.cz>
	<20060105221334.GA925@isilmar.linta.de>
	<20060105222338.GG2095@elf.ucw.cz>
	<20060105222705.GA12242@isilmar.linta.de>
	<20060105230849.GN2095@elf.ucw.cz>
	<20060105234629.GA7298@isilmar.linta.de>
	<20060105235838.GC3339@elf.ucw.cz>
	<Pine.LNX.4.50.0601051602560.10428-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============47190783278462023=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0601051602560.10428-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

--===============47190783278462023==
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id k060DFDZ012347

On =C4=8Ct 05-01-06 16:04:07, Patrick Mochel wrote:
>=20
> On Fri, 6 Jan 2006, Pavel Machek wrote:
>=20
> > On P=C3=A1 06-01-06 00:46:29, Dominik Brodowski wrote:
> > > On Fri, Jan 06, 2006 at 12:08:49AM +0100, Pavel Machek wrote:
> > > > Ok, so lets at least add value-checking to .../power file, and pr=
event
> > > > userspace see changes to PM_EVENT_SUSPEND value. 2 and 0 are now
> > > > "arbitrary cookies". I'd like to use "on" and "off", but pcmcia
> > > > apparently depends on "2" and "0", so...
> > > >
> > > > Any objections?
> > >
> > > Sorry, but yes -- the same as before, minus the PCMCIA breakage.
> >
> > I don't understand at this point.
> >
> > Current code takes value from user, and passes it down to driver,
> > without any checking. If user writes 666 into the file, it will
> > happily pass down 666 to the driver. Driver does not expect 666 in
> > pm_message_t.event. It may oops, BUG_ON() or anything like that.
> >
> > Shall I change
> >
> > #define PM_EVENT_SUSPEND 2
> >
> > to
> >
> > #define PM_EVENT_SUSPEND 1324
> >
> > to get my point across? This is kernel-specific value, it should not
> > be exported to userland.
>=20
> A better point, and one that would actually be useful, would be to remo=
ve
> the file altogether. Let Dominik export a power file, with complete
> control over the values, for each pcmcia device. Then you never have to
> worry about breaking PCMCIA again.

Fine with me.

[except that now you we went from supporting 2 runtime device states
to supporting just 1... I don't think this is much of progress...]

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -6,49 +6,6 @@
 #include <linux/string.h>
 #include "power.h"
=20
-
-/**
- *	state - Control current power state of device
- *
- *	show() returns the current power state of the device. '0' indicates
- *	the device is on. Other values (1-3) indicate the device is in a low
- *	power state.
- *
- *	store() sets the current power state, which is an integer value
- *	between 0-3. If the device is on ('0'), and the value written is
- *	greater than 0, then the device is placed directly into the low-power
- *	state (via its driver's ->suspend() method).
- *	If the device is currently in a low-power state, and the value is 0,
- *	the device is powered back on (via the ->resume() method).
- *	If the device is in a low-power state, and a different low-power stat=
e
- *	is requested, the device is first resumed, then suspended into the ne=
w
- *	low-power state.
- */
-
-static ssize_t state_show(struct device * dev, struct device_attribute *=
attr, char * buf)
-{
-	return sprintf(buf, "%u\n", dev->power.power_state.event);
-}
-
-static ssize_t state_store(struct device * dev, struct device_attribute =
*attr, const char * buf, size_t n)
-{
-	pm_message_t state;
-	char * rest;
-	int error =3D 0;
-
-	state.event =3D simple_strtoul(buf, &rest, 10);
-	if (*rest)
-		return -EINVAL;
-	if (state.event)
-		error =3D dpm_runtime_suspend(dev, state);
-	else
-		dpm_runtime_resume(dev);
-	return error ? error : n;
-}
-
-static DEVICE_ATTR(state, 0644, state_show, state_store);
-
-
 /*
  *	wakeup - Report/change current wakeup option for device
  *
@@ -122,7 +79,6 @@ static DEVICE_ATTR(wakeup, 0644, wake_sh
=20
=20
 static struct attribute * power_attrs[] =3D {
-	&dev_attr_state.attr,
 	&dev_attr_wakeup.attr,
 	NULL,
 };

--=20
Thanks, Sharp!

--===============47190783278462023==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============47190783278462023==--
