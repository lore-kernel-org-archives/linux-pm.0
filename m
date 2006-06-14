From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 14 Jun 2006 10:00:08 +1000
Message-ID: <200606141000.12260.ncunningham@linuxmail.org>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<200606131620.45156.david-b@pacbell.net>
	<Pine.LNX.4.64.0606131635430.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1644556358=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606131635430.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============1644556358==
Content-Type: multipart/signed; boundary="nextPart4465914.geYYjfuI4C";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4465914.geYYjfuI4C
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 14 June 2006 09:46, Linus Torvalds wrote:
> On Tue, 13 Jun 2006, David Brownell wrote:
> > Here's a related patch (well, "hack") I found helpful ... specifically =
to
> > help let _serial_ consoles be more useful.
>
> I just checked.
>
> I think exactly _two_ of the six machines I have around my desk have
> serial ports, and of those two, one is permanently turned off because it's
> old, noisy, and just not interesting.
>
> Maybe I'm more progressive than most, but I personally consider serial
> lines pretty much dead.

Usb to serial converters are not completely unheard of, though. My old=20
omnibook even came with one. It's the one bit I still use :)

> > Although I must say I like Nigel's "BDI-2000 per developer" hack better.
> > Even though not all boxes can hook up to a JTAG module.  :(
>
> Umm. Even more importantly, I don't think the JTAG interfaces for PC's are
> necessarily even available. There is read-out logic for ARM's and embedded
> PPC, but have you ever seen anything for something non-embedded?

Yeah. Sort of kills that idea, doesn't it?

> A really useful trick the PPC people use was to put the firewire
> controller into "anybody can read" mode, and use it as a kernel debugger
> when it basically becomes a remote memory DMA engine. I used that to debug
> some kernel hangs, and it was very nice.
>
> However, that won't survive a power event, so it might be useful to debug
> suspend problems, but generally not resume problems.

Since just about every problem occurs at resume time, it really does seem t=
o=20
me to be the case that we have to use the rtc. Great idea, by the way.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart4465914.geYYjfuI4C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEj1GMN0y+n1M3mo0RAo/UAJ49XhxkbdppywkQL1QrsDAxIc5cUACfcEDD
bHz1Z9bx8E+B/NT1E3tdyNw=
=OPDA
-----END PGP SIGNATURE-----

--nextPart4465914.geYYjfuI4C--

--===============1644556358==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1644556358==--
