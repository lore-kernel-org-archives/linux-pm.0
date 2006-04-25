From: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [linux-pm] [patch/rft 2.6.17-rc2] swsusp resume must not device_suspend()
Date: Wed, 26 Apr 2006 07:03:28 +1000
Message-ID: <200604260703.35214.nigel@suspend2.net>
References: <200604241429.52022.david-b@pacbell.net> <200604260628.41003.nigel@suspend2.net> <200604252253.19130.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart23877562.y5lxEcRQDx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <200604252253.19130.rjw@sisk.pl>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Andrew Morton <akpm@osdl.org>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--nextPart23877562.y5lxEcRQDx
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 26 April 2006 06:53, Rafael J. Wysocki wrote:
> Hi,
>
> On Tuesday 25 April 2006 22:28, Nigel Cunningham wrote:
> > On Wednesday 26 April 2006 04:56, Rafael J. Wysocki wrote:
> > > You're saying that (9) is wrong, so could you please suggest what to =
do
> > > instead of it?
> >
> > 'scuse me for butting in, but here's my suggested modified version:
> > > Well, suppose we have a modular driver that's not loaded before resum=
e.
> > > Then it goes like that (approximately):
> > > (1) We activate swsusp which calls .suspend() for all devices includi=
ng
> > > our driver (this is a real suspend).
> > > (2) swsusp snapshots the system and creates the image.
> > > (3) swsusp calls .resume() for all devices in order to be able to save
> > > the image (.resume() for our driver is also called which is OK).
> > > (4) swsusp turns off the system.
> > > (5) (some time later) We start a new kernel and tell it to resume.
> > > (6) It activates swsusp which reads the image.
> > > (7) (without your change) swsusp calls .suspend() for all device
> > > drivers that are present at that time, but our driver is not there, so
> > > its .suspend() _won't_ be called.  [Of course with your change
> > > .suspend() won't be called for any driver.]
> >
> > We also make a list that is safely available after the atomic restore of
> > drivers that have had .suspend methods called.
>
> Do you mean we place the list in a __nosave area?

Well, I wasn't wanting to get bogged down in the details yet, but let's see=
=20
what we can come up with. How about this:

At the point where we do the drivers resume at resume time, we're still=20
atomic, right? Since that's the case, we can just use get_safe_page() prior=
=20
to the restore to store the list and a __nosave pointer to retain the=20
location across the atomic restore. If we are concerned about resuming=20
drivers allocating memory and overwriting our list (and I think that's a=20
valid concern), space could be allocated and the list copied between doing=
=20
the atomic restore and the device pwoerup/resume. Another approach might be=
=20
to allocate space for the list while suspending (prior to the atomic copy),=
=20
but that could cause problems since you don't know how many devices will be=
=20
in the list ahead of time. Are there other possibilities I haven't thought=
=20
of?

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart23877562.y5lxEcRQDx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBETo6nN0y+n1M3mo0RAhuOAJ9bYw8GZCHWHFtA9HvB5Ul1HwhMPQCfThH9
5be3SbEmPJVUFU/UXzaPrVw=
=BnkY
-----END PGP SIGNATURE-----

--nextPart23877562.y5lxEcRQDx--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
