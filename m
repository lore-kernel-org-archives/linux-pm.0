From: Francisco Jerez <currojerez@riseup.net>
Subject: Re: [PATCH 0/9] GPU-bound energy efficiency
 improvements for the intel_pstate driver.
Date: Thu, 12 Apr 2018 11:34:54 -0700
Message-ID: <87r2nk46k1.fsf@riseup.net>
References: <20180328063845.4884-1-currojerez@riseup.net>
 <87604ybssf.fsf@riseup.net> <1523416474.2700.2.camel@linux.intel.com>
 <87vacx7mh3.fsf@riseup.net> <87muy97lr0.fsf@riseup.net>
 <20180412085824.GX4082@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1320309746=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20180412085824.GX4082@hirez.programming.kicks-ass.net>
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

--===============1320309746==
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Apr 11, 2018 at 09:26:11AM -0700, Francisco Jerez wrote:
>> "just like" here is possibly somewhat unfair to the schedutil governor,
>> admittedly its progressive IOWAIT boosting behavior seems somewhat less
>> wasteful than the intel_pstate non-HWP governor's IOWAIT boosting
>> behavior, but it's still largely unhelpful on IO-bound conditions.
>
> So you understand why we need the iowait boosting right?
>

Yeah, sort of.  The latency-minimizing state of this governor provides a
comparable effect, but it's based on a pessimistic estimate of the
frequency required for the workload to achieve maximum throughput
(rather than a plain or exponential boost up to the max frequency which
can substantially deviate from that frequency, see the explanation in
PATCH 6 for more details).  It's enabled under conditions partially
overlapping but not identical to iowait boosting: The optimization is
not applied under IO-bound conditions (in order to avoid impacting
energy efficiency negatively for zero or negative payoff), OTOH the
optimization is applied in some cases where the current governor
wouldn't, like RT-priority threads (that's the main difference with v2
I'm planning to send out next week).

> It is just that when we get back to runnable, we want to process the
> next data packet ASAP. See also here:
>
>   https://lkml.kernel.org/r/20170522082154.f57cqovterd2qajv@hirez.programming.kicks-ass.net
>
> What I don't really understand is why it is costing so much power; after
> all, when we're in iowait the CPU is mostly idle and can power-gate.

The reason for the energy efficiency problem of iowait boosting is
precisely the greater oscillation between turbo and idle.  Say that
iowait boost increases the frequency by a factor alpha relative to the
optimal frequency f0 (in terms of energy efficiency) required to execute
some IO-bound workload.  This will cause the CPU to be busy for a
fraction of the time it was busy originally, approximately t1 = t0 /
alpha, which indeed divides the overall energy usage by a factor alpha,
but at the same time multiplies the instantaneous power consumption
while busy by a factor potentially much greater than alpha, since the
CPU's power curve is largely non-linear, and in fact approximately
convex within the frequency range allowed by the policy, so you get an
average energy usage possibly much greater than the optimal.

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCWs+mzgAKCRCDmTidfVK/
WzTiAQCRD/2jlkNtwTsC98B6utAox3g3WvuAkoHMm0/rs93IrwD5AQ4WHiZLO7a3
d0sWwrtMQvHzzsabhyltvxqs5oRoA28=
=rpCs
-----END PGP SIGNATURE-----
--==-=-=--

--===============1320309746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============1320309746==--
