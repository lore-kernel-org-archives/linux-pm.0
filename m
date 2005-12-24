From: Pavel Machek <pavel@suse.cz>
Subject: Re: Runtime device power management in userspace
Date: Sat, 24 Dec 2005 01:40:30 +0100
Message-ID: <20051224004029.GC16043@elf.ucw.cz>
References: <20051223143047.GC16463@f192.suse.de>
	<Pine.LNX.4.50.0512230706530.13289-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0512230706530.13289-100000@monsoon.he.net>
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

On P=E1 23-12-05 07:12:35, Patrick Mochel wrote:
> On Fri, 23 Dec 2005, Holger Macht wrote:
> > We implemented device runtime power management in a userspace applica=
tion
> > (the powersave daemon). In this specific case, it means to successive=
ly
> > put pci devices into D3 powersave mode with writing a numerical '3' t=
o the
> > corresponding power state file.
> >
> > There are two main reasons for us to even doing this:
> >
> >   1. At first, the obvious reason. As mentioned in our research regar=
ding
> >      power consumption on this list, there is a very huge potential t=
o
> >      save battery power.
> >
> >   2. Due to the fact that this is AFAIK a heavily untested area, as a=
 side
> >      effect, we like to get reports about broken modules/drivers and =
maybe
> >      get them fixed.
>=20
> That's great!
>=20
> Please note that D3 is only relevant for PCI devices and for ACPI devic=
es.
> The fact that it's the same value for every device in the system is a
> design flaw. Please be aware that the value to write to the device file
> could change, and will be dependent on the type (bus) of device, and qu=
ite
> possibly on the device itself. It may not even be '3' for all PCI devic=
es
> in the future, or may be a string rather than 1 character, or simply a =
'1'
> into a different file.

Is there enough locking in driver core to make this safe?

Ouch and BTW *right* value is _2_, today... because state_store() uses
value from user as a pm_message_t.event. We should at least supply
some hint that it is runtime suspend in pm_message_t.flags --
unfortunately we do not have pm_message_t.flags yet.

Something like this is needed -- userspace should not play with
pm_message_t.state directly. [not even compile tested, have to sleep.]

I guess we should also audit the drivers... It needs locking against
user supplying requests concurently.

> Also, is there source available?

Should be, we are trying to do *Open*SUSE these days ;-))).

								Pavel

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -34,12 +34,14 @@ static ssize_t state_store(struct device
 {
 	pm_message_t state;
 	char * rest;
-	int error =3D 0;
+	int error =3D 0, i;
=20
-	state.event =3D simple_strtoul(buf, &rest, 10);
+	i =3D simple_strtoul(buf, &rest, 10);
+	state.event =3D PM_EVENT_SUSPEND;
+	state.flags =3D PM_FLAGS_RUNTIME;
 	if (*rest)
 		return -EINVAL;
-	if (state.event)
+	if (i)
 		error =3D dpm_runtime_suspend(dev, state);
 	else
 		dpm_runtime_resume(dev);
diff --git a/include/linux/pm.h b/include/linux/pm.h
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -140,6 +140,7 @@ struct device;
=20
 typedef struct pm_message {
 	int event;
+	int flags;
 } pm_message_t;
=20
 /*
@@ -165,6 +166,8 @@ typedef struct pm_message {
 #define PM_EVENT_FREEZE 1
 #define PM_EVENT_SUSPEND 2
=20
+#define PM_FLAGS_RUNTIME 1
+
 #define PMSG_FREEZE	((struct pm_message){ .event =3D PM_EVENT_FREEZE, })
 #define PMSG_SUSPEND	((struct pm_message){ .event =3D PM_EVENT_SUSPEND, =
})
 #define PMSG_ON		((struct pm_message){ .event =3D PM_EVENT_ON, })

--=20
Thanks, Sharp!
