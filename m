From: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [linux-pm] [patch/rft 2.6.17-rc2] swsusp resume must not device_suspend()
Date: Wed, 26 Apr 2006 13:44:20 +1000
Message-ID: <200604261344.24694.nigel@suspend2.net>
References: <200604241429.52022.david-b@pacbell.net> <200604261116.59070.nigel@suspend2.net> <200604252032.42695.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart29389695.nQdGM9HlHt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <200604252032.42695.david-b@pacbell.net>
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
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.osdl.org, Andrew Morton <akpm@osdl.org>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--nextPart29389695.nQdGM9HlHt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 26 April 2006 13:32, David Brownell wrote:
> On Tuesday 25 April 2006 6:16 pm, Nigel Cunningham wrote:
> > Hi.
> >
> > On Wednesday 26 April 2006 09:55, David Brownell wrote:
> > > On Tuesday 25 April 2006 3:18 pm, Nigel Cunningham wrote:
> > > > I saw the 2 suspends, 1 resume comment in another part of the threa=
d,
> > > > but don't believe a driver would be able to detect that 2 suspends
> > > > and 1 resume call had been made - at least not without some non
> > > > volatile ram.
> > >
> > > The extra suspend is just IMO a symptom of sloppiness, like a "here m=
ay
> > > be bugs" sign.  Not necessarily an issue in its own right.
> > >
> > > In fact if you count carefully, it's three suspends and one resume:=20
> > > one suspend before calling swsusp_resume, one inside swsusp_resume --
> > > replaced by my patch -- and a correctly matched pair in the kernel
> > > being resumed.
> >
> > That doesn't sound right. Let' see - where's this third one?
>
> I see your point ... device_suspend() and device_power_down() really
> do the same thing, but to different sets of devices.  A nastily deceptive
> naming convention that I may want to fix someday.

:)

> So it's not quite fair counting those separately.  Three suspend calls,
> sure ... but only two per device.
>
> > > Also, about non-volatile RAM.  Not necessary ... the device hardware
> > > holds all the relevant state.  The problem is that swsusp is now
> > > trashing it with those suspend calls before resuming the real kernel.=
=20
> > > On the plus side, we already have code being used to resolve the
> > > identical issue for kexec(), and all my patch does is to use it.
> >
> > If devices really do get powered down, then they won't retain the state.
> > If they don't actually powerdown, then I see your point.
>
> While the system is restarting into the snapshot, there's no powerdown.
> (Because device_power_down doesn't actually power down devices.)  Q.E.D.

I thought that at least some devices might go D3cold, or is it always hot? =
I'm=20
perfectly happy to admit being an ignoramus here - I'm just beginning to wo=
rk=20
on drivers, so still have a lot to learn.

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart29389695.nQdGM9HlHt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBETuyYN0y+n1M3mo0RAu4YAKC47ocNxQ0GwhmrRyV5fknbPPixMwCeIO9H
Hizj5eySpuoZ7aBH9z3Uc+o=
=PkVo
-----END PGP SIGNATURE-----

--nextPart29389695.nQdGM9HlHt--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
