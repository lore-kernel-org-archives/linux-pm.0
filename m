From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: device_pm_add (was: Re: 2.6.25-git2: BUG: unable to
	handle kernel paging request at ffffffffffffffff)
Date: Wed, 23 Apr 2008 02:50:24 +0200
Message-ID: <200804230250.26159.rjw__49171.5600401678$1208914834$gmane$org@sisk.pl>
References: <alpine.LFD.1.10.0804201410090.2779@woody.linux-foundation.org>
	<200804222234.19936.rjw@sisk.pl>
	<alpine.LFD.1.10.0804221350110.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0804221350110.2779@woody.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, paulmck@linux.vnet.ibm.com, David Miller <davem@davemloft.net>, herbert@gondor.apana.org.au
List-Id: linux-pm@vger.kernel.org

[Sorry for resending, but it looks like this message didn't reach the lists=
.]

On Tuesday, 22 of April 2008, Linus Torvalds wrote:
> =

> On Tue, 22 Apr 2008, Rafael J. Wysocki wrote:
> > =

> > There is a bug in device_add() that IMO can be fixed this way:
> =

> Ok, looks fine. Greg?
> =

> > Index: linux-2.6/drivers/base/core.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/drivers/base/core.c
> > +++ linux-2.6/drivers/base/core.c
> > @@ -820,11 +820,11 @@ int device_add(struct device *dev)
> >  	error =3D bus_add_device(dev);
> >  	if (error)
> >  		goto BusError;
> > +	bus_attach_device(dev);
> >  	error =3D device_pm_add(dev);
> >  	if (error)
> >  		goto PMError;
> >  	kobject_uevent(&dev->kobj, KOBJ_ADD);
> > -	bus_attach_device(dev);
> >  	if (parent)
> >  		klist_add_tail(&dev->knode_parent, &parent->klist_children);
> >  =

> > The problem is that bus_remove_device() assumes bus_attach_device() to =
have
> > run, AFAICS.
> =

> As to the other issue:
> =

> > > So I would suggest reverting that commit, or at least just making it =
a =

> > > warning (while still registering the device).
> > =

> > Are drivers supposed to register children of suspended devices?  That d=
oesn't
> > make much sense IMO ...
> =

> Well, that's why I think the warning itself makes sense - and then we can =

> decide whether it makes sense for that particular case or not. Clearly it =

> happens (since it triggered), now we need to figure out _why_ it happened=
. =


Well, this particular case looks like a race to me.

> But I don't think debugging messages should change behaviour.

Okay, below is a more complete patch that changes device_pm_add() so that
it doesn't refuse to add children of suspended devices. =A0Note, however, t=
hat
even if such a registration succeeds, it will probably lead to some future
problems.

Thanks,
Rafael


---
Do not refuse to actually register children of suspended devices,
but still warn about attempts to do that.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

Index: linux-2.6/drivers/base/power/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -62,7 +62,7 @@ static bool all_sleeping;
  */
 int device_pm_add(struct device *dev)
 {
-	int error =3D 0;
+	int error;
 =

 	pr_debug("PM: Adding info for %s:%s\n",
 		 dev->bus ? dev->bus->name : "No Bus",
@@ -70,18 +70,15 @@ int device_pm_add(struct device *dev)
 	mutex_lock(&dpm_list_mtx);
 	if ((dev->parent && dev->parent->power.sleeping) || all_sleeping) {
 		if (dev->parent->power.sleeping)
-			dev_warn(dev,
-				"parent %s is sleeping, will not add\n",
+			dev_warn(dev, "parent %s is sleeping\n",
 				dev->parent->bus_id);
 		else
-			dev_warn(dev, "devices are sleeping, will not add\n");
+			dev_warn(dev, "all devices are sleeping\n");
 		WARN_ON(true);
-		error =3D -EBUSY;
-	} else {
-		error =3D dpm_sysfs_add(dev);
-		if (!error)
-			list_add_tail(&dev->power.entry, &dpm_active);
 	}
+	error =3D dpm_sysfs_add(dev);
+	if (!error)
+		list_add_tail(&dev->power.entry, &dpm_active);
 	mutex_unlock(&dpm_list_mtx);
 	return error;
 }
