From: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: [alsa-devel] PNP_DRIVER_RES_DISABLE breaks swsusp at
 least with snd_cs4236
Date: Sat, 12 Jan 2008 12:12:56 +0100
Message-ID: <20080112121256.0f2e96ad__21696.9448062175$1200136473$gmane$org@poseidon.drzeus.cx>
References: <200801092343.48726.linux@rainbow-software.org>
	<20080111080141.75aaad5f@poseidon.drzeus.cx>
	<47877B83.5040604@keyaccess.nl>
	<200801111940.22023.linux@rainbow-software.org>
	<4788168F.8070403@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6050576293923477803=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4788168F.8070403@keyaccess.nl>
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

--===============6050576293923477803==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1;
	boundary="=_hera.drzeus.cx-2038-1200136380-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hera.drzeus.cx-2038-1200136380-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 12 Jan 2008 02:23:27 +0100
Rene Herman <rene.herman@keyaccess.nl> wrote:

>=20
> Pavel, Rafael -- the attached fixes snd-cs4236 not coming back to life fo=
r=20
> Ondrej after hibernation due to the PNP_DRIVER_RES_DO_NOT_CHANGE test=20
> triggering in pnp_bus_resume() and keeping the card in a suspended state.
>=20

I'm a bit confused here. Bjorn Helgaas wanted to remove the pnp_start/stop_=
dev() calls completely, and you want them called all the time. :)

Rgds
Pierre

--=_hera.drzeus.cx-2038-1200136380-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkeIoLgACgkQ7b8eESbyJLj/VgCfSrl42/rrBKsA/+nRBO1yzxVE
A3kAn3pJcADnfR1Py/DHdfz825zIOdqe
=UYs2
-----END PGP SIGNATURE-----

--=_hera.drzeus.cx-2038-1200136380-0001-2--

--===============6050576293923477803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6050576293923477803==--
