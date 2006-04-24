From: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [linux-pm] [patch/rft 2.6.17-rc2] swsusp resume must not device_suspend()
Date: Tue, 25 Apr 2006 08:31:58 +1000
Message-ID: <200604250832.04065.nigel@suspend2.net>
References: <200604241429.52022.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1581411.nqyPZ1qW9O";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <200604241429.52022.david-b@pacbell.net>
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
Cc: David Brownell <david-b@pacbell.net>, linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--nextPart1581411.nqyPZ1qW9O
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi David.

On Tuesday 25 April 2006 07:29, David Brownell wrote:
> I've noticed a bunch of problem reports that go like this:
>
>  - boot system with some USB devices attached
>  - echo disk > /sys/power/state
>  - ... later resume ...
>  - now those USB devices don't work right
>  - unplug them/replug them, all is OK
>
> I recently observed this myself and tracked down one problem.  The soluti=
on
> involves what kexec() does in much the same situation:  before starting a
> new kernel, most hardware needs to be reset.  Today, swsusp will suspend =
it
> instead, which is the root cause of the problem.

I'm not sure that it is. If we switched to not freezing devices, we'd then=
=20
cause issues with hardware such as hard drives. They need to know that we=20
just want things quiesced, mainly because we don't want to spin down drives=
=2E=20
It seems to me that the right solution might be for these usb devices to=20
treat a resume from a freeze as an indication that hardware should be reset.

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1581411.nqyPZ1qW9O
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBETVHkN0y+n1M3mo0RAn3JAJ9jWsm9yvpDgbvYl3M/wuMtv1ufTwCgztz/
qmWxqoUXsqdJrsGQ8dB6+yg=
=UIaS
-----END PGP SIGNATURE-----

--nextPart1581411.nqyPZ1qW9O--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
