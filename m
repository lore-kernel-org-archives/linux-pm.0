From: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Wed, 26 Apr 2006 08:18:11 +1000
Message-ID: <200604260818.20484.nigel@suspend2.net>
References: <200604241429.52022.david-b@pacbell.net>
	<200604260703.35214.nigel@suspend2.net>
	<200604260006.33856.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============25004929016375899=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604260006.33856.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============25004929016375899==
Content-Type: multipart/signed; boundary="nextPart1915777.5XEmoGykK4";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1915777.5XEmoGykK4
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 26 April 2006 08:06, Rafael J. Wysocki wrote:
> On Tuesday 25 April 2006 23:03, Nigel Cunningham wrote:
> > On Wednesday 26 April 2006 06:53, Rafael J. Wysocki wrote:
> > > On Tuesday 25 April 2006 22:28, Nigel Cunningham wrote:
> > > > On Wednesday 26 April 2006 04:56, Rafael J. Wysocki wrote:
> > > > > You're saying that (9) is wrong, so could you please suggest what
> > > > > to do instead of it?
> > > >
> > > > 'scuse me for butting in, but here's my suggested modified version:
> > > > > Well, suppose we have a modular driver that's not loaded before
> > > > > resume. Then it goes like that (approximately):
> > > > > (1) We activate swsusp which calls .suspend() for all devices
> > > > > including our driver (this is a real suspend).
> > > > > (2) swsusp snapshots the system and creates the image.
> > > > > (3) swsusp calls .resume() for all devices in order to be able to
> > > > > save the image (.resume() for our driver is also called which is
> > > > > OK). (4) swsusp turns off the system.
> > > > > (5) (some time later) We start a new kernel and tell it to resume.
> > > > > (6) It activates swsusp which reads the image.
> > > > > (7) (without your change) swsusp calls .suspend() for all device
> > > > > drivers that are present at that time, but our driver is not ther=
e,
> > > > > so its .suspend() _won't_ be called.  [Of course with your change
> > > > > .suspend() won't be called for any driver.]
> > > >
> > > > We also make a list that is safely available after the atomic resto=
re
> > > > of drivers that have had .suspend methods called.
> > >
> > > Do you mean we place the list in a __nosave area?
> >
> > Well, I wasn't wanting to get bogged down in the details yet, but let's
> > see what we can come up with. How about this:
> >
> > At the point where we do the drivers resume at resume time, we're still
> > atomic, right? Since that's the case, we can just use get_safe_page()
> > prior to the restore to store the list and a __nosave pointer to retain
> > the location across the atomic restore. If we are concerned about
> > resuming drivers allocating memory and overwriting our list (and I think
> > that's a valid concern), space could be allocated and the list copied
> > between doing the atomic restore and the device pwoerup/resume.
>
> This one seems to look better.
>
> Still the problem is we need to know what to do with the devices that have
> had .suspend() routines called.  Some of them would have to be reset, some
> of them might be left in the current state, and for some of them we'd have
> to do something special.  Frankly, only the driver writer will know what's
> appropriate.

I saw the 2 suspends, 1 resume comment in another part of the thread, but=20
don't believe a driver would be able to detect that 2 suspends and 1 resume=
=20
call had been made - at least not without some non volatile ram. This is th=
e=20
problem I'm mainly seeking to address. I agree that the driver is the only=
=20
thing that will know what to do with the information. That presents another=
=20
issue - we would then have to pass on to the drivers the information - I=20
guess by modified a field in their struct device?

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1915777.5XEmoGykK4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBETqAsN0y+n1M3mo0RAvwdAKCzPPtZ3UHQEKhfTxQ0xynkWmbkNQCfRB0L
4WPVgmgDMwrkPKuh1Hmj5TA=
=rNwd
-----END PGP SIGNATURE-----

--nextPart1915777.5XEmoGykK4--

--===============25004929016375899==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============25004929016375899==--
