From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ASUS K53E fails to suspend if ehci_hcd is loaded
Date: Fri, 17 Jun 2011 20:53:02 +0600
Message-ID: <20110617145302.GD4307__4323.07536616481$1308323153$gmane$org@belkar.wrar.name>
References: <20110616213605.GI7253@belkar.wrar.name>
	<Pine.LNX.4.44L0.1106171010580.2143-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0164206423124687699=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1106171010580.2143-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--===============0164206423124687699==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 17, 2011 at 10:14:16AM -0400, Alan Stern wrote:
> > > Okay, the next step is to try and find out exactly where the ehci=20
> > > suspend procedure is hanging.  The patch below adds a bunch of=20
> > > printouts at various spots throughout the procedure.  Let's see what=
=20
> > > shows up.
> > I don't see any of these new messages.
> Are you sure the new ehci-hcd.ko module was loaded when you ran the=20
> test?
Yes. I'll triple-check though.
=20
> Another thing you should do when testing:
>=20
> 	echo 9 >/proc/sys/kernel/printk
>=20
> (Or equivalently, Alt-SysRq-9 on the keyboard.)  I should have
> mentioned that before sending the test patch.  Oh well....
I used dmesg -n8.

--=20
WBR, wRAR

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJN+2pOAAoJEDNi9wMaSZLhuhgP/3r0BWNDthdCXIj9Ha7/+62Q
jeP48RJK3LjNgSIiToYYe9ID0wgZNFs0tIYLVYxZrrItZWrefM6fuJA+VBIpW/r8
WGrwoXHUIcOD1kimrywirxit22HTylR1ewk0wmOW8ITVSwu00IlGLL54mDe5wVVl
XfElbOWywDRKW+Vsdym9k6uCVjTe6k9SnaiyareCa2SxkOAChYiQJxO0nEMSFDI7
fDAcY+fox+uwP12FCHRatKSCD99sRAb63tSwmf3tDLKYQ0SuFgYbuQsx65yAiV3I
9NoAI1JGN0YaxuecNIhhd+qMIms6xPFl7YE1tOyrnnvw14fq2PktGOTEhupfx2Dj
gArXGUG/xjxpxOhIVB4EU3ZJp9BgyLTrYKPHT55xaSWM3LnDGlO7G+5LoBvVgKna
a6kfNEHB9+XVCsKkptqPxK2wGYDUEyXhFXzA4+FMunJK8XtFK4mkfUoJ5Zt/sVFQ
F1JdYoCCUzWPscSYxfYSP1ia1SdpYNr0FxYiN11Os6SJ6BMb35D8573u7/4dubfD
r1m3F1sVPgHEMpqB3SHlzazvvG/j4KL4rfXI5+oI5N9l586J09QaxcZBv0k0VAlQ
XaajxiSDC/VqA5KeRS+B4GvH2H3cGSP9B8UI1zCdwJljtHx1MWWx6n4hybnRv9gV
qk7cgnRFjBcH7NeT5G5T
=05aS
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--

--===============0164206423124687699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0164206423124687699==--
