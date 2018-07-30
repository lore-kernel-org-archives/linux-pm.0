From: Francisco Jerez <currojerez@riseup.net>
Subject: Re: [PATCH 4/4] cpufreq: intel_pstate: enable boost for Skylake Xeon
Date: Mon, 30 Jul 2018 11:32:24 -0700
Message-ID: <87lg9sefrb.fsf@riseup.net>
References: <20180605214242.62156-1-srinivas.pandruvada@linux.intel.com> <20180605214242.62156-5-srinivas.pandruvada@linux.intel.com> <87bmarhqk4.fsf@riseup.net> <20180728123639.7ckv3ljnei3urn6m@techsingularity.net> <87r2jnf6w0.fsf@riseup.net> <20180730154347.wrcrkweckclgbyrp@techsingularity.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730154347.wrcrkweckclgbyrp@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, lenb@kernel.org, rjw@rjwysocki.net, peterz@infradead.org, ggherdovich@suse.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, juri.lelli@redhat.com, viresh.kumar@linaro.org, Chris Wilson <chris@chris-wilson.co.uk>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Eero Tamminen <eero.t.tamminen@intel.com>
List-Id: linux-pm@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Mel Gorman <mgorman@techsingularity.net> writes:

> On Sat, Jul 28, 2018 at 01:21:51PM -0700, Francisco Jerez wrote:
>> >> Please revert this series, it led to significant energy usage and
>> >> graphics performance regressions [1].  The reasons are roughly the on=
es
>> >> we discussed by e-mail off-list last April: This causes the intel_pst=
ate
>> >> driver to decrease the EPP to zero when the workload blocks on IO
>> >> frequently enough, which for the regressing benchmarks detailed in [1]
>> >> is a symptom of the workload being heavily IO-bound, which means they
>> >> won't benefit at all from the EPP boost since they aren't significant=
ly
>> >> CPU-bound, and they will suffer a decrease in parallelism due to the
>> >> active CPU core using a larger fraction of the TDP in order to achieve
>> >> the same work, causing the GPU to have a lower power budget available,
>> >> leading to a decrease in system performance.
>> >
>> > It slices both ways.
>>=20
>> I don't think it's acceptable to land an optimization that trades
>> performance of one use-case for another,
>
> The same logic applies to a revert

No, it doesn't, the responsibility of addressing the fallout from a
change that happens to hurt performance even though it was supposed to
improve it lies on the author of the change, not on the reporter of the
regression.

> but that aside, I see that there is at least one patch floating around
> to disable HWP Boost for desktops and laptops. Maybe that'll be
> sufficient for the cases where IGP is a major component.
>
>> especially since one could make
>> both use-cases happy by avoiding the boost in cases where we know
>> beforehand that we aren't going to achieve any improvement in
>> performance, because an application waiting frequently on an IO device
>> which is 100% utilized isn't going to run faster just because we ramp up
>> the CPU frequency, since the IO device won't be able to process requests
>> from the application faster anyway, so we will only be pessimizing
>> energy efficiency (and potentially decreasing performance of the GPU
>> *and* of other CPU cores living on the same package for no benefit).
>>=20
>
> The benchmarks in question are not necessarily utilising IO at 100% or
> IO-bound.

Exactly.  That's the only reason why they are able to take advantage of
HWP boost, while the regressing graphics benchmarks are not, since they
are utilizing an IO device at 100%.  Both categories of use-cases sleep
on IO-wait frequently, but only the former are authentically CPU-bound.

> One pattern is a small fsync which ends up context switching between
> the process and a journalling thread (may be dedicated thread, may be
> workqueue depending on filesystem) and the process waking again in the
> very near future on IO completion. While the workload may be single
> threaded, more than one core is in use because of how the short sleeps
> migrate the task to other cores.  HWP does not necessarily notice that
> the task is quite CPU-intensive due to the migrations and so the
> performance suffers.
>
> Some effort is made to minimise the number of cores used with this sort
> of waker/wakee relationship but it's not necessarily enough for HWP to
> boost the frequency.  Minimally, the journalling thread woken up will
> not wake on the same CPU as the IO issuer except under extremely heavily
> utilisation and this is not likely to change (stacking stacks too often
> increases wakeup latency).
>

The task scheduler does go through the effort of attempting to re-use
the most frequently active CPU when a task wakes up, at least last time
I checked.  But yes some migration patterns can exacerbate the downward
bias of the response of the HWP to an intermittent workload, primarily
in cases where the application is unable to take advantage of the
parallelism between CPU and the IO device involved, like you're
describing above.

>> > With the series, there are large boosts to performance on other
>> > workloads where a slight increase in power usage is acceptable in
>> > exchange for performance. For example,
>> >
>> > Single socket skylake running sqlite
>> >                                  v4.17               41ab43c9
>> > Min       Trans     2580.85 (   0.00%)     5401.58 ( 109.29%)
>> > Hmean     Trans     2610.38 (   0.00%)     5518.36 ( 111.40%)
>> > Stddev    Trans       28.08 (   0.00%)      208.90 (-644.02%)
>> > CoeffVar  Trans        1.08 (   0.00%)        3.78 (-251.57%)
>> > Max       Trans     2648.02 (   0.00%)     5992.74 ( 126.31%)
>> > BHmean-50 Trans     2629.78 (   0.00%)     5643.81 ( 114.61%)
>> > BHmean-95 Trans     2620.38 (   0.00%)     5538.32 ( 111.36%)
>> > BHmean-99 Trans     2620.38 (   0.00%)     5538.32 ( 111.36%)
>> >
>> > That's over doubling the transactions per second for that workload.
>> >
>> > Two-socket skylake running dbench4
>> >                                 v4.17               41ab43c9
>> > Amean      1         40.85 (   0.00%)       14.97 (  63.36%)
>> > Amean      2         42.31 (   0.00%)       17.33 (  59.04%)
>> > Amean      4         53.77 (   0.00%)       27.85 (  48.20%)
>> > Amean      8         68.86 (   0.00%)       43.78 (  36.42%)
>> > Amean      16        82.62 (   0.00%)       56.51 (  31.60%)
>> > Amean      32       135.80 (   0.00%)      116.06 (  14.54%)
>> > Amean      64       737.51 (   0.00%)      701.00 (   4.95%)
>> > Amean      512    14996.60 (   0.00%)    14755.05 (   1.61%)
>> >
>> > This is reporting the average latency of operations running
>> > dbench. The series over halves the latencies. There are many examples
>> > of basic workloads that benefit heavily from the series and while I
>> > accept it may not be universal, such as the case where the graphics
>> > card needs the power and not the CPU, a straight revert is not the
>> > answer. Without the series, HWP cripplies the CPU.
>> >
>>=20
>> That seems like a huge overstatement.  HWP doesn't "cripple" the CPU
>> without this series.  It will certainly set lower clocks than with this
>> series for workloads like you show above that utilize the CPU very
>> intermittently (i.e. they underutilize it).=20
>
> Dbench for example can be quite CPU intensive. When bound to a single
> core, it shows up to 80% utilisation of a single core.

So even with an oracle cpufreq governor able to guess that the
application relies on the CPU being locked to the maximum frequency
despite it utilizing less than 80% of the CPU cycles, the application
will still perform 20% worse than an alternative application handling
its IO work asynchronously.

> When unbound, the usage of individual cores appears low due to the
> migrations. It may be intermittent usage as it context switches to
> worker threads but it's not low utilisation either.
>
> intel_pstate also had logic for IO-boosting before HWP=20

The IO-boosting logic of the intel_pstate governor has the same flaw as
this unfortunately.

> so the user-visible impact for some workloads is that upgrading a
> machine's CPU can result in regressions due to HWP. Similarly it has
> been observed prior to the series that specifying no_hwp often
> performed better. So one could argue that HWP isn't "crippled" but it
> did have surprising behaviour.
>
> --=20
> Mel Gorman
> SUSE Labs

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCW19ZuAAKCRCDmTidfVK/
W+BdAQCXWWOXlKo/7l/SytRyD/lGzw5L8a9liagRGcndWH7/FgD/f4pMlruyxQ+l
gXF8W9Ic/5hT+mzUYkvhM+BUZbN2uWw=
=lOWp
-----END PGP SIGNATURE-----
--==-=-=--
