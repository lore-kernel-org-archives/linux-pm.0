From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Wed, 30 Mar 2016 13:26:27 -0700
Message-ID: <1459369587.13525.75.camel@linux.intel.com>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>
	 <CADDKRnCH3yCut7A4Gvk3gHw4OpOYXoG0VQRe5mh2nTjptYU0gw@mail.gmail.com>
	 <4187911.uaFVupaTVL@vostro.rjw.lan>
	 <CADDKRnCr0riAu4pjYRkuguoCoAjWxFoc+pU1NBymPr+3JnVanQ@mail.gmail.com>
	 <CAJZ5v0i48Xxyp880SQ1iVDzct--vhTVggCS_wHHA7bt7D+_sFg@mail.gmail.com>
	 <1459352017.13525.45.camel@intel.com>
	 <CADDKRnA5x9dK=6KZWijiP_ihrUA9Afpmqw8TSzYn9oaBeaOfKw@mail.gmail.com>
	 <002401d18ab5$0bf84a30$23e8de90$@net>
	 <1459364336.13525.69.camel@linux.intel.com>
	 <CAJZ5v0gDNYRNaLKFCnPRomOhavLPD=zgp1oJdRv6OtHLb031Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gDNYRNaLKFCnPRomOhavLPD=zgp1oJdRv6OtHLb031Bw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Doug Smythies <dsmythies@telus.net>, =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 2016-03-30 at 22:12 +0200, Rafael J. Wysocki wrote:
> On Wed, Mar 30, 2016 at 8:58 PM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > On Wed, 2016-03-30 at 11:50 -0700, Doug Smythies wrote:
> > >=20
> > > On 2016.03.30 08:52 J=C3=B6rg Otte wrote:
> > > >=20
> > > >=20
> > > > 2016-03-30 17:33 GMT+02:00 Pandruvada, Srinivas
> > > > <srinivas.pandruvad
> > > > a@intel.com>:
> > > > >=20
> > > > >=20
> > > > > On Wed, 2016-03-30 at 13:05 +0200, Rafael J. Wysocki wrote:
> > > > > >=20
> > > > > >=20
> > > > > > On Wed, Mar 30, 2016 at 12:17 PM, J=C3=B6rg Otte <jrg.otte@=
gmail
> > > > > > .com
> > > > > > >=20
> > > > > > >=20
> > > > >=20
> > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > Now in v4.6-rc1 the characteristic has dramatically
> > > > > > > > > changed.
> > > > > > > > > If in idle the processor frequency is more or less a
> > > > > > > > > few
> > > > > > > > > MHz around 2500Mhz.
> > > > > > > > > I currently use acpi_cpufreq which works as usual.
> > > > > > > > > Processor: Intel(R) Core(TM) i5-4200M CPU @ 2.50GHz
> > > > > > > > > (family: 0x6, model: 0x3c, stepping: 0x3)
> > > > >=20
> > > > >=20
> > > > > I want to reproduce this if I can. Can you give us info about
> > > > > your
> > > > > setup (Linux distribution, laptop model etc.)?
> > > I would like to try to reproduce the issue also.
> > >=20
> > > >=20
> > > >=20
> > > > Distro: Ubuntu 14.04.4 LTS
> > > Note that with Ubuntu 14.04, I had issues where my CPU
> > > would lock at pstate 24 (not always 24, but usually),
> > > regardless of load.
> > > However, it was always after an S3 suspend, occurred 100%
> > > of the time, and was independent of intel_pstate or
> > > acpi-cpufreq CPU frequency scaling drivers.
> > >=20
> > > Since changing my test server to Ubuntu server edition 16.04
> > > (development version), I have not had those issues. While I have
> > > no proof, I have assumed the issue elimination was somehow
> > > related
> > > to the change to systemd.
> > >=20
> > > It might be worth observing both what the intel_pstate is asking
> > > for
> > > and what the processor is actually doing.
> > If J=C3=B6rg runs with
> >=20
> > turbostat -i 1 --msr=3D0x199
> >=20
> > We can tell whether if we requested or the same problem you had.
> > I tried on Ubuntu LTS 14.04 on same Haswell CPU model, I didn't see
> > this issue.
> There seems to be something odd about the J=C3=B6rg's setup, or we'd =
have
> received more reports about this issue.
>=20
> Question is what that is and what really makes the difference.
>=20
I think, somehow we entered performance mode from powersave by default

turbostat -i 1 --msr=3D0x199 will tell us.=C2=A0

Thanks,
Srinivas

> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
