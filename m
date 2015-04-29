From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.1-rc2
Date: Tue, 28 Apr 2015 18:58:38 -0700
Message-ID: <20150429015837.GA4517@localhost.localdomain>
References: <1430135910.3335.14.camel@rzhang1-mobl4>
 <CA+55aFx3O0Z9M0hBzdkd_bU_Yi1DgEG9=d+3vqyMVAto9TsH4A@mail.gmail.com>
 <744357E9AAD1214791ACBA4B0B909263014F3F2D@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36855 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030541AbbD1S6m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2015 14:58:42 -0400
Received: by pabsx10 with SMTP id sx10so3781925pab.3
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2015 11:58:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <744357E9AAD1214791ACBA4B0B909263014F3F2D@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus, Rui,

On Tue, Apr 28, 2015 at 02:40:02AM +0000, Zhang, Rui wrote:
> Hi, Linus,
>=20
> Sorry that I missed the merged window as my email was broken while I was =
travelling in Portland last week. And I need to get it fixed after I came b=
ack this Sunday.
> Thus I was hoping that this can still get merged as it is early -rc2.
> Sorry for bringing the trouble to you and the patch contributors, I will =
send another git pull request.
>=20
> Thanks,
> rui
> =20
> > -----Original Message-----
> > From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> > owner@vger.kernel.org] On Behalf Of Linus Torvalds
> > Sent: Tuesday, April 28, 2015 5:05 AM
> > To: Zhang, Rui
> > Cc: Linux PM list
> > Subject: Re: [GIT PULL] Thermal management updates for v4.1-rc2
> > Importance: High
> >=20
> > On Mon, Apr 27, 2015 at 4:58 AM, Zhang Rui <rui.zhang@intel.com> wrote:
> > >
> > > to receive the Thermal Management updates for v4.1-rc2 with top-most
> > > commit
> >=20
> > This came outside the merge window (why?), so I'm ignoring it.
> >=20
> > If you have bug-fixes, send those. The rest can wait until 4.2.
> >=20

Linus,

We have content that has been waiting for 4.1 merge window for some
time. It was sent into linux-next several weeks ago [1]. My 4.1 pull=20
to Rui was a couple of weeks ago [2].=20

It is disappointing for the developers who has been waiting for final
merge of their code that in the end it didn't make it due to corporate
email issues.=20

I know it is your call to pull it or not for 4.1. I just want to explain=20
that the thermal-soc content is not a last minute change.

Rui,

Whenever you have such issues, let me know and we can do something to
avoid content missing the merge window. I can of course, send pulls with
accepted content, just the way I have been sending.


BR,

Eduardo Valentin

[1] - https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/comm=
it/?id=3D899e56ad58f544e115070a7b4bd7b2dafc646936
[2] - http://marc.info/?l=3Dlinux-pm&m=3D142907689627135&w=3D2


> >                         Linus
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm" in =
the
> > body of a message to majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVQDrGAAoJEMLUO4d9pOJWr+UH/iG5WWi3BiRYT2bUN/hGeojU
3YQ7eZBNiJhlqsbWoi/p/UangER8VpEqOtZpVlOT3ya3WXW/prEa0VfjpqjFImny
Xwpul+qUkjKdnp9RSFTLu0hcw2Zp1xXWtCC22g0kNFk7Ay2RfjvNmk2ujX7s76b9
2Bna/13PmlV1nYBYYjzN+dDkiTS7Ikg2hi1FK3AXgRWCJq+QG0i20zCmyLhCBG/A
C+XhdfkwY42H/Izlpto0611vIaGeplXFvRWztCERz6+0DHbdfNVGqwEhm+UX8ye1
GjIUvzqRrErtnyncGZ9m95KcTX/Fr8uv7aHXw183lpIH9YWPj2VLmwn43+sxK/w=
=p5N4
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
