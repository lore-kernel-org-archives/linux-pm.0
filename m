Return-Path: <SRS0=Sohe=TC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C98C43219
	for <linux-pm@archiver.kernel.org>; Thu,  2 May 2019 18:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAE020B7C
	for <linux-pm@archiver.kernel.org>; Thu,  2 May 2019 18:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbfEBSWw (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 2 May 2019 14:22:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57862 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfEBSWw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 14:22:52 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A790E802ED; Thu,  2 May 2019 20:22:40 +0200 (CEST)
Date:   Thu, 2 May 2019 20:22:50 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Nikitas Angelinas <nikitas.angelinas@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power/poweroff.c: mark variables with __initdata and
 __maybe_unused
Message-ID: <20190502182250.GA4845@amd>
References: <20190502074305.GA6039@vostro>
 <20190502101500.GA23980@amd>
 <20190502175958.GA14955@vostro>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20190502175958.GA14955@vostro>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190502182250.lP3wMg48x_EoIhcJ-9pf9Trv0V906l9nhXh83teyzRk@z>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-05-02 10:59:58, Nikitas Angelinas wrote:
> On Thu, May 02, 2019 at 12:15:00PM +0200, Pavel Machek wrote:
> > On Thu 2019-05-02 00:43:05, Nikitas Angelinas wrote:
> > > There is no need to keep sysrq_poweroff_op after initialization, so m=
ark
> > > it with __initdata.
> >=20
> > Are you sure?
> >=20
> > pavel@duo:/data/l/k$ grep -ri sysrq_key_op . | grep initdata
> > pavel@duo:/data/l/k$
> >=20
> >=20
> > 									Pavel
> >=20
> I am sorry about this. I completely missed the point of registering this
> structure. Please ignore this patch.
>=20

Yup. You can have Acked-by: for the other parts.

									Pavel

> > > =20
> > > -static struct sysrq_key_op	sysrq_poweroff_op =3D {
> > > +static struct sysrq_key_op sysrq_poweroff_op __initdata =3D {
> > >  	.handler        =3D handle_poweroff,
> > >  	.help_msg       =3D "poweroff(o)",
> > >  	.action_msg     =3D "Power Off",
> >=20
> > --=20
> > (english) http://www.livejournal.com/~pavelmachek
> > (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
>=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzLNXoACgkQMOfwapXb+vKmjgCgnFC4NkPKTlbkBpxuDlHQPYfp
TToAoKbW6WSTatCwlvhlp9pUbt/Obi4P
=kXiy
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
