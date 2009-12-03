From: Pierre Ossman <pierre@ossman.eu>
Subject: Resume hanging on MSI motherboard
Date: Thu, 3 Dec 2009 21:46:22 +0100
Message-ID: <20091203214622.0cf1716d@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4555957689360948393=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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

--===============4555957689360948393==
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-3370-1259873190-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-3370-1259873190-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I have a MSI Neo2-Digital board that I'm trying to get suspend working
on. I'm not having much luck though, so I need some pointers on how to
debug this.

The symptoms are that the machine shuts down when suspend is triggered
and wakes up when the power button is pressed or an usb device pokes
it. Unfortunately it never gets back to a running state. It rattles a
bit on the disk, powers up the fans and turns on the LEDs, but that's
it.

Doing a suspend in Windows has entirely different behaviour. There it
keeps all fans running, and doesn't do much in the way of saving power.
It goes from 90 W to 67 W from idle to "standby". The [broken] state
Linux puts the system in OTOH runs at 13 W ("off" is 10 W).

I've been trying to use pm_trace to debug where things lock up, but I'm
not able to get it to work. I do "echo 1 > /sys/power/pm_trace" and
then suspend the machine. But at the next boot, the clock is still sane
so it seems like the PM code never stores anything.

Help :/

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by FRA, a
  Swedish intelligence agency. Make sure your server uses
  encryption for SMTP traffic and consider using PGP for
  end-to-end encryption.

--=_freyr.ossman.eu-3370-1259873190-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iEYEARECAAYFAksYI6EACgkQ7b8eESbyJLh2OACg6FgTgaRw1TiluYluBPSdt6Qk
0vYAmwWY5hPkEAdKp1HD9wVBKbaFw6LE
=hQB3
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-3370-1259873190-0001-2--

--===============4555957689360948393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4555957689360948393==--
