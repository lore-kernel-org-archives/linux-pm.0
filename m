From: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 22:49:03 +0600
Message-ID: <20120412164903.GB12852@belkar.wrar.name>
References: <20120412153750.GA12852@belkar.wrar.name>
 <Pine.LNX.4.44L0.1204121203530.1496-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1204121203530.1496-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2012 at 12:09:00PM -0400, Alan Stern wrote:
> > > Here's a diagnostic patch that will give us a little more information=
=2E =20
> > > Keep the previous change (so that pci_prepare_to_sleep gets called=20
> > > whether ehci-hcd is bound or not) and let's see what it says.  Try=20
> > > doing it both with and without ehci-hcd bound.  Running this with "ec=
ho=20
> > > devices >/sys/power/pm_test" ought to be good enough.
> > I don't see that line with ehci_hcd both bound and unbound and both in
> > 'devices' test and in a real S3.
>=20
> You mean the new dev_info message did not appear at all?  Is
> pci_prepare_to_sleep getting called properly?  Or does the routine exit
> early because target_state is equal to PCI_POWER_ERROR?
Either dev_info is silenced on my system or pci_pm_suspend_noirq is not
called during the 'devices' pm test.

--=20
WBR, wRAR

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPhwd/AAoJEDNi9wMaSZLhDy4P/3bYY5WL3itEO1t7kf1itAtr
jVFZk4TIVdTjPJOeLIC/3bBJPYKVM4nnoAsxZxsw038tGnPAFA1dYY1K4jA7ihzX
TBiLnNhBosb6TUUQDZYYCDgpuxUjO2GyeiQfoC1ddUs5dDIevYhBH2u1XxUZmyAW
QNZPTQrPUs5pNqyTaHOV4OlMVSNzLcENSyf3Nnkleq3GhhKRoz9SSAXyQA8K3lSh
OLXzyvZ55P0lPlSKeDTqH1CbMdTvyQaQeGiPQgRxcL/4Q41Vizb2EPJ9YPBTBi55
IFoIuKQWRIjhFqBj/TYJigr+eM/aVXaSvGo6YwgPkL2FSQD5Qq84gkUPp/u+Tzv0
RjHyfWdE9aJfdLe8FDCJrMa5qtIyx6JsRO3C/OYrEXqbGbLwzHvtqr0qffADyzpF
Cy3EF2xDTJCJEGiQJT5vA6bshZsNY4zAXyot8KDK34jw39XRoY9fc/Oz5UmNW4+a
z/s5HqvWfo6YQc6tlKPvqZevPBAT9G9z0d88DDHkSbMuiKFqrHXPsL0CRjmYWR7P
/al49SmO8s2McM+7JdKGELcCuox33aAjGumsqI9Att3ExJO70rZCrPhTpvJwh2Z7
nv/sSTu55MSLkJmmK9BFwFRK7BgdYw5jsgYBkI8ZGmimdWczHX0n7p8nUQsGvOrE
xCWoyhyx46vTfK4zMdlL
=ARJx
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
