From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Wed, 30 Mar 2016 11:58:56 -0700
Message-ID: <1459364336.13525.69.camel@linux.intel.com>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>
		<CADDKRnCH3yCut7A4Gvk3gHw4OpOYXoG0VQRe5mh2nTjptYU0gw@mail.gmail.com>
		<4187911.uaFVupaTVL@vostro.rjw.lan>
		<CADDKRnCr0riAu4pjYRkuguoCoAjWxFoc+pU1NBymPr+3JnVanQ@mail.gmail.com>
		<CAJZ5v0i48Xxyp880SQ1iVDzct--vhTVggCS_wHHA7bt7D+_sFg@mail.gmail.com>
		<1459352017.13525.45.camel@intel.com>
	 <CADDKRnA5x9dK=6KZWijiP_ihrUA9Afpmqw8TSzYn9oaBeaOfKw@mail.gmail.com>
	 <002401d18ab5$0bf84a30$23e8de90$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61933 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753393AbcC3S6l (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 30 Mar 2016 14:58:41 -0400
In-Reply-To: <002401d18ab5$0bf84a30$23e8de90$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, =?ISO-8859-1?Q?=27J=F6rg?= Otte' <jrg.otte@gmail.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net

On Wed, 2016-03-30 at 11:50 -0700, Doug Smythies wrote:
> On 2016.03.30 08:52 J=C3=B6rg Otte wrote:
> >=20
> > 2016-03-30 17:33 GMT+02:00 Pandruvada, Srinivas <srinivas.pandruvad
> > a@intel.com>:
> > >=20
> > > On Wed, 2016-03-30 at 13:05 +0200, Rafael J. Wysocki wrote:
> > > >=20
> > > > On Wed, Mar 30, 2016 at 12:17 PM, J=C3=B6rg Otte <jrg.otte@gmai=
l.com
> > > > >
> >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > >=20
> > > > > > >=20
> > > > > > > Now in v4.6-rc1 the characteristic has dramatically
> > > > > > > changed.
> > > > > > > If in idle the processor frequency is more or less a few
> > > > > > > MHz around 2500Mhz.
> > > > > > > I currently use acpi_cpufreq which works as usual.
> > > > > > > Processor: Intel(R) Core(TM) i5-4200M CPU @ 2.50GHz
> > > > > > > (family: 0x6, model: 0x3c, stepping: 0x3)
> >=20
> > >=20
> > > I want to reproduce this if I can. Can you give us info about
> > > your
> > > setup (Linux distribution, laptop model etc.)?
> I would like to try to reproduce the issue also.
>=20
> >=20
> > Distro: Ubuntu 14.04.4 LTS
> Note that with Ubuntu 14.04, I had issues where my CPU
> would lock at pstate 24 (not always 24, but usually),
> regardless of load.
> However, it was always after an S3 suspend, occurred 100%
> of the time, and was independent of intel_pstate or
> acpi-cpufreq CPU frequency scaling drivers.
>=20
> Since changing my test server to Ubuntu server edition 16.04
> (development version), I have not had those issues. While I have
> no proof, I have assumed the issue elimination was somehow related
> to the change to systemd.
>=20
> It might be worth observing both what the intel_pstate is asking for
> and what the processor is actually doing.

If=C2=A0J=C3=B6rg runs with

turbostat -i 1 --msr=3D0x199

We can tell whether if we requested or the same problem you had.
I tried on Ubuntu LTS 14.04 on same Haswell CPU model, I didn't see
this issue.

Thanks,
Srinivas
