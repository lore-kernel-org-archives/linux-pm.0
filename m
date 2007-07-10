From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: Re: Hibernate after alarm wakes from STR
Date: Tue, 10 Jul 2007 12:45:30 +1000
Message-ID: <200707101245.31449.nigel__13298.7582394437$1184035569$gmane$org@nigel.suspend2.net>
References: <20070330235759.GC4252@cosmic.amd.com> <20070709154014.GF27828@dmt>
	<200707090926.32826.david-b@pacbell.net>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8156311615834262550=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707090926.32826.david-b@pacbell.net>
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
Cc: Richard Hughes <hughsient@gmail.com>, rtc-linux@googlegroups.com, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============8156311615834262550==
Content-Type: multipart/signed; boundary="nextPart1633309.Asmc9IrAUR";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1633309.Asmc9IrAUR
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 10 July 2007 02:26:32 David Brownell wrote:
> On Monday 09 July 2007, Marcelo Tosatti wrote:
> > On Sun, Jul 08, 2007 at 07:44:03PM -0700, David Brownell wrote:
>=20
> > > Better a /sys/power/wakeup_event (or whatever) that's more easily
> > > found.  It could link to the device issuing the event.
> >=20
> > As you mentioned, there might be two wakeup sources (RTC and power
> > button for instance) or even more at the same time.
>=20
> Actually I though I said that there would be races.  Though come
> to think of it, one way they'd show up on a typical embedded system
> would be to have multiple wake IRQs pending ... you couldn't tell
> which one came first.  (The typical case would be a single event,
> of course.)  ACPI-ish systems would do that with GPEs and the
> magic "rtc woke" flag.
>=20
> And then there are shared IRQ lines serving as wake sources.  There
> could be three wake-enabled devices on that line (plus others that
> aren't wake-enabled); the drivers returning IRQ_HANDLED should likely
> be reported as having been wake sources, but not the ones returning
> IRQ_NONE ...
>=20
> ... so yes, systems might need to present multiple wake events.
>=20
>=20
> > Do you think its fine to simply but the device separated by spaces in
> > the wakeup_event file?
> >=20
> > Sounds fine by me, but what about the one-value-per-file sysfs rule?
>=20
> Better to have that node be a directory of links then, rather than
> a single link.
>=20
> Note that I'm just throwing ideas out there.  I suspect that
> in the general case it may not be easy to map from wake event
> to device, without infrastructure that's now missing.

=46WIW, I've recently added code to Suspend2 to allow it to (optionally) se=
t the=20
RTC wake alarm when it's finished writing the image and check the lid switc=
h=20
when waking, entering a different sleep state if the lid switch is still=20
closed. It achieves this by letting the user set the name of an rtc alarm t=
o=20
use (the 'rtc0' in /sys/class/rtc/rtc0/*) and of a button to use (lid/LID=20
in /proc/acpi/button/lid/LID/*). It then opens the button directory's state=
=20
file and the rtc directory's since_epoch and wakealarm files, and uses them=
=20
to determine read the time since epoch and set the wakealarm and determine=
=20
whether the lid button is still closed.

I don't really like the opening /proc and /sysfs files in this way - whatev=
er=20
solution you come up with, could you consider exposing some way for kernel=
=20
code to do this more neatly?

Regards,

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1633309.Asmc9IrAUR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGkvLLN0y+n1M3mo0RAha4AJ9wpmItfkcrZ6MhhkK0oMiXX360dgCcDwPm
On5WSvNP5Lp07+++kSaXK+k=
=UhIT
-----END PGP SIGNATURE-----

--nextPart1633309.Asmc9IrAUR--

--===============8156311615834262550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8156311615834262550==--
