From: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 19 Apr 2012 22:30:55 +0600
Message-ID: <20120419163055.GB11484@belkar.wrar.name>
References: <Pine.LNX.4.44L0.1204181729400.1149-100000@iolanthe.rowland.org>
 <Pine.LNX.4.44L0.1204190934500.2070-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XA3zunQti4u0IH5i"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1204190934500.2070-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--XA3zunQti4u0IH5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2012 at 09:43:45AM -0400, Alan Stern wrote:
> Below is a patch that will prevent any PCI device from being put into
> D3 during suspend.  (This is meant to be used without any of the
> earlier diagnostic patches.)  Obviously it's not the final solution;=20
> the test in the "if" statement needs to be more discriminating.  :-)
>=20
> But before going any farther, I'd like to test if USB wakeup works. =20
> So after booting with this patch, make sure that the power/wakeup file
> says "enabled" in the sysfs path for each controller as well as the
> usb1, usb2, 1-2, and 2-2 paths under /sys/bus/usb/devices/.
>=20
> Then suspend the computer without using the script, and while it is
> asleep try plugging in a new USB device.  That should cause the
> computer to wake up, if everything is working properly.
I've set "enabled" for following files:

/sys/bus/usb/devices/usb1/power/wakeup
/sys/bus/usb/devices/usb2/power/wakeup
/sys/bus/usb/devices/1-1/power/wakeup
/sys/bus/usb/devices/2-1/power/wakeup
/sys/bus/pci/devices/0000:00:1a.0/power/wakeup
/sys/bus/pci/devices/0000:00:1d.0/power/wakeup

yet it didn't wake up after plugging, though devices light up.


> Index: usb-3.4/drivers/pci/pci.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-3.4.orig/drivers/pci/pci.c
> +++ usb-3.4/drivers/pci/pci.c
> @@ -1713,6 +1713,8 @@ int pci_prepare_to_sleep(struct pci_dev
>  	pci_power_t target_state =3D pci_target_state(dev);
>  	int error;
> =20
> +	if (1)
> +		target_state =3D PCI_D0;
>  	if (target_state =3D=3D PCI_POWER_ERROR)
>  		return -EIO;
> =20
>=20
>=20

--=20
WBR, wRAR

--XA3zunQti4u0IH5i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPkD2/AAoJEDNi9wMaSZLhzd8P/Axfau7nxrWO4ccrGoLzm5Qu
vuHJyYv1JH2OLtgaG6OVG1J3GYp6MDLbSE9fFYiW/SR0k9lbu1rds/uxt8ntugr/
zmMws1Ant4GlDHQYT9WcENQrxEQVomeGioFzioCG6uH1AZXxHVi4sFzL+mq9Z5ov
DqmeFpMnkGrzVzEygP91egUiKjHmwzjXaUAE6qCL2ZqIn3T2XKKW7HccmH0mtjzs
9huawaHpUBLfWdR43cebjcx/ICymn2n2ECC7+WuHDfF4159bmwRYaazMLDWKoAUp
g9SzbyutD649WVkoP4sg1fiG8PA0/fkBtFlaqyJnx3fgVjtp+mklor3S3QDzAPGm
Kv4fxFkOAfCAM9L/vhiq0msiiVDRMRTKlwfObtpTSmtoA5D7HKmf32mMa+E0wxYT
oNpUu4mtA5QITl2MA7Oz5wu5vY3oAC4BUBStTXCGRXLWlHCXCOciFEDP0tH1I+TP
uNkR2WrnO51lvwM23U9XKgGBfKbZvSVK1lOxHKoTLPs+jPEsDV3B4JQoZnaZuR7v
UUXPLfYyrqWZIPhvNtXxNPxFCSrXftlZhfA49IcINJ5tX7d5ja1qTWgsHdjP8B9o
z6M8zj2HRQbeI4uIqLwRcmuEV4lZVdwgTD64eTYeTmY16ARfpkb+qzDw5mC6ncgx
4Lj12k0Bv7AHaMDzktRo
=ZLUa
-----END PGP SIGNATURE-----

--XA3zunQti4u0IH5i--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
