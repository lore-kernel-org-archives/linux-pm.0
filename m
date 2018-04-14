From: Francisco Jerez <currojerez@riseup.net>
Subject: Re: [PATCH 0/9] GPU-bound energy efficiency
 improvements for the intel_pstate driver.
Date: Fri, 13 Apr 2018 18:57:39 -0700
Message-ID: <87d0z21re4.fsf@riseup.net>
References: <20180328063845.4884-1-currojerez@riseup.net>
 <87604ybssf.fsf@riseup.net> <1523416474.2700.2.camel@linux.intel.com>
 <87vacx7mh3.fsf@riseup.net> <87muy97lr0.fsf@riseup.net>
 <20180412085824.GX4082@hirez.programming.kicks-ass.net>
 <87r2nk46k1.fsf@riseup.net>
 <20180412193335.GA4330@worktop.programming.kicks-ass.net>
 <87a7u842tg.fsf@riseup.net>
 <20180413181537.GS4064@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1084453024=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20180413181537.GS4064@hirez.programming.kicks-ass.net>
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

--===============1084453024==
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, Apr 12, 2018 at 12:55:39PM -0700, Francisco Jerez wrote:
>> Actually assuming that a single geometric feature of the power curve is
>> known -- it being convex in the frequency range allowed by the policy
>> (which is almost always the case, not only for Intel CPUs), the optimal
>> frequency for an IO-bound workload is fully independent of the exact
>> power curve -- It's just the minimum CPU frequency that's able to keep
>> the bottlenecking IO device at 100% utilization.=20
>
> I think that is difficult to determine with the information at hand. We
> have lost all device information by the time we reach the scheduler.

I assume you mean it's difficult to tell whether the workload is
CPU-bound or IO-bound?  Yeah, it's non-trivial to determine whether the
system is bottlenecking on IO, it requires additional infrastructure to
keep track of IO utilization (that's the purpose of PATCH 1), and even
then it involves some heuristic assumptions which are not guaranteed
fail-proof, so the controller needs to be prepared for things to behave
reasonably when the assumptions deviate from reality (see the comments
in PATCH 6 for more details on what happens in such cases) -- How
frequently that happens in practice is what determines how far the
controller's response will be from the optimally energy-efficient
behavior in a real workload.  It seems to work fairly well in practice,
at least in the sample of test-cases I've been able to gather data from
so far.

Anyway that's the difficult part.  Once (if) you know you're IO-bound,
determining the optimal (most energy-efficient) CPU frequency is
relatively straightforward, and doesn't require knowledge of the exact
power curve of the CPU (beyond clamping the controller response to the
convexity region of the power curve).

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCWtFgEwAKCRCDmTidfVK/
Wy08AP9iRNHFgTeLITZwjR0uWOd6EPkn+VDSkFmJjgDWqKiOEAD5AafGsy7bqlD3
NZeQqhAnbWZQmua7z7A/Uc3k6lTkyzs=
=cTld
-----END PGP SIGNATURE-----
--==-=-=--

--===============1084453024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============1084453024==--
