From: Francisco Jerez <currojerez@riseup.net>
Subject: Re: [PATCH 0/9] GPU-bound energy efficiency
 improvements for the intel_pstate driver.
Date: Wed, 11 Apr 2018 09:10:32 -0700
Message-ID: <87vacx7mh3.fsf@riseup.net>
References: <20180328063845.4884-1-currojerez@riseup.net>
 <87604ybssf.fsf@riseup.net> <1523416474.2700.2.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0268050232=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1523416474.2700.2.camel@linux.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc: Peter Zijlstra <peterz@infradead.org>, Eero Tamminen <eero.t.tamminen@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

--===============0268050232==
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Srinivas,

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:

> On Tue, 2018-04-10 at 15:28 -0700, Francisco Jerez wrote:
>> Francisco Jerez <currojerez@riseup.net> writes:
>>=20
> [...]
>
>
>> For the case anyone is wondering what's going on, Srinivas pointed me
>> at
>> a larger idle power usage increase off-list, ultimately caused by the
>> low-latency heuristic as discussed in the paragraph above.=C2=A0=C2=A0I =
have a
>> v2
>> of PATCH 6 that gives the controller a third response curve roughly
>> intermediate between the low-latency and low-power states of this
>> revision, which avoids the energy usage increase while C0 residency
>> is
>> low (e.g. during idle) expected for v1.=C2=A0=C2=A0The low-latency behav=
ior of
>> this revision is still going to be available based on a heuristic (in
>> particular when a realtime-priority task is scheduled).=C2=A0=C2=A0We're
>> carrying
>> out some additional testing, I'll post the code here eventually.
>
> Please try sched-util governor also. There is a frequency-invariant
> patch, which I can send you (This eventually will be pushed by Peter).
> We want to avoid complexity to intel-pstate for non HWP power sensitive
> platforms as far as possible.
>

Unfortunately the schedutil governor (whether frequency invariant or
not) has the exact same energy efficiency issues as the present
intel_pstate non-HWP governor.  Its response is severely underdamped
leading to energy-inefficient behavior for any oscillating non-CPU-bound
workload.  To exacerbate that problem the frequency is maxed out on
frequent IO waiting just like the current intel_pstate cpu-load
controller does, even though the frequent IO waits may actually be an
indication that the system is IO-bound (which means that the large
energy usage increase may not be translated in any performance benefit
in practice, not to speak of performance being impacted negatively in
TDP-bound scenarios like GPU rendering).

Regarding run-time complexity, I haven't observed this governor to be
measurably more computationally intensive than the present one.  It's a
bunch more instructions indeed, but still within the same ballpark as
the current governor.  The average increase in CPU utilization on my BXT
with this series is less than 0.03% (sampled via ftrace for v1, I can
repeat the measurement for the v2 I have in the works, though I don't
expect the result to be substantially different).  If this is a problem
for you there are several optimization opportunities that would cut down
the number of CPU cycles get_target_pstate_lp() takes to execute by a
large percent (most of the optimization ideas I can think of right now
though would come at some accuracy/maintainability/debuggability cost,
but may still be worth pursuing), but the computational overhead is low
enough at this point that the impact on any benchmark or real workload
would be orders of magnitude lower than its variance, which makes it
kind of difficult to keep the discussion data-driven [as possibly any
performance optimization discussion should ever be ;)].

>
> Thanks,
> Srinivas
>
>
>
>>=20
>> > [Absolute benchmark results are unfortunately omitted from this
>> > letter
>> > due to company policies, but the percent change and Student's T
>> > p-value are included above and in the referenced benchmark results]
>> >=20
>> > The most obvious impact of this series will likely be the overall
>> > improvement in graphics performance on systems with an IGP
>> > integrated
>> > into the processor package (though for the moment this is only
>> > enabled
>> > on BXT+), because the TDP budget shared among CPU and GPU can
>> > frequently become a limiting factor in low-power devices.=C2=A0=C2=A0On
>> > heavily
>> > TDP-bound devices this series improves performance of virtually any
>> > non-trivial graphics rendering by a significant amount (of the
>> > order
>> > of the energy efficiency improvement for that workload assuming the
>> > optimization didn't cause it to become non-TDP-bound).
>> >=20
>> > See [1]-[5] for detailed numbers including various graphics
>> > benchmarks
>> > and a sample of the Phoronix daily-system-tracker.=C2=A0=C2=A0Some pop=
ular
>> > graphics benchmarks like GfxBench gl_manhattan31 and gl_4 improve
>> > between 5% and 11% on our systems.=C2=A0=C2=A0The exact improvement ca=
n vary
>> > substantially between systems (compare the benchmark results from
>> > the
>> > two different J3455 systems [1] and [3]) due to a number of
>> > factors,
>> > including the ratio between CPU and GPU processing power, the
>> > behavior
>> > of the userspace graphics driver, the windowing system and
>> > resolution,
>> > the BIOS (which has an influence on the package TDP), the thermal
>> > characteristics of the system, etc.
>> >=20
>> > Unigine Valley and Heaven improve by a similar factor on some
>> > systems
>> > (see the J3455 results [1]), but on others the improvement is lower
>> > because the benchmark fails to fully utilize the GPU, which causes
>> > the
>> > heuristic to remain in low-latency state for longer, which leaves a
>> > reduced TDP budget available to the GPU, which prevents performance
>> > from increasing further.=C2=A0=C2=A0This can be avoided by using the
>> > alternative
>> > heuristic parameters suggested in the commit message of PATCH 8,
>> > which
>> > provide a lower IO utilization threshold and hysteresis for the
>> > controller to attempt to save energy.=C2=A0=C2=A0I'm not proposing tho=
se for
>> > upstream (yet) because they would also increase the risk for
>> > latency-sensitive IO-heavy workloads to regress (like SynMark2
>> > OglTerrainFly* and some arguably poorly designed IPC-bound X11
>> > benchmarks).
>> >=20
>> > Discrete graphics aren't likely to experience that much of a
>> > visible
>> > improvement from this, even though many non-IGP workloads *could*
>> > benefit by reducing the system's energy usage while the discrete
>> > GPU
>> > (or really, any other IO device) becomes a bottleneck, but this is
>> > not
>> > attempted in this series, since that would involve making an energy
>> > efficiency/latency trade-off that only the maintainers of the
>> > respective drivers are in a position to make.=C2=A0=C2=A0The cpufreq
>> > interface
>> > introduced in PATCH 1 to achieve this is left as an opt-in for that
>> > reason, only the i915 DRM driver is hooked up since it will get the
>> > most direct pay-off due to the increased energy budget available to
>> > the GPU, but other power-hungry third-party gadgets built into the
>> > same package (*cough* AMD *cough* Mali *cough* PowerVR *cough*) may
>> > be
>> > able to benefit from this interface eventually by instrumenting the
>> > driver in a similar way.
>> >=20
>> > The cpufreq interface is not exclusively tied to the intel_pstate
>> > driver, because other governors can make use of the statistic
>> > calculated as result to avoid over-optimizing for latency in
>> > scenarios
>> > where a lower frequency would be able to achieve similar throughput
>> > while using less energy.=C2=A0=C2=A0The interpretation of this statist=
ic
>> > relies
>> > on the observation that for as long as the system is CPU-bound, any
>> > IO
>> > load occurring as a result of the execution of a program will scale
>> > roughly linearly with the clock frequency the program is run at, so
>> > (assuming that the CPU has enough processing power) a point will be
>> > reached at which the program won't be able to execute faster with
>> > increasing CPU frequency because the throughput limits of some
>> > device
>> > will have been attained.=C2=A0=C2=A0Increasing frequencies past that p=
oint
>> > only
>> > pessimizes energy usage for no real benefit -- The optimal behavior
>> > is
>> > for the CPU to lock to the minimum frequency that is able to keep
>> > the
>> > IO devices involved fully utilized (assuming we are past the
>> > maximum-efficiency inflection point of the CPU's power-to-frequency
>> > curve), which is roughly the goal of this series.
>> >=20
>> > PELT could be a useful extension for this model since its largely
>> > heuristic assumptions would become more accurate if the IO and CPU
>> > load could be tracked separately for each scheduling entity, but
>> > this
>> > is not attempted in this series because the additional complexity
>> > and
>> > computational cost of such an approach is hard to justify at this
>> > stage, particularly since the current governor has similar
>> > limitations.
>> >=20
>> > Various frequency and step-function response graphs are available
>> > in
>> > [6]-[9] for comparison (obtained empirically on a BXT J3455
>> > system).
>> > The response curves for the low-latency and low-power states of the
>> > heuristic are shown separately -- As you can see they roughly
>> > bracket
>> > the frequency response curve of the current governor.=C2=A0=C2=A0The s=
tep
>> > response of the aggressive heuristic is within a single update
>> > period
>> > (even though it's not quite obvious from the graph with the levels
>> > of
>> > zoom provided).=C2=A0=C2=A0I'll attach benchmark results from a slower=
 but
>> > non-TDP-limited machine (which means there will be no TDP budget
>> > increase that could possibly mask a performance regression of other
>> > kind) as soon as they come out.
>> >=20
>> > Thanks to Eero and Valtteri for testing a number of intermediate
>> > revisions of this series (and there were quite a few of them) in
>> > more
>> > than half a dozen systems, they helped spot quite a few issues of
>> > earlier versions of this heuristic.
>> >=20
>> > [PATCH 1/9] cpufreq: Implement infrastructure keeping track of
>> > aggregated IO active time.
>> > [PATCH 2/9] Revert "cpufreq: intel_pstate: Replace bxt_funcs with
>> > core_funcs"
>> > [PATCH 3/9] Revert "cpufreq: intel_pstate: Shorten a couple of long
>> > names"
>> > [PATCH 4/9] Revert "cpufreq: intel_pstate: Simplify
>> > intel_pstate_adjust_pstate()"
>> > [PATCH 5/9] Revert "cpufreq: intel_pstate: Drop ->update_util from
>> > pstate_funcs"
>> > [PATCH 6/9] cpufreq/intel_pstate: Implement variably low-pass
>> > filtering controller for small core.
>> > [PATCH 7/9] SQUASH: cpufreq/intel_pstate: Enable LP controller
>> > based on ACPI FADT profile.
>> > [PATCH 8/9] OPTIONAL: cpufreq/intel_pstate: Expose LP controller
>> > parameters via debugfs.
>> > [PATCH 9/9] drm/i915/execlists: Report GPU rendering as IO activity
>> > to cpufreq.
>> >=20
>> > [1] http://people.freedesktop.org/~currojerez/intel_pstate-lp/bench
>> > mark-perf-comparison-J3455.log
>> > [2] http://people.freedesktop.org/~currojerez/intel_pstate-lp/bench
>> > mark-perf-per-watt-comparison-J3455.log
>> > [3] http://people.freedesktop.org/~currojerez/intel_pstate-lp/bench
>> > mark-perf-comparison-J3455-1.log
>> > [4] http://people.freedesktop.org/~currojerez/intel_pstate-lp/bench
>> > mark-perf-comparison-J4205.log
>> > [5] http://people.freedesktop.org/~currojerez/intel_pstate-lp/bench
>> > mark-perf-comparison-J5005.log
>> > [6] http://people.freedesktop.org/~currojerez/intel_pstate-lp/frequ
>> > ency-response-magnitude-comparison.svg
>> > [7] http://people.freedesktop.org/~currojerez/intel_pstate-lp/frequ
>> > ency-response-phase-comparison.svg
>> > [8] http://people.freedesktop.org/~currojerez/intel_pstate-lp/step-
>> > response-comparison-1.svg
>> > [9] http://people.freedesktop.org/~currojerez/intel_pstate-lp/step-
>> > response-comparison-2.svg

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCWs4zeAAKCRCDmTidfVK/
W6DWAP9dKPu/QBbjS+thA++nlfZ8jpm95ZZ/NpXVTAyBqRetQwD/aSqqc8sMMvai
qzzDkfTaKDZrE1xLVf9u6BdNhOaQtio=
=S8Wk
-----END PGP SIGNATURE-----
--==-=-=--

--===============0268050232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============0268050232==--
