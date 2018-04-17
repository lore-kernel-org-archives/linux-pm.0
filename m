From: Francisco Jerez <currojerez@riseup.net>
Subject: Re: [PATCH 0/9] GPU-bound energy efficiency
 improvements for the intel_pstate driver.
Date: Tue, 17 Apr 2018 12:27:32 -0700
Message-ID: <87efjdy6or.fsf@riseup.net>
References: <20180328063845.4884-1-currojerez@riseup.net>
 <152397378196.27610.5253114574084892203@mail.alporthouse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0920693112=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <152397378196.27610.5253114574084892203@mail.alporthouse.com>
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

--===============0920693112==
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Chris,

Chris Wilson <chris@chris-wilson.co.uk> writes:

> I have to ask, if this is all just to work around iowait triggering high
> frequencies for GPU bound applications, does it all just boil down to
> i915 incorrectly using iowait. Does this patch set perform better than
>
> diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i=
915_request.c
> index 9ca9c24b4421..7e7c95411bcd 100644
> --- a/drivers/gpu/drm/i915/i915_request.c
> +++ b/drivers/gpu/drm/i915/i915_request.c
> @@ -1267,7 +1267,7 @@ long i915_request_wait(struct i915_request *rq,
>                         goto complete;
>                 }
>=20=20
> -               timeout =3D io_schedule_timeout(timeout);
> +               timeout =3D schedule_timeout(timeout);
>         } while (1);
>=20=20
>         GEM_BUG_ON(!intel_wait_has_seqno(&wait));
>
> Quite clearly the general framework could prove useful in a broader
> range of situations, but does the above suffice? (And can be backported
> to stable.)
> -Chris

Nope...  This hunk is one of the first things I tried when I started
looking into this.  It didn't cut it, and it seemed to lead to some
regressions in latency-bound test-cases that were relying on the upward
bias provided by IOWAIT boosting in combination with the upstream
P-state governor.

The reason why it's not sufficient is that the bulk of the energy
efficiency improvement from this series is obtained by dampening
high-frequency oscillations of the CPU P-state, which occur currently
for any periodically fluctuating workload (not only i915 rendering)
regardless of whether IOWAIT boosting kicks in.  i915 using IO waits
does exacerbate the problem with the upstream governor by amplifying the
oscillation, but it's not really the ultimate cause.

In combination with v2 (you can take a peek at the half-baked patch here
[1], planning to make a few more changes this week so it isn't quite
ready for review yet) this hunk will actually cause more serious
regressions because v2 is able to use the frequent IOWAIT stalls of the
i915 driver in combination with an IO-underutilized system as a strong
indication that the workload is latency-bound, which causes it to
transition to latency-minimizing mode, which significantly improves
performance of latency-bound rendering (most visible in a handful X11
test-cases and some GPU/CPU sync test-cases from SynMark2).

[1] https://people.freedesktop.org/~currojerez/intel_pstate-lp/0001-cpufreq=
-intel_pstate-Implement-variably-low-pass-fil-v1.8.patch

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCWtZKpAAKCRCDmTidfVK/
W0yMAPwOn08sLsKWyRD6a1nZnKl9sxKPvcYtojJGxUEEllLvnQD/UZXJHYiIoUEl
dx+wJpHyaD+tvKlE436Eew9zQybFOs8=
=Hrvw
-----END PGP SIGNATURE-----
--==-=-=--

--===============0920693112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============0920693112==--
