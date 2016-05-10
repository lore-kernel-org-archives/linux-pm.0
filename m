From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 1/3] intel_pstate: Clarify average performance
 computation
Date: Tue, 10 May 2016 12:58:04 -0700
Message-ID: <1462910284.28729.116.camel@linux.intel.com>
References: <2638272.Bq3MnQEe4U@vostro.rjw.lan>
	 <1880504.e9G30eDLBM@vostro.rjw.lan>
	 <1462843116.4224.16.camel@linux.intel.com>
	 <CAJZ5v0h3Z9Dr72KdXzCiv-5Yb6kjv-Bpt0weacQ2jO0gU96hEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0h3Z9Dr72KdXzCiv-5Yb6kjv-Bpt0weacQ2jO0gU96hEQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2016-05-10 at 21:21 +0200, Rafael J. Wysocki wrote:
> On Tue, May 10, 2016 at 3:18 AM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > On Sat, 2016-05-07 at 01:44 +0200, Rafael J. Wysocki wrote:
> > >=20
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >=20
> > > The core_pct_busy field of struct sample actually contains the
> > > average performace during the last sampling period (in percent)
> > > and not the utilization of the core as suggested by its name
> > > which is confusing.
> > >=20
> > > For this reason, change the name of that field to core_avg_perf
> > > and rename the function that computes its value accordingly.
> > >=20
> > Makes perfect sense.
> >=20
> > >=20
> > > Also notice that it would be more useful if it was a "raw"
> > > fraction
> > > rather than percentage, so change its meaning too and update the
> > > code using it accordingly (it is better to change the name of
> > > the field along with its meaning in one go than to make those
> > > two changes separately, as that would likely lead to more
> > > confusion).
> > Due to the calculation the results from old and new method will be
> > similar but not same. For example in one scenario the
> > get_avg_frequency difference is 4.3KHz (printed side by side using
> > both
> > old style using pct and new using fraction)
> > Frequency with old calc: 2996093 Hz
> I guess the above is the new one?
>=20
> >=20
> > Frequency with old calc: 3000460 Hz
> So the relative difference is of the order of 0.1% and that number is
> not what is used in PID computations.=C2=A0=C2=A0That's what is print=
ed, but
> I'm
> not sure if that's really that important. :-)

This difference will appear in cpufreq sysfs as their granularity in
KHz for current frequency. But the difference is very small. So I guess
no one will notice.

Thanks,
Srinivas
>=20
> Here, the sample.aperf bits lost because the 100 was moved away from
> intel_pstate_calc_busy() would be multiplied by a relatively large
> number to produce the difference that looks significant, but the
> numbers actually used in computations are a few orders of magnitude
> smaller.
>=20
> >=20
> > How much do you think the performance gain changing fraction vs
> > pct?
> I'm more concerned about latency than about performance.=C2=A0=C2=A0O=
n HWP, for
> example, the costly multiplication removed by this from the hot path
> is of the order of the half of the work done.
>=20
> That said, I can do something to retain the bits in question for as
> long as possible, although the patch will be slightly more
> complicated
> then. :-)
The
