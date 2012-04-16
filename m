From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Tue, 17 Apr 2012 03:19:43 +0600
Message-ID: <20120416211943.GE11484@belkar.wrar.name>
References: <20120413224336.GA5585@belkar.wrar.name>
	<Pine.LNX.4.44L0.1204161558220.1408-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2171245292137281284=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1204161558220.1408-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: jrnieder@gmail.com, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org


--===============2171245292137281284==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ffoCPvUAPMgSXi6H"
Content-Disposition: inline


--ffoCPvUAPMgSXi6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2012 at 04:07:10PM -0400, Alan Stern wrote:
> This is my next attempt to make the driver-bound and driver-unbound
> suspend paths as similar as possible.  Apply this to a vanilla kernel; =
=20
> it is based on 3.4-rc2 plus a few unrelated changes.  See what happens
> when you suspend without unbinding ehci-hcd -- and be sure to include
> "no_console_suspend" on the boot command line beforehand.
It suspends and resumes but the screen is not enabled after resume and the
network doesn't seem to work either.

> These changes will prevent the driver from working after resume=20
> (assuming the computer survives that long).  That's all right; all I=20
> care about is whether the computer _does_ resume.
>=20
> Alan Stern
>=20
>=20
>=20
>=20
> Index: usb-3.4/drivers/pci/pci-driver.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-3.4.orig/drivers/pci/pci-driver.c
> +++ usb-3.4/drivers/pci/pci-driver.c
> @@ -713,6 +713,8 @@ static int pci_pm_suspend_noirq(struct d
> =20
>  	if (!pm) {
>  		pci_save_state(pci_dev);
> +		pci_prepare_to_sleep(pci_dev);
> +		pci_pm_set_unknown_state(pci_dev);
>  		return 0;
>  	}
> =20
> Index: usb-3.4/drivers/pci/pci.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-3.4.orig/drivers/pci/pci.c
> +++ usb-3.4/drivers/pci/pci.c
> @@ -1348,6 +1348,7 @@ void pci_disable_enabled_device(struct p
>  	if (pci_is_enabled(dev))
>  		do_pci_disable_device(dev);
>  }
> +EXPORT_SYMBOL(pci_disable_enabled_device);
> =20
>  /**
>   * pci_disable_device - Disable PCI device after use
> @@ -1710,6 +1711,7 @@ pci_power_t pci_target_state(struct pci_
>   */
>  int pci_prepare_to_sleep(struct pci_dev *dev)
>  {
> +	pci_power_t cur_state =3D dev->current_state;
>  	pci_power_t target_state =3D pci_target_state(dev);
>  	int error;
> =20
> @@ -1723,6 +1725,8 @@ int pci_prepare_to_sleep(struct pci_dev
>  	if (error)
>  		pci_enable_wake(dev, target_state, false);
> =20
> +	dev_info(&dev->dev, "cur %d target %d error %d\n", cur_state,
> +			target_state, error);
>  	return error;
>  }
> =20
> Index: usb-3.4/drivers/usb/core/hcd-pci.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-3.4.orig/drivers/usb/core/hcd-pci.c
> +++ usb-3.4/drivers/usb/core/hcd-pci.c
> @@ -381,6 +381,8 @@ static int check_root_hub_suspended(stru
>  }
> =20
>  #if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME)
> +extern void pci_disable_enabled_device(struct pci_dev *);
> +
>  static int suspend_common(struct device *dev, bool do_wakeup)
>  {
>  	struct pci_dev		*pci_dev =3D to_pci_dev(dev);
> @@ -427,12 +429,17 @@ static int suspend_common(struct device
>  	if (!hcd->msix_enabled)
>  		synchronize_irq(pci_dev->irq);
> =20
> +	free_irq(hcd->irq, hcd);
> +	iounmap(hcd->regs);
> +	pci_disable_device(pci_dev);
> +
>  	/* Downstream ports from this root hub should already be quiesced, so
>  	 * there will be no DMA activity.  Now we can shut down the upstream
>  	 * link (except maybe for PME# resume signaling).  We'll enter a
>  	 * low power state during suspend_noirq, if the hardware allows.
>  	 */
> -	pci_disable_device(pci_dev);
> +	pci_disable_enabled_device(pci_dev);
> +	pci_dev->current_state =3D PCI_UNKNOWN;
>  	return retval;
>  }
> =20
> Index: usb-3.4/drivers/usb/host/ehci-pci.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-3.4.orig/drivers/usb/host/ehci-pci.c
> +++ usb-3.4/drivers/usb/host/ehci-pci.c
> @@ -342,7 +342,6 @@ static int ehci_pci_suspend(struct usb_h
>  	 * mark HW unaccessible.  The PM and USB cores make sure that
>  	 * the root hub is either suspended or stopped.
>  	 */
> -	ehci_prepare_ports_for_controller_suspend(ehci, do_wakeup);
>  	spin_lock_irqsave (&ehci->lock, flags);
>  	ehci_writel(ehci, 0, &ehci->regs->intr_enable);
>  	(void)ehci_readl(ehci, &ehci->regs->intr_enable);
> @@ -350,6 +349,9 @@ static int ehci_pci_suspend(struct usb_h
>  	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
>  	spin_unlock_irqrestore (&ehci->lock, flags);
> =20
> +	ehci_silence_controller(ehci);
> +	ehci_reset(ehci);
> +
>  	// could save FLADJ in case of Vaux power loss
>  	// ... we'd only use it to handle clock skew
> =20
>=20
>=20

--=20
WBR, wRAR

--ffoCPvUAPMgSXi6H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPjIzvAAoJEDNi9wMaSZLharUP/RN55NCDmv0IFNQwmm5vP8OA
WSjhWTvyjORvnH0dcY7JfWoCU0+KNn10uEDkvxCTSGaP/L6TZyW5bwTH/rzwOUh+
s+2J1vWQXPClCmF7+/bpu6N+4E6F/dc5BIOpV7/KwK7EUxZYj7Dz/+Mh9Icjj6tI
mxT4n7NilVN4LnzzO4bSkLHfZSyvOa+yitH2LDpQss1tj/coDBA92vdkdMr4hWeN
s5OYd4tC2ISWA4KdPzJnZtPmBPpGieVmyocANnn4xgMhsdWazcMw5qC0Cgj0uIUR
PW/+iwG6kug7jq8BsqP558q1C7YgApXYkblNOxCu25l+xAP2WtJgfHD72aLHxGVW
CwXDPeL6vlnE16EvOLlDxDZwXzawQkbx9tK8lAAhmM640EcnaJ9E7mN4YT+29nPe
soVCKZU0dTiNZtyWePHhFMEUTIVeF9DkIDaZSYpV0sWx++UOwrp/2f00VZl9p/Rv
xCg3dMOYVWGW95iCJ7rp8gSfyrPXL+ZAVvsw/nOVk9pyqhf69ZQNvDSlqktNb6X4
TtlXTdW+/ma0LjXgELqk6lHntFuwnqCo/LFBrVcW+sQv/X96kOW+hQLIhLaF8NFJ
rthenG6geiTHMym84i/ks8iAt979VOqAIXH+VPT0OAc2+dhQO/l0Dib8TtOeJhyB
lpZjD79H3d7M33RlEHGx
=on29
-----END PGP SIGNATURE-----

--ffoCPvUAPMgSXi6H--

--===============2171245292137281284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2171245292137281284==--
