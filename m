From: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: [alsa-devel] PNP_DRIVER_RES_DISABLE breaks swsusp at
 least with snd_cs4236
Date: Sat, 12 Jan 2008 16:21:50 +0100
Message-ID: <20080112162150.1ec9cad0__31392.9990436465$1200151421$gmane$org@poseidon.drzeus.cx>
References: <200801092343.48726.linux@rainbow-software.org>
	<20080111080141.75aaad5f@poseidon.drzeus.cx>
	<47877B83.5040604@keyaccess.nl>
	<200801111940.22023.linux@rainbow-software.org>
	<4788168F.8070403@keyaccess.nl>
	<20080112121256.0f2e96ad@poseidon.drzeus.cx>
	<4788C323.6090206@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4293967746240508843=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4788C323.6090206@keyaccess.nl>
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
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Andrew Morton <akpm@osdl.org>, ALSA development <alsa-devel@alsa-project.org>, Ondrej Zary <linux@rainbow-software.org>, Takashi Iwai <tiwai@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: linux-pm@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============4293967746240508843==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1;
	boundary="=_hera.drzeus.cx-4890-1200151324-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hera.drzeus.cx-4890-1200151324-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 12 Jan 2008 14:39:47 +0100
Rene Herman <rene.herman@keyaccess.nl> wrote:

> On 12-01-08 12:12, Pierre Ossman wrote:
>=20
> > I'm a bit confused here. Bjorn Helgaas wanted to remove the pnp_start/s=
top_dev() calls completely, and you want them called all the time. :)
>=20
> Wanted where? Haven't seen a coment from Bjorn? But -- while removing the=
m=20
> both looks (as) sensible from a mirror-image viewpoint, this wouldn't fix=
=20
> the problem.
>=20

Ah, sorry. It was a different thread. Look for a mail with the subject "PNP=
: do not stop/start devices in suspend/resume path" in the LKML och linux-p=
m archives.

>=20
> But we certainly need the pnp_start_dev() in the current flow of things. =
It=20
> not being called is the problem this fixes...
>=20

I think the previous suggestion was that the drivers should call this, not =
the core, so that it behaved more like other parts of the kernel (e.g. PCI).

Rgds
Pierre

--=_hera.drzeus.cx-4890-1200151324-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkeI2w8ACgkQ7b8eESbyJLjRVACgnkH1P1ypKhQ57QRfWCHJcp8T
ej4AnjEEuZ7v+44+fSpQOwUFQ65jcOFn
=2sNB
-----END PGP SIGNATURE-----

--=_hera.drzeus.cx-4890-1200151324-0001-2--

--===============4293967746240508843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4293967746240508843==--
