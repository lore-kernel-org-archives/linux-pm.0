From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Tue, 17 Apr 2012 22:25:34 +0600
Message-ID: <20120417162534.GL11484@belkar.wrar.name>
References: <20120416211943.GE11484@belkar.wrar.name>
	<Pine.LNX.4.44L0.1204171057470.1364-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0561962512517146969=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1204171057470.1364-100000@iolanthe.rowland.org>
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


--===============0561962512517146969==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lHuqAdgBYNjQz/wy"
Content-Disposition: inline


--lHuqAdgBYNjQz/wy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2012 at 11:11:04AM -0400, Alan Stern wrote:
> Just to make sure, did you test the patch with the script installed=20
> (that is, with ehci-hcd unbound)?  I assume that will work normally.
It works normally, yes.

>=20
> Moving on, the next thing is to remove changes from the patch, one at a=
=20
> time, until we find one that prevents the system from resuming.  So,=20
> testing at each step, please remove from the patch:
>=20
> 	1. This change in hcd-pci.c:
> +	pci_dev->current_state =3D PCI_UNKNOWN;
It locks up if this line is removed.

> 	2. This change in ehci-pci.c:
> +	ehci_silence_controller(ehci);
>=20
> 	3. This change in hcd-pci.c:
> +	pci_disable_device(pci_dev);
>=20
> 	4. This change in hcd-pci.c:
> +	iounmap(hcd->regs);
>=20
> 	5. This change in hcd-pci.c:
> +	free_irq(hcd->irq, hcd);
>=20
> 	6. This change in hcd-pci.c:
> -	pci_disable_device(pci_dev);
> +	pci_disable_enabled_device(pci_dev);
>=20
> 	7. This change in ehci-pci.c:
> -	ehci_prepare_ports_for_controller_suspend(ehci, do_wakeup);
>=20
> Once all those things have been removed, the patch should be the same=20
> as one you tried earlier, which did crash the machine.

--=20
WBR, wRAR

--lHuqAdgBYNjQz/wy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPjZl+AAoJEDNi9wMaSZLhgAcP/0Dzx30QfnXR+XflquzF3UUi
om7mVFRVCkiDkPs2SJA7Q/QjDEJ15OlD6S4/SOprcmpreh9KuISsMmPZLi2hFtMz
BXKK/Q0msCYNI4ru2z7cJR8uUnDFEYey6ncqUlxxvVx/Z8DqvYF4a7tnzrxLDqSp
dtXJ/KSjGKupTrDJkegswIuzff9oMhYO5NlCzVUM1QzD7B1CVmA4DeaWJKwGlg1U
zxcC7LJkK5XCgw2SeEnhT9AixHjZh+73YFHiwZyPgRCiJ1xSXGO1pUEmYhgJXE3z
66PAXt429Lm6x44zQY9rVWGBIjJqUaMov2veVGGD1pqKcuS3N+Tnvw0Iqhho7HqC
uhaGtkDaiOKwGkABy49u/aQVVhDaofZ7qbufsTp87gyIp6PpZjsuuUAod4I8gylT
UYxLLq3v/Unn/DlnBuOttkeh3pCffe1WF+YsHajvR6PTWkbXesc3r1x4lnLKKrUe
gOnN5O+e40tXU0gFn2dUllDVuZJPOuR2Codhc/jatDgTb03gXVHyHD6M+ZNmk++T
G3ubGYHYJmOnIkBm+Xr1DRZzY1iLem6PVNZdfPgwWMra5racPlAkY09wQxa5K7IA
LXWoP4lewUVkw4/i0NqFpb2/MATJ/E5ojPL8Opo6aFUqL5Gd0R9HkuOnRyoHinCJ
Li8G5i9kSyjL4TItamH9
=Dj/n
-----END PGP SIGNATURE-----

--lHuqAdgBYNjQz/wy--

--===============0561962512517146969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0561962512517146969==--
