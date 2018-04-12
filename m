From: Francisco Jerez <currojerez@riseup.net>
Subject: Re: [PATCH 0/9] GPU-bound energy efficiency
 improvements for the intel_pstate driver.
Date: Thu, 12 Apr 2018 12:55:39 -0700
Message-ID: <87a7u842tg.fsf@riseup.net>
References: <20180328063845.4884-1-currojerez@riseup.net>
 <87604ybssf.fsf@riseup.net> <1523416474.2700.2.camel@linux.intel.com>
 <87vacx7mh3.fsf@riseup.net> <87muy97lr0.fsf@riseup.net>
 <20180412085824.GX4082@hirez.programming.kicks-ass.net>
 <87r2nk46k1.fsf@riseup.net>
 <20180412193335.GA4330@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1005062553=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20180412193335.GA4330@worktop.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: intel-gfx@lists.freedesktop.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Eero Tamminen <eero.t.tamminen@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

--===============1005062553==
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, Apr 12, 2018 at 11:34:54AM -0700, Francisco Jerez wrote:
>> The reason for the energy efficiency problem of iowait boosting is
>> precisely the greater oscillation between turbo and idle.  Say that
>> iowait boost increases the frequency by a factor alpha relative to the
>> optimal frequency f0 (in terms of energy efficiency) required to execute
>> some IO-bound workload.  This will cause the CPU to be busy for a
>> fraction of the time it was busy originally, approximately t1 = t0 /
>> alpha, which indeed divides the overall energy usage by a factor alpha,
>> but at the same time multiplies the instantaneous power consumption
>> while busy by a factor potentially much greater than alpha, since the
>> CPU's power curve is largely non-linear, and in fact approximately
>> convex within the frequency range allowed by the policy, so you get an
>> average energy usage possibly much greater than the optimal.
>
> Ah, but we don't (yet) have the (normalized) power curves, so we cannot
> make that call.
>
> Once we have the various energy/OPP numbers required for EAS we can
> compute the optimal. I think such was even mentioned in the thread I
> referred earlier.
>
> Until such time; we boost to max for lack of a better option.

Actually assuming that a single geometric feature of the power curve is
known -- it being convex in the frequency range allowed by the policy
(which is almost always the case, not only for Intel CPUs), the optimal
frequency for an IO-bound workload is fully independent of the exact
power curve -- It's just the minimum CPU frequency that's able to keep
the bottlenecking IO device at 100% utilization.  Any frequency higher
than that will lead to strictly lower energy efficiency whatever the
exact form of the power curve is.

I agree though that exact knowledge of the power curve *might* be useful
as a mechanism to estimate the potential costs of exceeding that optimal
frequency (e.g. as a mechanism to offset performance loss heuristically
for the case the workload fluctuates by giving the governor an upward
bias with an approximately known energy cost), but that's not required
for the governor's behavior to be approximately optimal in IO-bound
conditions.  Not making further assumptions about the power curve beyond
its convexity makes the algorithm fairly robust against any inaccuracy
in the power curve numbers (which there will always be, since the energy
efficiency of the workload is really dependent on the behavior of
multiple components of the system interacting with each other), and
makes it easily reusable on platforms where the exact power curves are
not known.

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCWs+5uwAKCRCDmTidfVK/
W39oAP457fSIeKsqMUroVDNHWGhZcIQTFui6jEqO6aicPS+0gQEAl3s2ALFxrBL1
/cCqfGGCM4Aa9h4Cdxv48Vpp1ja0Zvw=
=rv2G
-----END PGP SIGNATURE-----
--==-=-=--

--===============1005062553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============1005062553==--
