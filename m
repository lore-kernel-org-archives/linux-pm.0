From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: Re: Hibernate after alarm wakes from STR
Date: Wed, 11 Jul 2007 08:16:40 +1000
Message-ID: <200707110816.42114.nigel__6739.31880523941$1184105860$gmane$org@nigel.suspend2.net>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200707101245.31449.nigel@nigel.suspend2.net>
	<200707100951.04193.david-b@pacbell.net>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0193373648544745024=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707100951.04193.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: rtc-linux@googlegroups.com, linux-acpi@vger.kernel.org, nigel@suspend2.net, Richard Hughes <hughsient@gmail.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============0193373648544745024==
Content-Type: multipart/signed; boundary="nextPart1624469.0v1O9RDvfr";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1624469.0v1O9RDvfr
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 11 July 2007 02:51:03 David Brownell wrote:
> On Monday 09 July 2007, Nigel Cunningham wrote:
> > Hi.
> >=20
> > On Tuesday 10 July 2007 02:26:32 David Brownell wrote:
> > > On Monday 09 July 2007, Marcelo Tosatti wrote:
> > > > On Sun, Jul 08, 2007 at 07:44:03PM -0700, David Brownell wrote:
> > >=20
> > > > > Better a /sys/power/wakeup_event (or whatever) that's more easily
> > > > > found.  It could link to the device issuing the event.
> > > >=20
> > > > As you mentioned, there might be two wakeup sources (RTC and power
> > > > button for instance) or even more at the same time.
> > >=20
> > > Actually I though I said that there would be races.  Though come
> > > to think of it, one way they'd show up on a typical embedded system
> > > would be to have multiple wake IRQs pending ... you couldn't tell
> > > which one came first.  (The typical case would be a single event,
> > > of course.)  ACPI-ish systems would do that with GPEs and the
> > > magic "rtc woke" flag.
> > >=20
> > > And then there are shared IRQ lines serving as wake sources.  There
> > > could be three wake-enabled devices on that line (plus others that
> > > aren't wake-enabled); the drivers returning IRQ_HANDLED should likely
> > > be reported as having been wake sources, but not the ones returning
> > > IRQ_NONE ...
> > >=20
> > > ... so yes, systems might need to present multiple wake events.
> > >=20
> > >=20
> > > > Do you think its fine to simply but the device separated by spaces =
in
> > > > the wakeup_event file?
> > > >=20
> > > > Sounds fine by me, but what about the one-value-per-file sysfs rule?
> > >=20
> > > Better to have that node be a directory of links then, rather than
> > > a single link.
> > >=20
> > > Note that I'm just throwing ideas out there.  I suspect that
> > > in the general case it may not be easy to map from wake event
> > > to device, without infrastructure that's now missing.
> >=20
> > FWIW, I've recently added code to Suspend2 to allow it to (optionally) =
set=20
the=20
> > RTC wake alarm when it's finished writing the image and check the lid=20
switch=20
> > when waking, entering a different sleep state if the lid switch is stil=
l=20
> > closed. It achieves this by letting the user set the name of an rtc ala=
rm=20
to=20
> > use (the 'rtc0' in /sys/class/rtc/rtc0/*) and of a button to use (lid/L=
ID=20
> > in /proc/acpi/button/lid/LID/*). It then opens the button directory's=20
state=20
> > file and the rtc directory's since_epoch and wakealarm files, and uses=
=20
them=20
> > to determine read the time since epoch and set the wakealarm and determ=
ine=20
> > whether the lid button is still closed.
>=20
> Interesting...
>=20
> > I don't really like the opening /proc and /sysfs files in this way -=20
whatever=20
> > solution you come up with, could you consider exposing some way for ker=
nel=20
> > code to do this more neatly?
>=20
> You're supposed to be able to use /sys/... files this way!
>=20
> But that's not true of /proc/... files.

Yeah, the bit I consider to be ugly is opening the files from within the=20
kernel, but it seemed to be necessary in order to provide the functionality=
=20
without having to rely on userspace or do some sort of messy work to figure=
=20
out how to access the lid button and so on.

Re proc files, are the button files already exposed under sysfs and I just=
=20
don't know? If so, I'll happily shift to using them.

Regards,

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1624469.0v1O9RDvfr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGlAVKN0y+n1M3mo0RAo4mAKCCGQHs/XILN330AW4fGSiWxsxBNACfbGuw
Gw+ARm1dPdIP/SrEAf3NMTw=
=bM7q
-----END PGP SIGNATURE-----

--nextPart1624469.0v1O9RDvfr--

--===============0193373648544745024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0193373648544745024==--
