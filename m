From: Francisco Jerez <currojerez@riseup.net>
Subject: Re: [PATCH 9/9] drm/i915/execlists: Report GPU
 rendering as IO activity to cpufreq.
Date: Wed, 28 Mar 2018 11:55:12 -0700
Message-ID: <87muysowrz.fsf@riseup.net>
References: <20180328063845.4884-1-currojerez@riseup.net>
 <20180328063845.4884-10-currojerez@riseup.net>
 <152222417278.10679.15949311520002257163@mail.alporthouse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0198040978=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <152222417278.10679.15949311520002257163@mail.alporthouse.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Chris Wilson <chris@chris-wilson.co.uk>, linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Eero Tamminen <eero.t.tamminen@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

--===============0198040978==
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chris,

Chris Wilson <chris@chris-wilson.co.uk> writes:

> Quoting Francisco Jerez (2018-03-28 07:38:45)
>> This allows cpufreq governors to realize when the system becomes
>> non-CPU-bound due to GPU rendering activity, which will cause the
>> intel_pstate LP controller to behave more conservatively: CPU energy
>> usage will be reduced when there isn't a good chance for system
>> performance to scale with CPU frequency.  This leaves additional TDP
>> budget available for the GPU to reach higher frequencies, which is
>> translated into an improvement in graphics performance to the extent
>> that the workload remains TDP-limited (Most non-trivial graphics
>> benchmarks out there improve significantly in TDP-constrained
>> platforms, see the cover letter for some numbers).  If the workload
>> isn't (anymore) TDP-limited performance should stay roughly constant,
>> but energy usage will be divided by a similar factor.
>
> And that's what I thought IPS was already meant to be achieving;
> intelligent distribution between different units...
>=20=20

I'm not aware of IPS ever being available on any small core systems.

>> The intel_pstate LP controller is only enabled on BXT+ small-core
>> platforms at this point, so this shouldn't have any effect on other
>> systems.
>
> Although that's probably only a feature for big core :)
>

Actually I wouldn't rule out it being useful on big core up front.  I've
been playing around with the idea of hooking up this same interface to
the EPP preference used by HWP, which would allow the HWP controller to
reduce energy usage in GPU-bound conditions, which could potentially
leave additional TDP headroom available for the GPU -- It's not uncommon
for graphics workloads to be TDP-limited even on big core, and while
non-TDP-limited (so neither IPS nor IBC will ever help you) that would
still allow them to optimize CPU energy usage for workloads that are
consistently GPU-bound (which would mean longer battery life while
gaming on a big-core laptop).

>> Signed-off-by: Francisco Jerez <currojerez@riseup.net>
>> ---
>>  drivers/gpu/drm/i915/intel_lrc.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>=20
>> diff --git a/drivers/gpu/drm/i915/intel_lrc.c b/drivers/gpu/drm/i915/int=
el_lrc.c
>> index 3a69b367e565..721f915115bd 100644
>> --- a/drivers/gpu/drm/i915/intel_lrc.c
>> +++ b/drivers/gpu/drm/i915/intel_lrc.c
>> @@ -132,6 +132,7 @@
>>   *
>>   */
>>  #include <linux/interrupt.h>
>> +#include <linux/cpufreq.h>
>>=20=20
>>  #include <drm/drmP.h>
>>  #include <drm/i915_drm.h>
>> @@ -379,11 +380,13 @@ execlists_context_schedule_in(struct i915_request =
*rq)
>>  {
>>         execlists_context_status_change(rq, INTEL_CONTEXT_SCHEDULE_IN);
>>         intel_engine_context_in(rq->engine);
>> +       cpufreq_io_active_begin();
>
> Since you only care about a binary value for GPU activity, we don't need
> to do this on each context, just between submitting the first request
> and the final completion, i.e. couple this to EXECLISTS_ACTIVE_USER.
>
> Haven't yet gone back to check how heavy io_active_begin/end are, but I
> trust you appreciate that this code is particularly latency sensitive.

The cpufreq_io_active_begin/end() interfaces are probably as lightweight
as they can be.  There's no locking involved.  In cases where there
already is an overlapping request, cpufreq_io_active_begin() and
cpufreq_io_active_end() should return without doing much more than an
atomic increment and an atomic cmpxchg respectively.

That said, it wouldn't hurt to call each of them once per sequence of
overlapping requests.  Do you want me to call them from
execlists_set/clear_active() themselves when bit =3D=3D EXECLISTS_ACTIVE_US=
ER,
or at each callsite of execlists_set/clear_active()? [possibly protected
with a check that execlists_is_active(EXECLISTS_ACTIVE_USER) wasn't
already the expected value]

> -Chris

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCWrvlEAAKCRCDmTidfVK/
W+3DAQCIjD4fxXcvjhWxCyBKZq0UwmR4hq+39QlojP9MVWRMKQD+LpxdyUfKGQ6n
adZWQ6ZyJ93x9I2HLlkDkkT8vfa3VHI=
=GBMB
-----END PGP SIGNATURE-----
--==-=-=--

--===============0198040978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============0198040978==--
