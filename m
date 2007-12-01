From: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: WARNING: at kernel/resource.c:189 __release_resource
Date: Sat, 1 Dec 2007 22:01:20 +0100
Message-ID: <20071201220120.15f4fd49__8095.26353045857$1196697459$gmane$org@poseidon.drzeus.cx>
References: <4745F77C.7040402@gmail.com>
	<20071126220538.1aed9c33.akpm@linux-foundation.org>
	<200711291640.38158.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3958203080348811517=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711291640.38158.bjorn.helgaas@hp.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Matthew Wilcox <matthew@wil.cx>, Greg KH <gregkh@suse.de>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============3958203080348811517==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1;
	boundary="=_hera.drzeus.cx-3439-1196542881-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hera.drzeus.cx-3439-1196542881-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Nov 2007 16:40:37 -0700
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

>=20
> The corresponding PCI code in pci_device_suspend() does not do
> any generic device disable or resource release.  I don't know
> why PNP disables the device on suspend.  I glanced through the
> ACPI spec but didn't see a requirement for it.  Maybe Pierre [1]
> remembers.
>=20

Afraid not. There was a reason for it, but my mind draws a blank as to what=
 that was... I have a slight recollection of bad BIOS interaction during ST=
R, but I'm not sure it was related to this specific patch.

Rgds
Pierre

--=_hera.drzeus.cx-3439-1196542881-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHUcug7b8eESbyJLgRAvw+AKDvTib2vHpkDdXwiz8ay9SmtVUW2QCfbE0c
bjqMg+x+TzV3lu/mygu89xI=
=uxzS
-----END PGP SIGNATURE-----

--=_hera.drzeus.cx-3439-1196542881-0001-2--

--===============3958203080348811517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3958203080348811517==--
