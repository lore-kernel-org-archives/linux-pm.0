From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 0/5] Subject: The power allocator thermal governor
Date: Mon, 2 Mar 2015 14:47:01 -0400
Message-ID: <20150302184659.GE8925@developer.hsd1.ca.comcast.net>
References: <1425316643-31991-1-git-send-email-javi.merino@arm.com>
 <20150302172847.GD8925@developer.hsd1.ca.comcast.net>
 <20150302174054.GB15351@e104805>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35448 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbbCBSrN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2015 13:47:13 -0500
Content-Disposition: inline
In-Reply-To: <20150302174054.GB15351@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>, "tixy@linaro.org" <tixy@linaro.org>, Kapileshwar Singh <Kapileshwar.Singh@arm.com>


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2015 at 05:40:54PM +0000, Javi Merino wrote:
> On Mon, Mar 02, 2015 at 05:28:50PM +0000, Eduardo Valentin wrote:
> > On Mon, Mar 02, 2015 at 05:17:18PM +0000, Javi Merino wrote:
> > > *** BLURB HERE ***
> > >=20
> > > Hi linux-pm,
> > >=20
> > > Introduce the power allocator governor, a thermal governor that
> > > allocates device power to control temperature.  This series is based
> > > on branch "linus" of Eduardo's linux-soc-thermal tree:
> > >=20
> > > git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-ther=
mal.git
> > >=20
> > > Changes since v2:
> > >   - Address Eduardo's review
> > >     + Turn variable-size array in divvy_up_power() into a
> > >       devm_kcalloc() as suggested by Eduardo
> > >     + Remove #ifdeffery from thermal_core.c as suggested by Eduardo
> > >   - Bring back cpufreq's CPUFREQ_UPDATE_POLICY_CPU notifier in order
> > >     to update the cpu device in cpu_cooling.c when cpufreq changes
> > >     the policy cpu.
> >=20
> >=20
> > Can you please elaborate a bit more on the issue you saw to decide to
> > bring this functionality back?
>=20
> I explained it in patch 5 ("thermal: cpu_cooling: update the cpu
> device when cpufreq updates the policy cpu"): When cpufreq changes the
> policy cpu, the cpufreq cooling device needs to update the cached cpu
> device accordingly.
>=20
> > Can we keep the cpufreq changes as a separated thread? To me if the
> > issue happens to power allocator, it also happens to the other
> > governors.
>=20
> The cached cpu device was introduced in patch 98ea0816118f ("thermal:
> cpu_cooling: implement the power cooling device API") in your tree.
> I'm posting it here because it only affects doesn't affect other
> governors.
>=20
> > I don't want to block power allocator due to the cpufreq
> > changes.
>=20
> You don't have to.  It's the last two patches precisely for that.  You
> can merge everything up to patch 3 without depending on cpufreq
> changes.
>=20
> > Besides, cpufreq changes should go via the proper cpufreq tree, not the
> > thermal tree.
>=20
> It's a change to cpu_cooling (patch 5) that needs a revert of cpufreq
> (patch 4).  The change to cpu_cooling depends on the patches already
> in your branch.  So you will have to carry this patch in your branch
> with an Ack from the cpufreq maintainers.

Yes, the patches in the thermal code depend on code in my tree.
However, changes in cpufreq are not depending on any code in my tree.
Unless there is a direct dependency, I would prefer to send them via the
correct tree.

I simple don't feel comfortable sending stuff that are really part of
what is described in MAINTAINERS. But if you get an ack from cpufreq,
then of course, I can consider it.

>=20
> Cheers,
> Javi

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU9LAZAAoJEMLUO4d9pOJWHhQH/iemrmGnQHJXNbw9GCQxDTXZ
EC7OwGAJbyyyR/bE1Jx0NUezzE/IJGeZ41Q0DDAuPOVb8t4vNDQeiX1gLTFHdYl0
to2aptBG+d3GCBsur4EaCuzM+nIIsWwkkL2SiOfRzaL0YLdjBDHE3mvWoXYBeD/d
nYhvtmdHzWR5bXlrSrm4M8DRmgSLL6jqxhmfQwe2z2AQB/Ic3WCl2tgAUON4+deO
z5kkJ6PS6gkaBqF5RMRQdQqw0zJVdPbVwOgElKMexASVMN3IYUmxv2GsK6fUBKrh
fu+IYnkD0amX1ewuBRfzT1EoFRL3yCVWMpOX5juz+gn58wYTbhCP2kPi/A8DVDY=
=ilc1
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--
