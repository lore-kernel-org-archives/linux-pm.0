From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again)
Date: Thu, 31 May 2012 23:29:15 +0200
Message-ID: <201205312329.15523.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1205311704340.1178-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1205311704340.1178-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>, =?utf-8?q?D=C3=A2niel_Fraga?= <fragabr@gmail.com>, Andrey Rahmatullin <wrar@wrar.name>, Steven Rostedt <rostedt@goodmis.org>, linux-pm@lists.linux-foundation.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, May 31, 2012, Alan Stern wrote:
> On Tue, 29 May 2012, Rafael J. Wysocki wrote:
>=20
> > > > > Therefore we really do need a quirk, probably in ehci-hcd lik=
e the=20
> > > > > original patch.  If it is restricted to apply only in cases w=
here the=20
> > > > > DMI information lists ASUSTeK as the manufacturer, perhaps th=
at will be=20
> > > > > sufficient.  (For some reason, the manufacturer field in D=C3=
=A2niel's BIOS=20
> > > > > isn't initialized.)
> > > >=20
> > > > Yeah.
> > > >=20
> > > > I'll have a deeper look at this later today, I think.
> > >=20
> > > It's easy enough to write such a check (or perhaps more reliably,=
 check
> > > for a product name matching "P8Z68-V").
> >=20
> > I think we should try to express it as a PCI quirk in quirks.c, tho=
ugh.
>=20
> Here's my attempt.  Everybody, please try this patch with the
> 151b61284776 commit removed.  Make sure that CONFIG_USB_DEBUG is
> enabled so we can check the controller's power state during suspend,=20
> and check that the "broken D3 during system sleep on ASUS" message=20
> shows up during booting.
>=20
> Alan Stern
>=20
>=20
>=20
> Index: usb-3.4/drivers/pci/pci.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-3.4.orig/drivers/pci/pci.c
> +++ usb-3.4/drivers/pci/pci.c
> @@ -1743,6 +1743,11 @@ int pci_prepare_to_sleep(struct pci_dev
>  	if (target_state =3D=3D PCI_POWER_ERROR)
>  		return -EIO;
> =20
> +	/* Some devices mustn't be in D3 during system sleep */
> +	if (target_state =3D=3D PCI_D3hot &&
> +			(dev->dev_flags & PCI_DEV_FLAGS_NO_D3_DURING_SLEEP))
> +		return 0;
> +

Why do you want to skip the wakeup setting in that case?

>  	pci_enable_wake(dev, target_state, device_may_wakeup(&dev->dev));
> =20
>  	error =3D pci_set_power_state(dev, target_state);
> Index: usb-3.4/drivers/pci/quirks.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-3.4.orig/drivers/pci/quirks.c
> +++ usb-3.4/drivers/pci/quirks.c
> @@ -2917,6 +2917,32 @@ static void __devinit disable_igfx_irq(s
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0102, disable_igfx_ir=
q);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x010a, disable_igfx_ir=
q);
> =20
> +/*
> + * The Intel 6 Series/C200 Series chipset's EHCI controllers on many
> + * ASUS motherboards will cause memory corruption or a system crash
> + * if they are in D3 while the system is put into S3 sleep.
> + */
> +static void __devinit asus_ehci_no_d3(struct pci_dev *dev)
> +{
> +	const char *sys_info;
> +	static const char good_Asus_board[] =3D "P8Z68-V";
> +
> +	if (dev->dev_flags & PCI_DEV_FLAGS_NO_D3_DURING_SLEEP)
> +		return;
> +	if (dev->subsystem_vendor !=3D PCI_VENDOR_ID_ASUSTEK)
> +		return;
> +	sys_info =3D dmi_get_system_info(DMI_BOARD_NAME);
> +	if (sys_info && memcmp(sys_info, good_Asus_board,
> +			sizeof(good_Asus_board) - 1) =3D=3D 0)
> +		return;
> +
> +	dev_info(&dev->dev, "broken D3 during system sleep on ASUS\n");
> +	dev->dev_flags |=3D PCI_DEV_FLAGS_NO_D3_DURING_SLEEP;
> +	device_set_wakeup_capable(&dev->dev, false);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1c26, asus_ehci_no_d3=
);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1c2d, asus_ehci_no_d3=
);
> +
>  static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
>  			  struct pci_fixup *end)
>  {
> Index: usb-3.4/include/linux/pci.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-3.4.orig/include/linux/pci.h
> +++ usb-3.4/include/linux/pci.h
> @@ -176,6 +176,8 @@ enum pci_dev_flags {
>  	PCI_DEV_FLAGS_NO_D3 =3D (__force pci_dev_flags_t) 2,
>  	/* Provide indication device is assigned by a Virtual Machine Manag=
er */
>  	PCI_DEV_FLAGS_ASSIGNED =3D (__force pci_dev_flags_t) 4,
> +	/* Device causes system crash if in D3 during S3 sleep */
> +	PCI_DEV_FLAGS_NO_D3_DURING_SLEEP =3D (__force pci_dev_flags_t) 8,
>  };
> =20
>  enum pci_irq_reroute_variant {

The quirks part looks good to me.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
