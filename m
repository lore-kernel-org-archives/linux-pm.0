From: Pavel Machek <pavel@suse.cz>
Subject: Re: Runtime device power management in userspace
Date: Tue, 27 Dec 2005 22:06:27 +0100
Message-ID: <20051227210627.GM1822@elf.ucw.cz>
References: <20051223143047.GC16463@f192.suse.de>
	<Pine.LNX.4.50.0512230706530.13289-100000@monsoon.he.net>
	<20051224004029.GC16043@elf.ucw.cz>
	<Pine.LNX.4.50.0512261234350.12383-100000@monsoon.he.net>
	<20051226223325.GE1974@elf.ucw.cz>
	<Pine.LNX.4.50.0512271054350.30915-100000@monsoon.he.net>
	<20051227192254.GJ1822@elf.ucw.cz>
	<20051227192956.GA10704@digitalimplant.org>
	<20051227194100.GL1822@elf.ucw.cz>
	<Pine.LNX.4.50.0512271229510.4933-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0512271229510.4933-100000@monsoon.he.net>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On =DAt 27-12-05 12:40:10, Patrick Mochel wrote:
> On Tue, 27 Dec 2005, Pavel Machek wrote:
> > On =DAt 27-12-05 11:29:56, Patrick Mochel wrote:
> > > But, in some cases, peple are going to care about the intermediate
> > > states, and we'll need to support them. It's simple enought to know
> > > what states a PCI device supports, so I don't understand where the
> > > complexity comes in.. ?
> >
> > Someone has to test all that... Unless we have in-tree driver that
> > wants use intermediate states, I think supporting them is bad idea.
>=20
> I don't understand what your issue is; perhaps you could explain it a b=
it
> better. There is no additional work on the part of the core, nor any
> additional complication in supporting 4 possible power states vs
> supporting 2 vs supporting any arbitrary number that the driver and dev=
ice
> implement.

Well, I can do two states today, with the patch below :-). Actually it
should work today as-is: writing 0/2 does mostly right think now.

> I did not suggest that we make the drivers support intermediate states;=
 I
> only stated that there are some drivers and devices that can and will
> implement them, and that there are cases in which it will make sense to
> enter them from userpsace.

Ok.

> I admit I made a mistake in suggesting the interface - we wouldn't want=
 to
> simply export all the PM states that are present in the device's config
> space. We would really only want to export the states that the driver s=
ays
> it supports. But, that could be any number of states, above and
> beyond (or

Ok.
								Pavel

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -33,15 +33,12 @@ static ssize_t state_show(struct device=20
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
+	state.event =3D PM_EVENT_SUSPEND;
+	if ((n =3D=3D 2) && !strncmp(buf, "on", min(n, 2)))
 		error =3D dpm_runtime_suspend(dev, state);
-	else
+	if ((n =3D=3D 7) && !strncmp(buf, "suspend", min(n, 7)))
 		dpm_runtime_resume(dev);
 	return error ? error : n;
 }


--=20
Thanks, Sharp!
