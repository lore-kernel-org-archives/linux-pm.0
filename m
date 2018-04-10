From: Francisco Jerez <currojerez@riseup.net>
Subject: Re: [PATCH 0/9] GPU-bound energy efficiency
 improvements for the intel_pstate driver.
Date: Tue, 10 Apr 2018 15:28:16 -0700
Message-ID: <87604ybssf.fsf@riseup.net>
References: <20180328063845.4884-1-currojerez@riseup.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1757027629=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20180328063845.4884-1-currojerez@riseup.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc: Eero Tamminen <eero.t.tamminen@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

--===============1757027629==
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Francisco Jerez <currojerez@riseup.net> writes:

> This series attempts to solve an energy efficiency problem of the
> current active-mode non-HWP governor of the intel_pstate driver used
> for the most part on low-power platforms.  Under heavy IO load the
> current controller tends to increase frequencies to the maximum turbo
> P-state, partly due to IO wait boosting, partly due to the roughly
> flat frequency response curve of the current controller (see
> [6]), which causes it to ramp frequencies up and down repeatedly for
> any oscillating workload (think of graphics, audio or disk IO when any
> of them becomes a bottleneck), severely increasing energy usage
> relative to a (throughput-wise equivalent) controller able to provide
> the same average frequency without fluctuation.  The core energy
> efficiency improvement has been observed to be of the order of 20% via
> RAPL, but it's expected to vary substantially between workloads (see
> perf-per-watt comparison [2]).
>
> One might expect that this could come at some cost in terms of system
> responsiveness, but the governor implemented in PATCH 6 has a variable
> response curve controlled by a heuristic that keeps the controller in
> a low-latency state unless the system is under heavy IO load for an
> extended period of time.  The low-latency behavior is actually
> significantly more aggressive than the current governor, allowing it
> to achieve better throughput in some scenarios where the load
> ping-pongs between the CPU and some IO device (see PATCH 6 for more of
> the rationale).  The controller offers relatively lower latency than
> the upstream one particularly while C0 residency is low (which by
> itself contributes to mitigate the increased energy usage while on
> C0).  However under certain conditions the low-latency heuristic may
> increase power consumption (see perf-per-watt comparison [2], the
> apparent regressions are correlated with an increase in performance in
> the same benchmark due to the use of the low-latency heuristic) -- If
> this is a problem a different trade-off between latency and energy
> usage shouldn't be difficult to achieve, but it will come at a
> performance cost in some cases.  I couldn't observe a statistically
> significant increase in idle power consumption due to this behavior
> (on BXT J3455):
>
> package-0 RAPL (W):    XXXXXX =C2=B10.14% x8 ->     XXXXXX =C2=B10.15% x9=
         d=3D-0.04% =C2=B10.14%      p=3D61.73%
>

For the case anyone is wondering what's going on, Srinivas pointed me at
a larger idle power usage increase off-list, ultimately caused by the
low-latency heuristic as discussed in the paragraph above.  I have a v2
of PATCH 6 that gives the controller a third response curve roughly
intermediate between the low-latency and low-power states of this
revision, which avoids the energy usage increase while C0 residency is
low (e.g. during idle) expected for v1.  The low-latency behavior of
this revision is still going to be available based on a heuristic (in
particular when a realtime-priority task is scheduled).  We're carrying
out some additional testing, I'll post the code here eventually.

> [Absolute benchmark results are unfortunately omitted from this letter
> due to company policies, but the percent change and Student's T
> p-value are included above and in the referenced benchmark results]
>
> The most obvious impact of this series will likely be the overall
> improvement in graphics performance on systems with an IGP integrated
> into the processor package (though for the moment this is only enabled
> on BXT+), because the TDP budget shared among CPU and GPU can
> frequently become a limiting factor in low-power devices.  On heavily
> TDP-bound devices this series improves performance of virtually any
> non-trivial graphics rendering by a significant amount (of the order
> of the energy efficiency improvement for that workload assuming the
> optimization didn't cause it to become non-TDP-bound).
>
> See [1]-[5] for detailed numbers including various graphics benchmarks
> and a sample of the Phoronix daily-system-tracker.  Some popular
> graphics benchmarks like GfxBench gl_manhattan31 and gl_4 improve
> between 5% and 11% on our systems.  The exact improvement can vary
> substantially between systems (compare the benchmark results from the
> two different J3455 systems [1] and [3]) due to a number of factors,
> including the ratio between CPU and GPU processing power, the behavior
> of the userspace graphics driver, the windowing system and resolution,
> the BIOS (which has an influence on the package TDP), the thermal
> characteristics of the system, etc.
>
> Unigine Valley and Heaven improve by a similar factor on some systems
> (see the J3455 results [1]), but on others the improvement is lower
> because the benchmark fails to fully utilize the GPU, which causes the
> heuristic to remain in low-latency state for longer, which leaves a
> reduced TDP budget available to the GPU, which prevents performance
> from increasing further.  This can be avoided by using the alternative
> heuristic parameters suggested in the commit message of PATCH 8, which
> provide a lower IO utilization threshold and hysteresis for the
> controller to attempt to save energy.  I'm not proposing those for
> upstream (yet) because they would also increase the risk for
> latency-sensitive IO-heavy workloads to regress (like SynMark2
> OglTerrainFly* and some arguably poorly designed IPC-bound X11
> benchmarks).
>
> Discrete graphics aren't likely to experience that much of a visible
> improvement from this, even though many non-IGP workloads *could*
> benefit by reducing the system's energy usage while the discrete GPU
> (or really, any other IO device) becomes a bottleneck, but this is not
> attempted in this series, since that would involve making an energy
> efficiency/latency trade-off that only the maintainers of the
> respective drivers are in a position to make.  The cpufreq interface
> introduced in PATCH 1 to achieve this is left as an opt-in for that
> reason, only the i915 DRM driver is hooked up since it will get the
> most direct pay-off due to the increased energy budget available to
> the GPU, but other power-hungry third-party gadgets built into the
> same package (*cough* AMD *cough* Mali *cough* PowerVR *cough*) may be
> able to benefit from this interface eventually by instrumenting the
> driver in a similar way.
>
> The cpufreq interface is not exclusively tied to the intel_pstate
> driver, because other governors can make use of the statistic
> calculated as result to avoid over-optimizing for latency in scenarios
> where a lower frequency would be able to achieve similar throughput
> while using less energy.  The interpretation of this statistic relies
> on the observation that for as long as the system is CPU-bound, any IO
> load occurring as a result of the execution of a program will scale
> roughly linearly with the clock frequency the program is run at, so
> (assuming that the CPU has enough processing power) a point will be
> reached at which the program won't be able to execute faster with
> increasing CPU frequency because the throughput limits of some device
> will have been attained.  Increasing frequencies past that point only
> pessimizes energy usage for no real benefit -- The optimal behavior is
> for the CPU to lock to the minimum frequency that is able to keep the
> IO devices involved fully utilized (assuming we are past the
> maximum-efficiency inflection point of the CPU's power-to-frequency
> curve), which is roughly the goal of this series.
>
> PELT could be a useful extension for this model since its largely
> heuristic assumptions would become more accurate if the IO and CPU
> load could be tracked separately for each scheduling entity, but this
> is not attempted in this series because the additional complexity and
> computational cost of such an approach is hard to justify at this
> stage, particularly since the current governor has similar
> limitations.
>
> Various frequency and step-function response graphs are available in
> [6]-[9] for comparison (obtained empirically on a BXT J3455 system).
> The response curves for the low-latency and low-power states of the
> heuristic are shown separately -- As you can see they roughly bracket
> the frequency response curve of the current governor.  The step
> response of the aggressive heuristic is within a single update period
> (even though it's not quite obvious from the graph with the levels of
> zoom provided).  I'll attach benchmark results from a slower but
> non-TDP-limited machine (which means there will be no TDP budget
> increase that could possibly mask a performance regression of other
> kind) as soon as they come out.
>
> Thanks to Eero and Valtteri for testing a number of intermediate
> revisions of this series (and there were quite a few of them) in more
> than half a dozen systems, they helped spot quite a few issues of
> earlier versions of this heuristic.
>
> [PATCH 1/9] cpufreq: Implement infrastructure keeping track of aggregated=
 IO active time.
> [PATCH 2/9] Revert "cpufreq: intel_pstate: Replace bxt_funcs with core_fu=
ncs"
> [PATCH 3/9] Revert "cpufreq: intel_pstate: Shorten a couple of long names"
> [PATCH 4/9] Revert "cpufreq: intel_pstate: Simplify intel_pstate_adjust_p=
state()"
> [PATCH 5/9] Revert "cpufreq: intel_pstate: Drop ->update_util from pstate=
_funcs"
> [PATCH 6/9] cpufreq/intel_pstate: Implement variably low-pass filtering c=
ontroller for small core.
> [PATCH 7/9] SQUASH: cpufreq/intel_pstate: Enable LP controller based on A=
CPI FADT profile.
> [PATCH 8/9] OPTIONAL: cpufreq/intel_pstate: Expose LP controller paramete=
rs via debugfs.
> [PATCH 9/9] drm/i915/execlists: Report GPU rendering as IO activity to cp=
ufreq.
>
> [1] http://people.freedesktop.org/~currojerez/intel_pstate-lp/benchmark-p=
erf-comparison-J3455.log
> [2] http://people.freedesktop.org/~currojerez/intel_pstate-lp/benchmark-p=
erf-per-watt-comparison-J3455.log
> [3] http://people.freedesktop.org/~currojerez/intel_pstate-lp/benchmark-p=
erf-comparison-J3455-1.log
> [4] http://people.freedesktop.org/~currojerez/intel_pstate-lp/benchmark-p=
erf-comparison-J4205.log
> [5] http://people.freedesktop.org/~currojerez/intel_pstate-lp/benchmark-p=
erf-comparison-J5005.log
> [6] http://people.freedesktop.org/~currojerez/intel_pstate-lp/frequency-r=
esponse-magnitude-comparison.svg
> [7] http://people.freedesktop.org/~currojerez/intel_pstate-lp/frequency-r=
esponse-phase-comparison.svg
> [8] http://people.freedesktop.org/~currojerez/intel_pstate-lp/step-respon=
se-comparison-1.svg
> [9] http://people.freedesktop.org/~currojerez/intel_pstate-lp/step-respon=
se-comparison-2.svg

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCWs06gAAKCRCDmTidfVK/
W3hqAP9dczapF1FBALwAr4QRQN3PHIWRtub35REZsV4Jtli4WgEAi+C2VrlavEWc
MF4iM4pcBHdCBufVJcP4OJhYQQ2tNLk=
=uZJF
-----END PGP SIGNATURE-----
--==-=-=--

--===============1757027629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============1757027629==--
