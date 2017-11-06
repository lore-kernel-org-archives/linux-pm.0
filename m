From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] freezer: Fix typo in commnent to function
 freezable_schedule_timeout()
Date: Mon, 6 Nov 2017 12:38:48 +0100
Message-ID: <20171106113848.GG24863@amd>
References: <1509832652-1552-1-git-send-email-himanshujha199640@gmail.com>
 <20171104220256.GA7012@amd>
 <20171106112709.GA4822@himanshu-Vostro-3559>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7lMq7vMTJT4tNk0a"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44190 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752516AbdKFLiu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Nov 2017 06:38:50 -0500
Content-Disposition: inline
In-Reply-To: <20171106112709.GA4822@himanshu-Vostro-3559>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org


--7lMq7vMTJT4tNk0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2017-11-06 16:57:09, Himanshu Jha wrote:
> On Sat, Nov 04, 2017 at 11:02:56PM +0100, Pavel Machek wrote:
> > On Sun 2017-11-05 03:27:32, Himanshu Jha wrote:
> > > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> >=20
> > ACK.
> >=20
> > But note you have typo in the subject ;-).
>=20
> Oops!
> Do I need to send v2 with correct subject ?

I don't think that's required. I expect rjw will pick it up, maybe
fixing the subject.
									Pavel

> > Plus this kind of bug is usually called thinko.
> > 								Pavel
> >=20
> >=20
> > > diff --git a/include/linux/freezer.h b/include/linux/freezer.h
> > > index 3995df1..21f5aa0 100644
> > > --- a/include/linux/freezer.h
> > > +++ b/include/linux/freezer.h
> > > @@ -182,7 +182,7 @@ static inline void freezable_schedule_unsafe(void)
> > >  }
> > > =20
> > >  /*
> > > - * Like freezable_schedule_timeout(), but should not block the freez=
er.  Do not
> > > + * Like schedule_timeout(), but should not block the freezer.  Do not
> > >   * call this with locks held.
> > >   */
> > >  static inline long freezable_schedule_timeout(long timeout)
> >=20
> > --=20
> > (english) http://www.livejournal.com/~pavelmachek
> > (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
>=20
> Thanks
> Himanshu Jha

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7lMq7vMTJT4tNk0a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloAScgACgkQMOfwapXb+vJdmACgiJjc14i09NrW3ePm9o+qJ8E9
r6AAoJLeBRCx+nGQ8ngSK2NvAAQDrtVp
=G/VX
-----END PGP SIGNATURE-----

--7lMq7vMTJT4tNk0a--
