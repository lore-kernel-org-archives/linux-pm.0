From: Pierre Ossman <pierre-list@ossman.eu>
Subject: Re: Resume hanging on MSI motherboard
Date: Fri, 23 Jul 2010 12:40:23 +0200
Message-ID: <20100723124023.75e53814@mjolnir.ossman.eu>
References: <20091204081739.575b29d5@mjolnir.ossman.eu>
	<200912081338.56941.rjw@sisk.pl>
	<20091208233553.498e1442@mjolnir.ossman.eu>
	<200912082343.30195.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8106039189422824937=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912082343.30195.rjw@sisk.pl>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============8106039189422824937==
Content-Type: multipart/signed; micalg=PGP-SHA256; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-6487-1279881629-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-6487-1279881629-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I decided to resume (hah) this old project and this time I actually
made some immediate progress.

The issue used to be that the machine failed to resume properly,
hanging somewhere during the startup process. In Windows, it suspended
and resumes properly, but left most of the machine running.

The above is now solved. I found "ACPI Suspend mode" in the BIOS, which
had a large effect on the behaviour. It was previously set to S1 (which
I guess was what Windows successfully ended up in, hence the high power
usage). Setting it to S3 makes Windows work perfectly (suspend wise at
least). Linux works a lot better, but has two issues remaining:

1. Graphics gets screwed up with v2.6.34-rc5-10802-g733029f. Works fine
with 2.6.33.5-112.fc13.x86_64 though. Should probably test latest
tree...

2. Machine fails to wake properly using the IR remote. This works fine
in Windows, but not in Linux. As this is a HTPC, this is pretty crucial
for everything to come together. :/

The IR receiver itself seems to be put in somewhat proper mode as it
lights up when the machine is suspended and it gets the power signal
from the remote. The machine doesn't react though. It does wake up on
activity from the USB connected keyboard, so triggering resume from USB
seems to be working.

Any ideas on things to mess with when it comes to USB triggered resume?

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by FRA, a
  Swedish intelligence agency. Make sure your server uses
  encryption for SMTP traffic and consider using PGP for
  end-to-end encryption.

--=_freyr.ossman.eu-6487-1279881629-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iF4EAREIAAYFAkxJcZoACgkQopDLsoqlmEKEqwEAqTsdIf2Vqfq3lFX43+1dPEKb
SUx5j9cP2SCoUegI9fwA/3Epja/IPEh2+7wT5d/AwP9dygBMHfP7gqE0powGaGS8
=b2og
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-6487-1279881629-0001-2--

--===============8106039189422824937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8106039189422824937==--
