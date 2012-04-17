From: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Tue, 17 Apr 2012 23:51:22 +0600
Message-ID: <20120417175122.GM11484@belkar.wrar.name>
References: <20120417162534.GL11484@belkar.wrar.name>
 <Pine.LNX.4.44L0.1204171251330.1364-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MSd2ShuMixI0uVaZ"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1204171251330.1364-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--MSd2ShuMixI0uVaZ
Content-Type: multipart/mixed; boundary="00sTfE/IIAT5d2r5"
Content-Disposition: inline


--00sTfE/IIAT5d2r5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2012 at 12:58:03PM -0400, Alan Stern wrote:
> > > 	1. This change in hcd-pci.c:
> > > +	pci_dev->current_state =3D PCI_UNKNOWN;
> > It locks up if this line is removed.
>=20
> Very bizarre indeed.  All right, leave that line in place and try=20
> removing the other changes, one at a time.  In fact, let's add one more=
=20
> thing to remove from the patch
>=20
> > > 	2. This change in ehci-pci.c:
> > > +	ehci_silence_controller(ehci);
> > >=20
> > > 	3. This change in hcd-pci.c:
> > > +	pci_disable_device(pci_dev);
> > >=20
> > > 	4. This change in hcd-pci.c:
> > > +	iounmap(hcd->regs);
> > >=20
> > > 	5. This change in hcd-pci.c:
> > > +	free_irq(hcd->irq, hcd);
> > >=20
> > > 	6. This change in hcd-pci.c:
> > > -	pci_disable_device(pci_dev);
> > > +	pci_disable_enabled_device(pci_dev);
> > >=20
> > > 	7. This change in ehci-pci.c:
> > > -	ehci_prepare_ports_for_controller_suspend(ehci, do_wakeup);
>=20
> 	8. This change in ehci-pci.c:
> +	ehci_reset(ehci);
>=20
> If you manage to reach the end of this list, you'll essentially be
> doing a normal suspend (except for the PCI_UNKNOWN part).
It works without changes #2..8. I'm attaching the resulting patch.

--=20
WBR, wRAR

--00sTfE/IIAT5d2r5
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="current.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 6b54b23..8a9edf4 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -713,6 +713,8 @@ static int pci_pm_suspend_noirq(struct device *dev)
=20
 	if (!pm) {
 		pci_save_state(pci_dev);
+		pci_prepare_to_sleep(pci_dev);
+		pci_pm_set_unknown_state(pci_dev);
 		return 0;
 	}
=20
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8156744..3111105 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1348,6 +1348,7 @@ void pci_disable_enabled_device(struct pci_dev *dev)
 	if (pci_is_enabled(dev))
 		do_pci_disable_device(dev);
 }
+EXPORT_SYMBOL(pci_disable_enabled_device);
=20
 /**
  * pci_disable_device - Disable PCI device after use
@@ -1710,6 +1711,7 @@ pci_power_t pci_target_state(struct pci_dev *dev)
  */
 int pci_prepare_to_sleep(struct pci_dev *dev)
 {
+	pci_power_t cur_state =3D dev->current_state;
 	pci_power_t target_state =3D pci_target_state(dev);
 	int error;
=20
@@ -1723,6 +1725,8 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
 	if (error)
 		pci_enable_wake(dev, target_state, false);
=20
+	dev_info(&dev->dev, "cur %d target %d error %d\n", cur_state,
+			target_state, error);
 	return error;
 }
=20
diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index 622b4a4..d7dc939 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -381,6 +381,8 @@ static int check_root_hub_suspended(struct device *dev)
 }
=20
 #if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME)
+extern void pci_disable_enabled_device(struct pci_dev *);
+
 static int suspend_common(struct device *dev, bool do_wakeup)
 {
 	struct pci_dev		*pci_dev =3D to_pci_dev(dev);
@@ -427,12 +429,18 @@ static int suspend_common(struct device *dev, bool do=
_wakeup)
 	if (!hcd->msix_enabled)
 		synchronize_irq(pci_dev->irq);
=20
+//	free_irq(hcd->irq, hcd); // 5
+//	iounmap(hcd->regs); // 4
+//	pci_disable_device(pci_dev); // 3
+
 	/* Downstream ports from this root hub should already be quiesced, so
 	 * there will be no DMA activity.  Now we can shut down the upstream
 	 * link (except maybe for PME# resume signaling).  We'll enter a
 	 * low power state during suspend_noirq, if the hardware allows.
 	 */
+//	pci_disable_enabled_device(pci_dev); // 6
 	pci_disable_device(pci_dev);
+	pci_dev->current_state =3D PCI_UNKNOWN; // 1
 	return retval;
 }
=20
diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index 01bb7241d..5fbfc3e 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -342,7 +342,7 @@ static int ehci_pci_suspend(struct usb_hcd *hcd, bool d=
o_wakeup)
 	 * mark HW unaccessible.  The PM and USB cores make sure that
 	 * the root hub is either suspended or stopped.
 	 */
-	ehci_prepare_ports_for_controller_suspend(ehci, do_wakeup);
+	ehci_prepare_ports_for_controller_suspend(ehci, do_wakeup); // 7
 	spin_lock_irqsave (&ehci->lock, flags);
 	ehci_writel(ehci, 0, &ehci->regs->intr_enable);
 	(void)ehci_readl(ehci, &ehci->regs->intr_enable);
@@ -350,6 +350,9 @@ static int ehci_pci_suspend(struct usb_hcd *hcd, bool d=
o_wakeup)
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 	spin_unlock_irqrestore (&ehci->lock, flags);
=20
+//	ehci_silence_controller(ehci); // 2
+//	ehci_reset(ehci); // 8
+
 	// could save FLADJ in case of Vaux power loss
 	// ... we'd only use it to handle clock skew
=20

--00sTfE/IIAT5d2r5--

--MSd2ShuMixI0uVaZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPja2aAAoJEDNi9wMaSZLhEjIQAIxeW1fcyY7A4E2lEpUUZeie
DfP9UJqLUn+ZPC79CFYBSOJc0kHb8brvzDn8R6aJUeKa3GdjMj8emS8xLbVm/JkU
CB30XRamrNB2X9T/gwBxeXKs47sSpz40eoWp234D3iKwsrw6YoTml+Ghdqh07/k/
2E6Zkd9Y4ynn+0jl72rvAfuKNqG5G4IbscFmItgkDjWEPGPXJH+TrVSCBNBg5g+k
/VmLYHgmgLM6yXXcTKyPLMNhGeE0ER3m/iea8a2UtA9wAaQvBClGj4o+FtvYXD8F
2xJiHSXiyRaMA2hAtzpG8Nka3XIR8GDgVN4JDjKWZEEslu3vPraRvaI3nfJIZ9oL
2eFg3O9lFkeg2Ndo2mYgbF0g5k2wMtrey35Qt1V8KY0Sx2/iEEeW3YxQL1UATPZk
52BToHQPW24BBvIxtNzKnIBlWwiMEJ2mzSerEeY1trN2kH8VWiLBUaT8kPFAsW0v
45MKfxqzbICUMkjPiflNeHSludU2k7cDDl+w1oaPfuC1j6LlDgv4rm7DA8HZl9iM
4Aqv0q8IlqFr1p11WF04THO63tzGsQp0RSbxJ5x3EdvfpOEuO8G7zlw13R1+MXkF
+sF5EB5T/hBLVPAF+aR+9f2ebY9ztTrSMKb6TNtcc7utFMYwGiq7CFL/yi2muFaY
Vwm7CK7hMqRUbIFOj248
=BOnA
-----END PGP SIGNATURE-----

--MSd2ShuMixI0uVaZ--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
