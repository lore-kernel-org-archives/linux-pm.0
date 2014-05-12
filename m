From: Yuyang Du <yuyang.du@intel.com>
Subject: Re: [RFC PATCH] cpufreq: intel_pstate: Change the calculation of
 next pstate
Date: Tue, 13 May 2014 04:34:16 +0800
Message-ID: <20140512203416.GB10676@intel.com>
References: <5368255D.3090207@semaphore.gr>
 <536BEE89.3040602@gmail.com>
 <536CECB4.1090109@semaphore.gr>
 <53712F4B.7000101@semaphore.gr>
 <20140512193453.GB9351@intel.com>
 <537198AE.3050100@semaphore.gr>
 <20140512200140.GA10676@intel.com>
 <53719C98.1010103@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53719C98.1010103@semaphore.gr>
Sender: linux-kernel-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On Tue, May 13, 2014 at 07:16:24AM +0300, Stratos Karafotis wrote:
> On 12/05/2014 11:01 =CE=BC=CE=BC, Yuyang Du wrote:
> > On Tue, May 13, 2014 at 06:59:42AM +0300, Stratos Karafotis wrote:
> >> Hi,
> >>
> >> On 12/05/2014 10:34 =CE=BC=CE=BC, Yuyang Du wrote:
> >>> On Mon, May 12, 2014 at 11:30:03PM +0300, Stratos Karafotis wrote=
:
> >>>> On 09/05/2014 05:56 =CE=BC=CE=BC, Stratos Karafotis wrote:
> >>>>
> >>>> Next performance state =3D min_perf + (max_perf - min_perf) * lo=
ad / 100
> >>>>
> >>> Hi,
> >>>
> >>> This formula is fundamentally broken. You need to associate the l=
oad with its
> >>> frequency.
> >>
> >> Could you please explain why is it broken? I think the load should=
 be
> >> independent from the current frequency.
> >=20
> > Why independent? The load not (somewhat) determined by that?
> >=20
> >=20
>=20
> Maybe, in some cases yes. But not always.
> For example, please consider a CPU running a tight "for" loop in 100M=
Hz
> for a couple of seconds. This produces a load of 100%.
> It will produce the same load (100%) in any other frequency.
=20
Still fundamentally wrong, because you are not making a fair
comparison ("load" in 100MHz vs. any other freq).

Yuyang
