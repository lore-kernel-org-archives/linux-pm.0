From: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Wed, 26 Apr 2006 13:41:27 +1000
Message-ID: <200604261341.32500.nigel@suspend2.net>
References: <200604242355.08111.rjw@sisk.pl> <200604260021.08888.rjw@sisk.pl> <444ED9EB.5060205@yahoo.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3631143.1XjrAkghlY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932384AbWDZKqs@vger.kernel.org>
In-Reply-To: <444ED9EB.5060205@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--nextPart3631143.1XjrAkghlY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Nick.

On Wednesday 26 April 2006 12:24, Nick Piggin wrote:
> Rafael J. Wysocki wrote:
> >This means if we freeze bdevs, we'll be able to save all of the LRU page=
s,
> >except for the pages mapped by the current task, without copying.  I thi=
nk
> > we can try to do this, but we'll need a patch to freeze bdevs for this
> > purpose. ;-)
>
> Why not the current task? Does it exit the kernel? Or go through some
> get_uesr_pages path?

I think Rafael is asleep at the mo, so I'll answer for him - he's wanting i=
t=20
to be compatible with using userspace to control what happens (uswsusp). In=
=20
that case, current will be the userspace program that's calling the ioctls =
to=20
get processes frozen etc.

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart3631143.1XjrAkghlY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBETuvsN0y+n1M3mo0RAsApAKDD4OYZQ7Xi1CaGX0eGra2rPpcO8wCeJGtQ
pAi57ra6EUGfKWVuf6Z2i/g=
=LqDi
-----END PGP SIGNATURE-----

--nextPart3631143.1XjrAkghlY--
