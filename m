From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 19 Apr 2012 03:47:06 +0600
Message-ID: <20120418214706.GX11484@belkar.wrar.name>
References: <Pine.LNX.4.44L0.1204181727580.1149-100000@iolanthe.rowland.org>
	<201204182344.16986.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5461567883556440807=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201204182344.16986.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: jrnieder@gmail.com, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org


--===============5461567883556440807==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fBT78PV5vI5fyuAn"
Content-Disposition: inline


--fBT78PV5vI5fyuAn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2012 at 11:44:16PM +0200, Rafael J. Wysocki wrote:
> > > > Yes, there are ways to work around this.  At the moment I'm not sur=
e=20
> > > > what would be best; we can ask Rafael.  One big remaining puzzle: W=
hy=20
> > > > are the EHCI controllers the only devices that cause a crash when l=
eft=20
> > > > in D3 during suspend?  We may never know...
> > >=20
> > > Are they put into D3 by ACPI or using the native PCI PM?
> >=20
> > PCI PM, definitely.  Maybe ACPI gets into the act as well, but I doubt=
=20
> > it.  How would we tell?
>=20
> If ACPI is involved, the dev_printk() in acpi_pci_set_power_state() should
> trigger.
And it apparently doesn't?

--=20
WBR, wRAR

--fBT78PV5vI5fyuAn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPjzZaAAoJEDNi9wMaSZLhrncQAJFM/ndUCN9rQrY0+PI3oeLT
yvz+26gvGmEDdEv6mzhpk4muXag+iowRauhG2AsL5n2YBedUo10KMNJ7C7J8vvdJ
/2RY57bFILV8AnxbMQA8Ludk78yEIxUNrGrfvGP5hcbvFzqWbmLey20imAqWLcbk
vyFqShd7pEZGhU3WHRqCxSPilkK7BvlA3Q1jnH/ZcNghU0scDOwalujdDothnu0Q
QJVrwPVYZ9d4GEw4yQpxkPombrprvSSMDKM+HTng3B92Jp/1jtFVb6vODmBxfl+9
qQUsLNGulbhQWFeeXxvpAGTnqsYCu/AEjF/FtILoiZph6zsoENo3j+8qHBwMqg+M
Lm8TdxR1tvbRQp0O1FllpffrM2zYZHVwVMTENPNoFtCE2eTa9uaQcPxnZm/0Igp9
17lXTEtRjfsh9GDPl+btOo45rUf4eXdMTYdvcU5BWoKsu3pE6AepGpNigSAkTYAi
h5NHy0qDT19tfaDao6otFI4nVHZFgIBtl8dSYAP3AkInnJd8NtupjL/oUNPTZ8rH
8t8bde5L3ilGKvhJZr09zCKEESPJjdNWmc4ny9Ite3w2UzZBL1z7/JG31KtwUZRH
kcHWti9hEE09oPpvkBWKEJtqzlVKMLI0u7288GnrHnF9UtZefZ4/lDNQ3UFP68MN
klzVqFGeZIQFBOVyNsTO
=dBvo
-----END PGP SIGNATURE-----

--fBT78PV5vI5fyuAn--

--===============5461567883556440807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5461567883556440807==--
