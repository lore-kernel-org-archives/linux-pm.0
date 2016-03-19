From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] cpuidle: use high confidence factors only when
 considering polling
Date: Fri, 18 Mar 2016 22:17:30 -0400
Message-ID: <1458353850.14723.57.camel@redhat.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	 <CAJZ5v0iK=vO1HPKfbpMwNx_Tk-kjGEUKrCmehaK7nN+-Up7BoA@mail.gmail.com>
	 <20160316121400.680a6a46@annuminas.surriel.com>
	 <10828426.sI6CaBvZhk@vostro.rjw.lan> <000701d180df$e8a14340$b9e3c9c0$@net>
	 <CAJZ5v0gLXE=sRxv35hKuX88L4tphSBtPb9Y2oLERuEhjsbTGJQ@mail.gmail.com>
	 <003301d18144$87bb8df0$9732a9d0$@net>
	 <20160318173551.675ff6e5@annuminas.surriel.com>
	 <CAJZ5v0hLAiVoEn0PbVo++UDrXvizYC0EeAoqj8drS3GR5mQTig@mail.gmail.com>
	 <1458352411.14723.55.camel@redhat.com>
	 <CAJZ5v0iQhVsyq7o8kbvppENdhvKFCZTSzWswCmELa2ithkm1iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-wBVC13u82M5mMwBDzaJV"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39068 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753795AbcCSCRe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 18 Mar 2016 22:17:34 -0400
In-Reply-To: <CAJZ5v0iQhVsyq7o8kbvppENdhvKFCZTSzWswCmELa2ithkm1iA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>


--=-wBVC13u82M5mMwBDzaJV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2016-03-19 at 03:06 +0100, Rafael J. Wysocki wrote:
> On Sat, Mar 19, 2016 at 2:53 AM, Rik van Riel <riel@redhat.com>
> wrote:
> >=C2=A0
> > The kernel test robot also showed over 6% improvement in (IIRC)
> > the wikibench test, with polling being done a little more often.
> >=20
> > Other parts of the kernel do pretty much anything for 2% extra
> > performance, so if we can find a way to preserve that 6%, without
> > hurting power usage significantly, I suspect it may be worthwhile.
> Well. OK.=C2=A0=C2=A0That is a worthy goal, but things in this thread loo=
k a
> bit
> too ad-hoc to me to be honest.
>=20
> I'd like to take one step at a time and in such a way that
> improvements are actually confirmed in every step.
>=20
> Does this sound reasonable?
>=20
> If so, I first would like to restore the energy consumption in the
> Doug's case at least to the level from before commit a9ceb78bc75c
> (cpuidle,menu: use interactivity_req to disable polling).=C2=A0=C2=A0That=
's
> what
> I'd like to do for 4.6 and possibly before the merge window is over.
>=20
> After 4.6-rc1, in the 4.7 cycle, we can think about improving
> performance here and maybe sacrificing some energy for that, but in a
> controlled way as I said above.
>=20
> What do you think?

That sounds perfectly reasonable to me.

Count me in for any efforts to improve performance with
the cpuidle code, and hopefully allow more people to enable
c-states on their servers.

--=20
All Rights Reversed.


--=-wBVC13u82M5mMwBDzaJV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW7La6AAoJEM553pKExN6DXK0IAJeocBgd47bTjZWY+T9uGKNi
QuvNpLgdxGOP5Gb2NympNFRr4pTE9A3pj6m7uPuJbcuk+pcARu19wUftnVH+rQXx
4iN5yBbWD2Fltfif/H1KScQnq25QPV7pX1TjJuB6AtQQhOVFp764Q9XOYRquUNKj
18JcxC0DpDZokoUwjKa7lpG9Fvrf2Pjv038a9Xv8M6AFrLfh89J12hlUKwNVIQRm
ymU5hDtoXVjcSQmhnESGb/7h/EWRJt434ywmHq0cEuRF2x6Vj/eTB5V6ctT2lNYk
yiQvLaQONPtq6gq+VmdQNoCeCRIf4TpED3FMLFueOHO88z+IxDT4zNVFNm74vZc=
=+qMj
-----END PGP SIGNATURE-----

--=-wBVC13u82M5mMwBDzaJV--

