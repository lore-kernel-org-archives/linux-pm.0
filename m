From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: [linux-pm] [patch/rft 2.6.17-rc2] swsusp resume must not device_suspend()
Date: Tue, 25 Apr 2006 20:34:49 +1000
Message-ID: <200604252034.54352.ncunningham@cyclades.com>
References: <200604241429.52022.david-b@pacbell.net> <200604242347.36257.rjw@sisk.pl> <200604241547.38692.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5464790.laONpCQSyf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <200604241547.38692.david-b@pacbell.net>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: linux-pm@lists.osdl.org
Cc: David Brownell <david-b@pacbell.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--nextPart5464790.laONpCQSyf
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 25 April 2006 08:47, David Brownell wrote:
> On Monday 24 April 2006 2:47 pm, Rafael J. Wysocki wrote:
> > I agree with this change but I think it'll cause some strange things to
> > happen for some time.
>
> Let's see.  :)  I think it's less likely to be drivers with broken
> shutdown() callbacks than drivers which are missing them.
>
> Plus, one of the main reasons that driver suspend/resume handling
> is _still_ so goofy is that most drivers are stupid, and just reinit
> devices from scratch in their resume() methods.  Drivers like that
> should not notice any difference.  :)

No!

The only reason that driver suspend/resume handling is still far from perfe=
ct=20
is that a good number of drivers still don't have any suspend/resume=20
handling. Getting rid of the instrastructure because it isn't completely=20
implemented is the wrong approach. We should instead complete implementing=
=20
the support so that drivers understand the difference between freezing,=20
suspending, powering down, powering up and resuming. If we dumb things down=
,=20
we'll only create problems.

Rafael raised the issue in another email of code built as modules that is=20
suspended and not resumed or vice versa because in the case of suspend to=20
disk, the module is loaded at boot time but not in the suspended kernel (or=
=20
v.v). It seems to me that the right way to deal with this is to extend the=
=20
use of __nosave so that information about what was loaded in the boot kerne=
l=20
is available when resuming drivers after the atomic restore.

Regards,

Nigel

--nextPart5464790.laONpCQSyf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBETftON0y+n1M3mo0RAk/oAJ9NQuRVe0qXHpDXP8XPpyAeTMTVewCg7+sd
Qpx+HPjM+gCR8/Di85HobQs=
=fScK
-----END PGP SIGNATURE-----

--nextPart5464790.laONpCQSyf--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
