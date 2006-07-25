From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: bus.suspend_prepare()
Date: Wed, 26 Jul 2006 08:24:11 +1000
Message-ID: <200607260824.15221.ncunningham@linuxmail.org>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<Pine.LNX.4.64.0607251127420.29649@g5.osdl.org>
	<200607251217.48960.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1161723494=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607251217.48960.david-b@pacbell.net>
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
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============1161723494==
Content-Type: multipart/signed; boundary="nextPart8951038.Tu0eWcuHIg";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart8951038.Tu0eWcuHIg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 26 July 2006 05:17, David Brownell wrote:
> On Tuesday 25 July 2006 11:29 am, Linus Torvalds wrote:
> > On Tue, 25 Jul 2006, David Brownell wrote:
> > > Hmm ... I just noticed that the swsusp code path (PM_SUSPEND_DISK)
> > > is ignoring the new suspend_prepare() mechanism.
> > >
> > > That doesn't seem like a good thing ... Linus, is there a reason you
> > > did it that way?
> >
> > Just because I found that neither interesting nor testable in my
> > environment.
>
> Yeah, testable is an issue.  Maybe a better fix would be to remove
> the bus.suspend_prepare() operation for now.  Someone with real use
> cases could easily add a complete working package that includes that
> mechanism plus some testable code that needs it.

Not knowing anything about the actual details of the problem, I wonder if=20
these new calls would help with that acpi issue where it tries to allocate=
=20
memory with GFP_KERNEL during drivers suspend. Would it be helpful to=20
allocate it at this point instead, and free it in a matching call at resume=
=20
time? Perhaps a similar scheme could be useful for video drivers (cough fgl=
rx=20
cough) that might want to allocate large amounts of memory when dri is=20
enabled?

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart8951038.Tu0eWcuHIg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBExpoPN0y+n1M3mo0RAvdUAKDVvMG2NahYW0akLKwAy7M8jhcCdACgtGMJ
lRV0F/Phn87H8C59Y5H0DwY=
=B3wU
-----END PGP SIGNATURE-----

--nextPart8951038.Tu0eWcuHIg--

--===============1161723494==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1161723494==--
