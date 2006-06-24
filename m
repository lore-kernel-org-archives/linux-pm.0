From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 22:18:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606232155160.6483@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606221130.30614.david-b@pacbell.net>
	<Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
	<20060624024230.GB3438@neo.rr.com>
	<Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
	<1151124740.10141.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1151124740.10141.49.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Sat, 24 Jun 2006, Benjamin Herrenschmidt wrote:
> =

> >  - suspend_late
> =

> Ok, so this is a cleanup over the old stuff we had for returning a
> special error from suspend to be called again later with interrupts off.
> I agree it sucked, though I never actually used it.

I don't think it _could_ be used. =


Or rather, you'd have to have done some really really insane things like

	if (!interrupt_disabled())
		return -EAGAIN;

in the suspend() routine, and live with the fact that cleanup - and =

ordering - would be impossible and/or very hard to figure out.

I bet nobody ever used it.

> However, we could just do a 2 pass mecanism instaed with the second pass
> sitll not having irqs off, but having shut down all clients of "directly
> mapped" devices (PCI etc...) and thus letting those be suspended _after_
> all the others. In our above examples, we would get the first pass do
> =

>  - usb devices, firewire devices, all devices depending on an upper
> transport driver basically
>  - the class devices like netdev's (maybe with tweaks so that netconsole
> is still operational via hacks in the driver tho)
>  =

> And the second pass would do
> =

>  - pci devices (network drivers typically, fbdev's)
>  - pci bridges

I'm pretty sure that would suck, and be a lot less flexible than the much =

simpler setup.

I bet you we'll have devices that want to be in both classes. For example, =

I would expect a network driver to set up it's "PCI state" in the early =

resume, but possibly do something like it's PHY probing etc in the =

"normal" resume when interrupts are on, because it may need to do =

"msleep()" etc to do that part.

In fact, I can also point you to a device that is at least two _different_ =

classes: the graphics thing.

Take a close look at where "device_prepare_suspend()" is, and where the
"device_finish_resume()" callback would be.

Hint: they match "pm_prepare_console()" and "pm_restore_console()" =

_exactly_. =


It's not just "close". It's right there.

In other words, if we added a "resume_finish()" method, we could handle X =

and the screen _without_any_special_cases_, as the perfectly normal phases =

of suspending the video device. You could _literally_ make the "prepare" =

be the "switch consoles" of the current pm_prepare_consoles, and the =

"suspend_late()" would be the actual "go to D3cold" part.

I talked about this a lot earlier. Very early in this thread, I pointed =

out that X really shouldn't need to be a special case.

And the "suspend_late()" thing really is fundamentally different from =

"suspend()". As mentioned several times, splitting suspend() up is what =

allows us to, very specifically, avoid having to shut down the console =

early. I want to be able to do printk() until as late in the game as =

possible, and preferably as early in the game as possible. =


And splitting suspend was the way to do that. And when I actually started =

doing that, splitting resume (which is even _better_) actually fell out of =

it automatically - I needed to do that just to handle the nested error =

cases correctly (which I had earlier thought I'd just punt entirely, and =

require that we do errors in the "prepare/save_state" phase only).

In other words, I think that this patch will allow us to resume, say VGA =

early, and reliably, and get a working console by the time we resume USB.

Now, it does require that PCI buses (and preferably other devices) go to =

D3 only in suspend_late(), and come back in resume_early(), so that VGA is =

reachable. So that _will_ require driver modifications.

But I think it will actually fall out of just moving where the "default =

PCI suspend/resume" thing gets handled (ie move -that- from the current =

standard suspend/resume, to be in the late/early suspend/resume).

In other words, I've not tested it, but I suspect something as simple as =

this migt just do 99% of it. Teach some other core PCI devices (a network =

driver or two) about the late/early stuff, and I suspect you'll find it a =

_lot_ easier to debug USB suspend and resume, because things like =

netconsole suddenly start working _during_ suspend.

(And btw, this patch is _totally_ untested. This is the point where we =

actually start modifying what we do. But it doesn't look "obviously wrong" =

to me - I think it falls solidly in the "it might just work" category).

		Linus

---
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f0af89b..82c8d9b 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -274,6 +274,8 @@ static int pci_device_suspend_prepare(st
 	if (drv && drv->suspend_prepare) {
 		i =3D drv->suspend_prepare(pci_dev, state);
 		suspend_report_result(drv->suspend_prepare, i);
+	} else {
+		pci_save_state(pci_dev);
 	}
 	return i;
 }
@@ -287,8 +289,6 @@ static int pci_device_suspend(struct dev
 	if (drv && drv->suspend) {
 		i =3D drv->suspend(pci_dev, state);
 		suspend_report_result(drv->suspend, i);
-	} else {
-		pci_save_state(pci_dev);
 	}
 	return i;
 }
@@ -328,14 +328,12 @@ static int pci_default_resume(struct pci
 =

 static int pci_device_resume(struct device * dev)
 {
-	int error;
+	int error =3D 0;
 	struct pci_dev * pci_dev =3D to_pci_dev(dev);
 	struct pci_driver * drv =3D pci_dev->driver;
 =

 	if (drv && drv->resume)
 		error =3D drv->resume(pci_dev);
-	else
-		error =3D pci_default_resume(pci_dev);
 	return error;
 }
 =

@@ -347,6 +345,8 @@ static int pci_device_resume_early(struc
 =

 	if (drv && drv->resume_early)
 		error =3D drv->resume_early(pci_dev);
+	else
+		error =3D pci_default_resume(pci_dev);
 	return error;
 }
 =
