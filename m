From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V4] cpufreq: suspend governors on system suspend/hibernate
Date: Sun, 08 Dec 2013 01:34:36 +0100
Message-ID: <3466098.C5M665z3nb@vostro.rjw.lan>
References: <28d493f20239a242a7b26dfe1efed40d83bf1e10.1385523340.git.viresh.kumar@linaro.org> <87vbz0j55p.fsf@nemi.mork.no> <1386429849.9737.7.camel@x41.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1386429849.9737.7.camel@x41.thuisdomein>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, Viresh Kumar <viresh.kumar@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Kgene Kim <kgene.kim@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-tegra@vger.kernel.org, jinchoi@broadcom.com, Lan Tianyu <tianyu.lan@intel.com>, Sebastian Capella <sebastian.capella@linaro.org>, Jonghwan Choi <jhbird.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Saturday, December 07, 2013 04:24:09 PM Paul Bolle wrote:
> On Sat, 2013-12-07 at 12:01 +0100, Bj=C3=B8rn Mork wrote:
> > Sorry to be making noise here again, but I was eager to verify that=
 the
> > fixes in v3.13-rc3 were OK on my system.  Unfortunately it seems th=
is
> > patch completely broke suspend for me.  Hibernete ended up with a b=
lank
> > console and no visible activity, without ever writing any image to =
disk.
> >=20
> > There really weren't that many suspects between v3.13-rc2 and v3.13=
-rc3,
> > so I went directly to reverting 5a87182aa21d ("cpufreq: suspend
> > governors on system suspend/hibernate") which fixed the problem. I
> > didn't bother debugging it further from there. I don't think there =
is
> > anything magic about my system which should make this problem speci=
fic
> > to it.
> >=20
> > I am still using the acpi-cpufreq driver on an old x86_64 laptop if=
 that
> > matters.
>=20
> On an x86 (32 bits) laptop hibernate also broke in v3.13-rc3. On that
> machine hibernation itself worked, or at least seemed to work, but th=
e
> machine would basically stop after thawing (directly after loading th=
e
> hibernation image).
>=20
> And reverting commit 5a87182aa21d ("cpufreq: suspend governors on sys=
tem
> suspend/hibernate"), on top of v3.13-rc3, also lead to a successful
> hibernation/thaw cycle.

OK, reverted.

I'll send a pull request with that revert shortly.

Thanks,
Rafael
