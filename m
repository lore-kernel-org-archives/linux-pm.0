From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 14 Jun 2006 10:29:20 +1000
Message-ID: <200606141029.27157.ncunningham@linuxmail.org>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<200606141000.12260.ncunningham@linuxmail.org>
	<20060614001844.GA31458@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0813744250=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060614001844.GA31458@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============0813744250==
Content-Type: multipart/signed; boundary="nextPart7779532.l02eYgWG8v";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart7779532.l02eYgWG8v
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 14 June 2006 10:18, Greg KH wrote:
> On Wed, Jun 14, 2006 at 10:00:08AM +1000, Nigel Cunningham wrote:
> > Hi.
> >
> > On Wednesday 14 June 2006 09:46, Linus Torvalds wrote:
> > > On Tue, 13 Jun 2006, David Brownell wrote:
> > > > Here's a related patch (well, "hack") I found helpful ...
> > > > specifically to help let _serial_ consoles be more useful.
> > >
> > > I just checked.
> > >
> > > I think exactly _two_ of the six machines I have around my desk have
> > > serial ports, and of those two, one is permanently turned off because
> > > it's old, noisy, and just not interesting.
> > >
> > > Maybe I'm more progressive than most, but I personally consider serial
> > > lines pretty much dead.
> >
> > Usb to serial converters are not completely unheard of, though. My old
> > omnibook even came with one. It's the one bit I still use :)
>
> But you need interrupts to work for usb to serial devices, and the whole
> usb stack up and running.  Even though you can get console messages
> through these devices, it's a bad hack and I wouldn't recommend it for
> anyone.

Yeah. That converter is far more useful for being the debugger instead of t=
he=20
debuggee. I should have thought more carefully before speaking. Sorry.

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart7779532.l02eYgWG8v
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEj1hnN0y+n1M3mo0RAsIXAKDrri7ChR54+VjnlLDSsZDPoMaOpQCgzE/Q
vx6KUfMcV7BxdGuPCUB7r98=
=l/oW
-----END PGP SIGNATURE-----

--nextPart7779532.l02eYgWG8v--

--===============0813744250==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0813744250==--
