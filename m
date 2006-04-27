From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: [linux-pm] [patch/rft 2.6.17-rc2] swsusp resume must not device_suspend()
Date: Fri, 28 Apr 2006 06:35:55 +1000
Message-ID: <200604280636.03606.ncunningham@cyclades.com>
References: <20060427080826.GB2376@ucw.cz> <20060427165536.GA3113@linux.intel.com> <200604271221.47160.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1801530.bG3V3x8fEY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <200604271221.47160.david-b@pacbell.net>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: David Brownell <david-b@pacbell.net>
Cc: Patrick Mochel <mochel@linux.intel.com>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--nextPart1801530.bG3V3x8fEY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 28 April 2006 05:21, David Brownell wrote:
> On Thursday 27 April 2006 9:55 am, Patrick Mochel wrote:
> > On Thu, Apr 27, 2006 at 10:34:16AM -0400, Alan Stern wrote:
> > > 		During swsusp the system is
> > > supposed to be completely off, with no suspend power available.  Hence
> > > all the power sessions are guaranteed to be interrupted, and the boot
> > > kernel doesn't have to worry about destroying any of them.
> >
> > Not necessarily. x86 hardware implementations of suspend-to-disk retain
> > some power during suspend. Not many (if any) devices will retain contex=
t,
> > but the system is definitely not completely "off".
>
> As a rule swsusp (or firmware suspend-to-disk) power off everything except
> what's needed to power up the motherboard ... or to provide "5 AM wakeup"
> type events using a battery-backed realtime clock.  Maintaining VBUS power
> sessions from USB host controllers is one of those "theoretically allowed,
> but never observed in the wild" cases.
>
> Right, not "completely" off ... but certainly nowhere as close to "on" as
> would be true of suspend-to-RAM.  And regardless, the problem in $SUBJECT
> is when Linux trashes the state which the limited "on" is there to
> maintain.

This isn't necessarily true either. Suspend2 has supported writing the imag=
e,=20
then suspending to ram for a year or two. uswsusp has just gained the same=
=20
functionality. In this state, if you don't pull the plug/drain the battery,=
=20
you never actually power down. Having said that, this might be a different=
=20
kettle of fish though, because there's no boot kernel in that case. For=20
Suspend2 (and uswsusp, I assume), it's more akin to backing out of the cycl=
e=20
at the last possible moment before powering down.

Regards,

Nigel

--nextPart1801530.bG3V3x8fEY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEUSszN0y+n1M3mo0RAhPIAKCO9wK53RV1k//5Q0u6E1IUPJSWxQCfTRjx
dkoHsPDjSixB08EfXiZ82p8=
=DWX3
-----END PGP SIGNATURE-----

--nextPart1801530.bG3V3x8fEY--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
