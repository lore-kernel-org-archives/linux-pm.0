From: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 19 Apr 2012 21:53:09 +0600
Message-ID: <20120419155309.GA11484@belkar.wrar.name>
References: <Pine.LNX.4.44L0.1204181729400.1149-100000@iolanthe.rowland.org>
 <Pine.LNX.4.44L0.1204190934500.2070-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nuX4E7Vid9I2gnPU"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1204190934500.2070-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--nuX4E7Vid9I2gnPU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2012 at 09:43:45AM -0400, Alan Stern wrote:
> But before going any farther, I'd like to test if USB wakeup works. =20
> So after booting with this patch, make sure that the power/wakeup file
> says "enabled" in the sysfs path for each controller as well as the
> usb1, usb2, 1-2, and 2-2 paths under /sys/bus/usb/devices/.
Also, I don't have [12]-2 there:

1-0:1.0 -> ../../../devices/pci0000:00/0000:00:1a.0/usb1/1-0:1.0
1-1 -> ../../../devices/pci0000:00/0000:00:1a.0/usb1/1-1
1-1.1 -> ../../../devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1
1-1.1:1.0 -> ../../../devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:=
1.0
1-1.1:1.1 -> ../../../devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:=
1.1
1-1.2 -> ../../../devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2
1-1.2:1.0 -> ../../../devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:=
1.0
1-1.2:1.1 -> ../../../devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:=
1.1
1-1:1.0 -> ../../../devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1:1.0
2-0:1.0 -> ../../../devices/pci0000:00/0000:00:1d.0/usb2/2-0:1.0
2-1 -> ../../../devices/pci0000:00/0000:00:1d.0/usb2/2-1
2-1:1.0 -> ../../../devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.0
usb1 -> ../../../devices/pci0000:00/0000:00:1a.0/usb1
usb2 -> ../../../devices/pci0000:00/0000:00:1d.0/usb2

--=20
WBR, wRAR

--nuX4E7Vid9I2gnPU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPkDTkAAoJEDNi9wMaSZLhRzAP/A+hVFYqY4lwurMKCEFrYM7e
sL7zDjc4X3aHlhBYj9BDN0s6g0VAJ11uk+ltd1Rvkcw0lm1J1kMp0daaby0uW4YL
xYKKE+K9/PkOh9DiEwNxc357NEmMlXyxDrXlwMbZPyYJdMEsRWtdq4BWOMoCSesb
5UmiTXUlRZi4HXoIpeHqlyYAZddov7HaHlY8DJaszR5rDRtRLTuAyd6NtGtR0XIK
zQBUk7B53sy2B0598cpJdz8/dEtu0jAzvkNUn7FQboh7PxVUnyFvYMBWdt6IC9p8
Pxb0oyTfKJb+sRkNzysnC5SrktuA9uXYZIgu5Lrb9S2opW0jUib8aBzX0eYVSuhd
zE6eei+7XPFj07vAzPc8yT0JdUO4xkmg07A3718rmX79+6vfjKgpOy1Sw+gyovMw
gbGQYRleShDtvN+SmxounQ2+iAGHKzAA3K964BfcNLZF9tb9LwqXBfu5tlb9ADwV
EYZlAsl5ScRFRkjQmPtjWdPhDfR+xrJxE2rk9yc/0mBQg649jpAXmszxRkBQvUD8
ibtNkZwsApvpPBO/emQIOVC1tw4UOq3UaKHA8OF9JIY0iGxzzrX7zI0qj9xmBVpC
BhSQ4Dt4YvekKFJIt+ejXqO7Mu0tjD9u9hKl1ewZJ8OneKBwGMbKcvMGOzOqd1F9
yV8uvXMhPZU0sDDQZ0Ag
=hAoH
-----END PGP SIGNATURE-----

--nuX4E7Vid9I2gnPU--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
