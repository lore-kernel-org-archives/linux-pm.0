From: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: Re: standby to disk transition
Date: Tue, 14 Mar 2006 10:21:18 +1000
Message-ID: <200603141021.23773.nigel@suspend2.net>
References: <E1FIctI-0000jE-00@porton.narod.ru>
	<20060313183318.GB26234@redhat.com>
	<20060313212420.GG10348@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============73641636203850114=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060313212420.GG10348@elf.ucw.cz>
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
Cc: "Victor Porton, , , " <porton@ex-code.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============73641636203850114==
Content-Type: multipart/signed; boundary="nextPart2231610.iLKGuFI7Cd";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2231610.iLKGuFI7Cd
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 14 March 2006 07:24, Pavel Machek wrote:
> On Po 13-03-06 13:33:18, Dave Jones wrote:
> > On Mon, Mar 13, 2006 at 10:13:32AM +0100, Pavel Machek wrote:
> >  > On Po 13-03-06 04:07:59, Adam Belay wrote:
> >  > > On Mon, Mar 13, 2006 at 09:50:42AM +0100, Pavel Machek wrote:
> >  > > > On Po 13-03-06 03:48:11, Adam Belay wrote:
> >  > > > > The timeout feature could be done using the ACPI alarm
> >  > > > > interface, but there's no reliable way of knowing how long the
> >  > > > > system can remain in a suspend state on the x86 mobile platfor=
m,
> >  > > > > so waking up at the right time would be tricky if not
> >  > > > > impossible.
> >  > > >
> >  > > > Make it an hour... System should be able to stay suspended for an
> >  > > > hour. IIRC Apple did something like this? I'd just be slightly
> >  > > > worried about machine waking up itself just when you hit the
> >  > > > turbulence in the airplane, or something like that.
> >  > >
> >  > > Hmm, but let's say the battery is 40% charged.  Then it's not very
> >  > > clear if it will last an hour.  All of a sudden the issue becomes
> >  > > system specific, or it may even depend on things like whether
> >  > > wake-on-lan is enabled, right?
> >  >
> >  > 40% battery should still last 10+ hours in suspend-to-RAM, unless
> >  > something is wrong.
> >  >
> >  > You *could* wakeup every minute or so to check the battery state; so=
me
> >  > PDAs actually do that.
> >
> > if suspend-to-disk is fast enough, you could just *always* write
> > to disk, even if we're doing S3.  If power runs out, you then have a
> > valid resume image on-disk.  iirc, this is what Windows does.
>
> Yep, I call that suspend-to-both. It is planned, but not really
> trivial, and I'm a little busy. If someone wants to help....

Actually it is really easy to do Pavel, so long as your code already has th=
e=20
error handling that allows it to back out nicely. Just enter S3 at the poin=
t=20
where you'd otherwise power down, then on resume act like an error occured =
at=20
the last moment and back out.

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart2231610.iLKGuFI7Cd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEFgyDN0y+n1M3mo0RAjzmAJ9iqbmxUEIK6RWiW9NBEK0eh3qsIwCgjrcI
qrruy7W1vC6ZDnlRF+g4PeI=
=wRFa
-----END PGP SIGNATURE-----

--nextPart2231610.iLKGuFI7Cd--

--===============73641636203850114==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============73641636203850114==--
