From: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [linux-pm] [patch/rft 2.6.17-rc2] swsusp resume must not device_suspend()
Date: Thu, 27 Apr 2006 05:47:50 +1000
Message-ID: <200604270547.55792.nigel@suspend2.net>
References: <Pine.LNX.4.44L0.0604261020320.5283-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1916057.xRSghuRcnc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0604261020320.5283-100000@iolanthe.rowland.org>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--nextPart1916057.xRSghuRcnc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 27 April 2006 00:24, Alan Stern wrote:
> A little behind the current head of the thread, but better late than
> never...

:)

> On Wed, 26 Apr 2006, Nigel Cunningham wrote:
> > > (7) (without your change) swsusp calls .suspend() for all device
> > > drivers that are present at that time, but our driver is not there, so
> > > its .suspend() _won't_ be called.  [Of course with your change
> > > .suspend() won't be called for any driver.]
> >
> > We also make a list that is safely available after the atomic restore of
> > drivers that have had .suspend methods called.
> >
> > > (8) swsusp restores the image.
> >
> > (9) suspend to disk calls .resume() for each device that is found in the
> > list generated above, thereby excluding our problem driver. Drivers whi=
ch
> > are present but not in the list above (such as the problem driver) have=
 a
> > different routine called, perhaps the normal initialisation one?
>
> First, is this a list of drivers or a list of devices?  Under (7) you said
> drivers, and under (9) you said devices.

Sorry. I was using them interchangably. I meant devices, since the same dri=
ver=20
might be handling more than one instance.

> Second, how do you tell whether a device or driver in the resuming kernel
> is in the list or not?  Do you store the driver's name in the list and
> compare names?

I was deliberately not worrying about that at the moment, and just assuming=
=20
that we'd come up with some way to match the entries. My initial guess woul=
d=20
be that it would involve whatever per instance ids were available, or=20
something as close to that as we can manage.

> Third, suppose a driver was present in the original swsusp kernel (and
> hence also in the resuming kernel) but not in the boot kernel.  Then it
> won't be in the list.  Apparently that means it doesn't get resumed during
> (9).  So when does it get resumed?

I would think it should still be resumed at that stage. It just gets told=20
(somehow) at that point that it wasn't suspended in the boot kernel, and it=
=20
might therefore perform different actions, based on that info.

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1916057.xRSghuRcnc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBET85rN0y+n1M3mo0RAnT/AJ0UdA44Tmj5YQKISdROQc4fxMj9qgCdGL+Q
mGuh7yoKtabFV/TTivkb7aU=
=RMz0
-----END PGP SIGNATURE-----

--nextPart1916057.xRSghuRcnc--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
