From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Userspace interface breakage in power/state
Date: Mon, 16 Jan 2006 21:22:10 +0100
Message-ID: <200601162122.10684.rjw@sisk.pl>
References: <20060116002516.GB4648@srcf.ucam.org>
	<20060116192550.GA23850@srcf.ucam.org>
	<20060116200521.GO1666@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============74974783331180483=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060116200521.GO1666@elf.ucw.cz>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@linux.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============74974783331180483==
Content-Type: text/plain;
  charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id k0GKKNDZ012446

Hi,

On Monday, 16 January 2006 21:05, Pavel Machek wrote:
> On Po 16-01-06 19:25:50, Matthew Garrett wrote:
> > On Mon, Jan 16, 2006 at 08:20:36PM +0100, Pavel Machek wrote:
> >=20
> > > I had patch to fix this breakage, but it was rejected. What depends=
 on
> > > that code?
> >=20
> > Ubuntu's wireless disable script.
>=20
> Can you search linux-pm archives? Search for "3" (that's '"', '3',
> '"'). It should be somewhere. I no longer have a copy. (Probably could
> get it from my working tree git...)

I think the appended message contains the latest version.

Greetings,
Rafael


----------  Forwarded Message  ----------

Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys in=
terface
Date: Friday, 6 January 2006 00:08
From: Pavel Machek <pavel@ucw.cz>
To: Dominik Brodowski <linux@dominikbrodowski.net>, Patrick Mochel <moche=
l@digitalimplant.org>, Andrew Morton <akpm@osdl.org>, Linux-pm mailing li=
st <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>

On =C4=8Ct 05-01-06 23:27:05, Dominik Brodowski wrote:
> On Thu, Jan 05, 2006 at 11:23:38PM +0100, Pavel Machek wrote:
> > > In addition, your patch breaks pcmcia / pcmciautils which already u=
ses
> > > numbers (which I already had to change from "3" to "2" before...).
> >=20
> > pcmcia actually uses this? Ouch. Do you just read the power file, or
> > do you write to it, too?
>=20
> Reading and writing. Replacement for "cardctl suspend" and "cardctl res=
ume".
>=20
>=20
> static int pccardctl_power_one(unsigned long socket_no, unsigned int de=
vice,
>                                unsigned int power)
> {
>         int ret;
>         char file[SYSFS_PATH_MAX];
>         struct sysfs_attribute *attr;
>=20
>         snprintf(file, SYSFS_PATH_MAX,
>                  "/sys/bus/pcmcia/devices/%lu.%u/power/state",
>                  socket_no, device);
>=20
>         attr =3D sysfs_open_attribute(file);
>         if (!attr)
>                 return -ENODEV;
>=20
>         ret =3D sysfs_write_attribute(attr, power ? "2" : "0", 1);
>=20
>         sysfs_close_attribute(attr);
>=20
>         return (ret);
> }
>=20
>=20
> NB: it will break one day, one way or another, when gregkh makes the
> /sys/class -> /sys/devices conversion. However, I'd want to try not to =
break
> the new pcmciautils userspace too often...

Ok, so lets at least add value-checking to .../power file, and prevent
userspace see changes to PM_EVENT_SUSPEND value. 2 and 0 are now
"arbitrary cookies". I'd like to use "on" and "off", but pcmcia
apparently depends on "2" and "0", so...

Any objections?

Signed-off-by: Pavel Machek <pavel@suse.cz>
								Pavel

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -27,22 +27,25 @@
=20
 static ssize_t state_show(struct device * dev, struct device_attribute *=
attr, char * buf)
 {
-	return sprintf(buf, "%u\n", dev->power.power_state.event);
+	if (dev->power.power_state.event)
+		return sprintf(buf, "2\n");
+	else
+		return sprintf(buf, "0\n");
 }
=20
 static ssize_t state_store(struct device * dev, struct device_attribute =
*attr, const char * buf, size_t n)
 {
 	pm_message_t state;
-	char * rest;
-	int error =3D 0;
+	int error =3D -EINVAL;
=20
-	state.event =3D simple_strtoul(buf, &rest, 10);
-	if (*rest)
-		return -EINVAL;
-	if (state.event)
-		error =3D dpm_runtime_suspend(dev, state);
-	else
+	state.event =3D PM_EVENT_SUSPEND;
+	if ((n =3D=3D 1) && !strncmp(buf, "2", 1)) {
 		dpm_runtime_resume(dev);
+		error =3D 0;
+	}
+	if ((n =3D=3D 1) && !strncmp(buf, "0", 1))
+		error =3D dpm_runtime_suspend(dev, state);
+
 	return error ? error : n;
 }
=20


--===============74974783331180483==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============74974783331180483==--
