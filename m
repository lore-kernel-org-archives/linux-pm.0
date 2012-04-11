From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 04:09:44 +0600
Message-ID: <20120411220944.GC3677@belkar.wrar.name>
References: <1334177035.23924.299.camel@gandalf.stny.rr.com>
	<Pine.LNX.4.44L0.1204111703180.1351-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6257655862861496996=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1204111703180.1351-100000@iolanthe.rowland.org>
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
Cc: jrnieder@gmail.com, Greg KH <greg@kroah.com>, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org


--===============6257655862861496996==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2012 at 05:13:51PM -0400, Alan Stern wrote:
> > I replaced the hcd_pci_suspend_noirq call with retval=3D0 and suspend/r=
esume
> > was successful.
> =20
> This indicates that your computer doesn't like to suspend while the
> EHCI controllers are in D3hot.  I have no idea why not.
>=20
> If you want a really thorough test, try changing=20
> drivers/pci/pci-driver.c:pci_pm_suspend_noirq.  In the "if (!pm)"=20
> clause, add a call to
>=20
> 	pci_prepare_to_sleep(pci_dev);
>=20
> just after the pci_save_state line.  Then try suspending with the=20
> script enabled (ehci-hcd unbound from the controllers).  If this fails=20
> then we'll know it is the source of the trouble.
Looks like it works even with this line added.

--=20
WBR, wRAR

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPhgEoAAoJEDNi9wMaSZLhkvAP/RgW1Cha019RXRRoNXYZQRRz
MbqmwbvDOSOo3Edjh89FZpynTY0k0fcehpTLlGkWfttFqSJ9RVT8u9eIs0atTmPP
nIIBjOa3BXS26Pys+ZoI6tn6P/gEV++/QYAm9nvLl5jggeNofJoUQd44FqCssjYN
IKTV7tRIk7kc2rmXei0TZ18mjqYhjCAIpFX6PLcumkQUSLkFGUzyUXY+R95020WQ
VytSkd6pKeFoYfAB5dsBiT4M7ezb5Rvk6vOKxB7zzSuzyNjZZxYXkR3g+d2UdYk8
SEbB90LrKYqDb37hqMrqaEoXLk2i0Nb+5hDTVKgZeCAY0gyONaxbM2+7rASgB+aw
alsPYBn7zUUGlL/IwUsTKrOwJnSNbQij2g9zWNv7Mlkir82VNjawsn4uHqMJqJum
A1OuJAFixVp+3ivVe8U11WPNv3abi9EgYOhnjfYos9ZWZT8sT8w9500qJdvTo+Ll
tSzbha7FVdN1kYbwNlUQgkYxtHRrATJCyZNolDXDyWjKJIe6df5S5WMxND6rforJ
x8Q8RhgOVrBWL6zmDBrf2awhkLIQ04yeIOSJHEl2TJp73+mO2R9Eq/R1oNM9NIFa
Iw4g5wSPQiV1R9t8p5g9cxfmzsdVnZK5718uBEsVQIiibj5QQ9ffccr5RW52tYUD
ZwluwNiWA3vXUh2nXHUl
=q3Vl
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--

--===============6257655862861496996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6257655862861496996==--
