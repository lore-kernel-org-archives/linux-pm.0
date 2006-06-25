From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sat, 24 Jun 2006 18:30:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606241815480.6483@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606241220100.19990-100000@netrider.rowland.org>
	<Pine.LNX.4.64.0606241518380.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606241518380.6483@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Sat, 24 Jun 2006, Linus Torvalds wrote:
> =

> Actually using suspend_late()/resume_early() runs into issues with the =

> "platform_device" also needing to be taught about the thing, and it's =

> already too late in the 2.6.18 series to even really try, but I'd like to =

> have the infrastructure all in place, and I don't think anybody really =

> _disagreed_ with the patch per se.

Actually, the platform devices don't much care (pcspkr? Big deal ;), but =

PCIE did its own suspend/resume, and if we want to bring the PCIE bridges =

back early (and we do),it also needed to be aware of the two-phase thing.

Here's a working patch that suspends and resumes on my Mac Mini, and =

actually _uses_ the new states.

I'm not suggesting people necessarily apply this, but if somebody wants to =

play around, just apply my last patch (and make sure to fix the trivial =

one-liner that Dominik Brodowski pointed out: the "resume_device_early()" =

function had a bit too much cut-and-paste, and obviously needs to call =

"dev->bus->resume_early()", not "dev->bus->resume()"), and apply this one =

on top.

What it does is =

 - make PCIE use the different phases (and fix what looks like a PCIE bug =

   in the meantime: it resumed the children _before_ it resumed the bus =

   itself)
 - switch the default PCI suspend/resume code over to suspendign and =

   resuming the PCI state late/early (unless there's a real suspend =

   function, in which case we assume the driver will do things right)
 - split up the sky2 network driver suspend/resume

This actually gets us very close to being able to use at least the sky2 =

driver up until the very last moment. It's not _quite_ there yet, though: =

the way the driver has been written (sky2_up()/sky2_down()) it will free =

and re-allocate all the DMA-consistent PCI memory allocations, and that's =

somethign you do _not_ generally want to do in the early resume with =

interrupts off).

But the point is, if that network driver had just kept the allocations, =

and just re-initialized them, we could have moved sky2_down/up into the =

late suspend and early resume phase, and the driver should be perfectly =

functional from very early on.

Then, you could have a nice network console spitting out errors while =

resuming USB and other problem children.

Wouldn't that be nice? We could eventually move the console suspend and =

resume down to be around just the late suspend / early resume, and any =

device that can be resumed early would work as a console device for all =

the hard cases..

Comments?

Again, I'm not actually planning on committing this, but the =

infrastructure would be nice to have in place for people (I'm still hoping =

others will join the fun) to play with.

		Linus

---
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 50bfc1b..c0d04ad 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -88,16 +88,21 @@ static void pcie_portdrv_remove (struct =

 #ifdef CONFIG_PM
 static int pcie_portdrv_suspend (struct pci_dev *dev, pm_message_t state)
 {
-	int ret =3D pcie_port_device_suspend(dev, state);
+	return pcie_port_device_suspend(dev, state);
+}
 =

-	if (!ret)
-		ret =3D pcie_portdrv_save_config(dev);
-	return ret;
+static int pcie_portdrv_suspend_late (struct pci_dev *dev, pm_message_t st=
ate)
+{
+	return pcie_portdrv_save_config(dev);
+}
+
+static int pcie_portdrv_resume_early (struct pci_dev *dev)
+{
+	return pcie_portdrv_restore_config(dev);
 }
 =

 static int pcie_portdrv_resume (struct pci_dev *dev)
 {
-	pcie_portdrv_restore_config(dev);
 	return pcie_port_device_resume(dev);
 }
 #endif
@@ -121,6 +126,8 @@ static struct pci_driver pcie_portdrv =3D =

 =

 #ifdef	CONFIG_PM
 	.suspend	=3D pcie_portdrv_suspend,
+	.suspend_late	=3D pcie_portdrv_suspend_late,
+	.resume_early	=3D pcie_portdrv_resume_early,
 	.resume		=3D pcie_portdrv_resume,
 #endif	/* PM */
 };


diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 6308fed..330c338 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -287,8 +287,6 @@ static int pci_device_suspend(struct dev
 	if (drv && drv->suspend) {
 		i =3D drv->suspend(pci_dev, state);
 		suspend_report_result(drv->suspend, i);
-	} else {
-		pci_save_state(pci_dev);
 	}
 	return i;
 }
@@ -302,6 +300,8 @@ static int pci_device_suspend_late(struc
 	if (drv && drv->suspend_late) {
 		i =3D drv->suspend_late(pci_dev, state);
 		suspend_report_result(drv->suspend_late, i);
+	} else if (!drv || !drv->suspend) {
+		pci_save_state(pci_dev);
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
+	else if (!drv || !drv->resume)
+		error =3D pci_default_resume(pci_dev);
 	return error;
 }
 =

diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
index d357787..991cc31 100644
--- a/drivers/net/sky2.c
+++ b/drivers/net/sky2.c
@@ -3428,14 +3428,20 @@ static void __devexit sky2_remove(struct
 }
 =

 #ifdef CONFIG_PM
-static int sky2_suspend(struct pci_dev *pdev, pm_message_t state)
+
+static int sky2_suspend_prepare(struct pci_dev *pdev, pm_message_t state)
 {
-	struct sky2_hw *hw =3D pci_get_drvdata(pdev);
-	int i;
 	pci_power_t pstate =3D pci_choose_state(pdev, state);
 =

 	if (!(pstate =3D=3D PCI_D3hot || pstate =3D=3D PCI_D3cold))
 		return -EINVAL;
+	return 0;
+}	=

+
+static int sky2_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct sky2_hw *hw =3D pci_get_drvdata(pdev);
+	int i;
 =

 	del_timer_sync(&hw->idle_timer);
 =

@@ -3451,6 +3457,13 @@ static int sky2_suspend(struct pci_dev *
 			netif_poll_disable(dev);
 		}
 	}
+	return 0;
+}
+
+static int sky2_suspend_late(struct pci_dev *pdev, pm_message_t state)
+{
+	struct sky2_hw *hw =3D pci_get_drvdata(pdev);
+	pci_power_t pstate =3D pci_choose_state(pdev, state);
 =

 	sky2_write32(hw, B0_IMSK, 0);
 	pci_save_state(pdev);
@@ -3458,10 +3471,10 @@ static int sky2_suspend(struct pci_dev *
 	return 0;
 }
 =

-static int sky2_resume(struct pci_dev *pdev)
+static int sky2_resume_early(struct pci_dev *pdev)
 {
 	struct sky2_hw *hw =3D pci_get_drvdata(pdev);
-	int i, err;
+	int err;
 =

 	pci_restore_state(pdev);
 	pci_enable_wake(pdev, PCI_D0, 0);
@@ -3472,10 +3485,19 @@ static int sky2_resume(struct pci_dev *p
 		goto out;
 =

 	sky2_write32(hw, B0_IMSK, Y2_IS_BASE);
+out:
+	return err;
+}
+
+static int sky2_resume(struct pci_dev *pdev)
+{
+	struct sky2_hw *hw =3D pci_get_drvdata(pdev);
+	int i;
 =

 	for (i =3D 0; i < hw->ports; i++) {
 		struct net_device *dev =3D hw->dev[i];
 		if (dev && netif_running(dev)) {
+			int err;
 			netif_device_attach(dev);
 			netif_poll_enable(dev);
 =

@@ -3484,14 +3506,13 @@ static int sky2_resume(struct pci_dev *p
 				printk(KERN_ERR PFX "%s: could not up: %d\n",
 				       dev->name, err);
 				dev_close(dev);
-				goto out;
+				return err;
 			}
 		}
 	}
 =

 	sky2_idle_start(hw);
-out:
-	return err;
+	return 0;
 }
 #endif
 =

@@ -3501,7 +3522,10 @@ static struct pci_driver sky2_driver =3D {
 	.probe =3D sky2_probe,
 	.remove =3D __devexit_p(sky2_remove),
 #ifdef CONFIG_PM
+	.suspend_prepare =3D sky2_suspend_prepare,
 	.suspend =3D sky2_suspend,
+	.suspend_late =3D sky2_suspend_late,
+	.resume_early =3D sky2_resume_early,
 	.resume =3D sky2_resume,
 #endif
 };
