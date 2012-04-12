From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Fri, 13 Apr 2012 02:30:42 +0600
Message-ID: <20120412203042.GI12852@belkar.wrar.name>
References: <1334259347.23924.345.camel@gandalf.stny.rr.com>
	<Pine.LNX.4.44L0.1204121554320.1496-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9102172400510731116=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1204121554320.1496-100000@iolanthe.rowland.org>
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
Cc: jrnieder@gmail.com, Greg KH <greg@kroah.com>, USB list <linux-usb@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============9102172400510731116==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zgY/UHCnsaNnNXRx"
Content-Disposition: inline


--zgY/UHCnsaNnNXRx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2012 at 04:02:26PM -0400, Alan Stern wrote:
> Asumming you get the same result as Andrey, that the computer still
> hangs even with the ehci_reset() call, there's one more thing for the=20
> two of you to try.
>=20
> I noted before that with ehci-hcd bound, it would call=20
> pci_disable_device.  But with the driver unbound, the PCI core calls=20
> pci_disable_enabled_device instead.
>=20
> So let's have the driver do the same thing.  At the end of
> drivers/usb/core/hcd-pci.c:suspend_common, change pci_disable_device to
> pci_disable_enabled_device.  You'll also have to EXPORT that routine;
> it's defined in drivers/pci/pci.c.
>=20
> Do this with the ehci_reset added and all the other changes present as=20
> well.  Then there should be no difference at all between the two=20
> scenarios.
With
- pci_prepare_to_sleep in pci_pm_suspend_noirq
- pci_disable_enabled_device instead of pci_disable_device in
  suspend_common
- ehci_reset at the end of ehci_pci_suspend
it still locks up.

--=20
WBR, wRAR

--zgY/UHCnsaNnNXRx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPhztyAAoJEDNi9wMaSZLhiCgP/ig/yTwdgRb5YFVtKH8o7kee
ILYSNq7/xUmSo7yc2ct93ayjpKBzQdP8bMKzj1/fcpfPj8KMIJqS6x84hutgEngl
V6C4Z8Di6babcpW0LqmY5gZp2Amilqho9DA9FdM/+urAv70fzxEcHPvXE+DUR09M
CGasWv1uotgYB5zF093PPIfLN6k0kqJ7ZSmyU98Ton3htvJg8w0kyhk8Q0lleOfF
+Kk5V5yB87/LGLPqUXBqeYvrntk06cGq4WtRVzGxApV9Rmb6lWZjq9C4LRvSAaSN
zeGq1ibESugNWIyvPWs8fb5W2UB9cQS6ebAxzqzJgcxi22OuvpBRMaRkIfe84/fo
11MUl2NRH3gF2JASS75zgokkdvFUVRahrSSKtn5HLb7shgwHEezOcrIMDVcS0ojx
tNSAbSP54jmWZOxXC5tzGMWe6Q1N+SIF+FJgZHsDEMSfhaZ/qBIVIlMorxVma7Hs
00RybBVMKqbKOWCGJf5bDL3cpD6ieeBjxeiWc19dgaHs6vrq7SU4Xa7IvM16RMdF
dkX/HQF3ukkr4wHuQPv9JiiL0bSebRQqJBhiscseDkT4yB+4HixMgxyNPTzWb8Iy
Pec/Mdq9t2lI6T0WrYpkf927m3liSvdeJw23LLBzMKddAS+Mh0Z0L9fO6aKvoaDW
WXBBrERz4QgLy18m4Yvh
=6yW8
-----END PGP SIGNATURE-----

--zgY/UHCnsaNnNXRx--

--===============9102172400510731116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9102172400510731116==--
