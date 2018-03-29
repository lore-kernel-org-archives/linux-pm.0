From: Francisco Jerez <currojerez@riseup.net>
Subject: Re: [PATCH 9/9] drm/i915/execlists: Report GPU
 rendering as IO activity to cpufreq.
Date: Wed, 28 Mar 2018 17:32:07 -0700
Message-ID: <874lkzpvqw.fsf@riseup.net>
References: <20180328063845.4884-1-currojerez@riseup.net>
 <20180328063845.4884-10-currojerez@riseup.net>
 <152222417278.10679.15949311520002257163@mail.alporthouse.com>
 <87muysowrz.fsf@riseup.net>
 <152226481977.10679.15243453393086412220@mail.alporthouse.com>
 <152227918019.10679.9470023556595388428@mail.alporthouse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0711365871=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <152227918019.10679.9470023556595388428@mail.alporthouse.com>
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

--===============0711365871==
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Chris Wilson <chris@chris-wilson.co.uk> writes:

> Quoting Chris Wilson (2018-03-28 20:20:19)
>> Quoting Francisco Jerez (2018-03-28 19:55:12)
>> > Hi Chris,
>> >=20
>> [snip]
>> > That said, it wouldn't hurt to call each of them once per sequence of
>> > overlapping requests.  Do you want me to call them from
>> > execlists_set/clear_active() themselves when bit =3D=3D EXECLISTS_ACTI=
VE_USER,
>> > or at each callsite of execlists_set/clear_active()? [possibly protect=
ed
>> > with a check that execlists_is_active(EXECLISTS_ACTIVE_USER) wasn't
>> > already the expected value]
>>=20
>> No, I was thinking of adding an execlists_start()/execlists_stop()
>> [naming suggestions welcome, begin/end?] where we could hook additional
>> bookkeeping into.
>
> Trying to call execlist_begin() once didn't pan out. It's easier to
> reuse for similar bookkeeping used in future patches if execlist_begin()
> (or whatever name suits best) at the start of each context.
>
> Something along the lines of:
>
> @@ -374,6 +374,19 @@ execlists_context_status_change(struct i915_request =
*rq, unsigned long status)
>                                    status, rq);
>  }
>=20=20
> +static inline void
> +execlists_begin(struct intel_engine_execlists *execlists,

I had started writing something along the same lines in my working tree
called execlists_active_user_begin/end -- Which name do you prefer?

> +               struct execlist_port *port)
> +{

What do you expect the port argument to be useful for?  Is it ever going
to be anything other than execlists->port?

> +       execlists_set_active_once(execlists, EXECLISTS_ACTIVE_USER);
> +}
> +
> +static inline void
> +execlists_end(struct intel_engine_execlists *execlists)
> +{
> +       execlists_clear_active(execlists, EXECLISTS_ACTIVE_USER);
> +}
> +
>  static inline void
>  execlists_context_schedule_in(struct i915_request *rq)
>  {
> @@ -710,7 +723,7 @@ static void execlists_dequeue(struct intel_engine_cs =
*engine)
>         spin_unlock_irq(&engine->timeline->lock);
>=20=20
>         if (submit) {
> -               execlists_set_active(execlists, EXECLISTS_ACTIVE_USER);
> +               execlists_begin(execlists, execlists->port);
>                 execlists_submit_ports(engine);
>         }
>=20=20
> @@ -741,7 +754,7 @@ execlists_cancel_port_requests(struct intel_engine_ex=
eclists * const execlists)
>                 port++;
>         }
>=20=20
> -       execlists_clear_active(execlists, EXECLISTS_ACTIVE_USER);

This line doesn't seem to exist in my working tree.  I guess it was just
added?

> +       execlists_end(execlists);
>  }
>=20=20
>  static void clear_gtiir(struct intel_engine_cs *engine)
> @@ -872,7 +885,7 @@ static void execlists_submission_tasklet(unsigned lon=
g data)
>  {
>         struct intel_engine_cs * const engine =3D (struct intel_engine_cs=
 *)data;
>         struct intel_engine_execlists * const execlists =3D &engine->exec=
lists;
> -       struct execlist_port * const port =3D execlists->port;
> +       struct execlist_port *port =3D execlists->port;
>         struct drm_i915_private *dev_priv =3D engine->i915;
>         bool fw =3D false;
>=20=20
> @@ -1010,9 +1023,19 @@ static void execlists_submission_tasklet(unsigned =
long data)
>=20=20
>                         GEM_BUG_ON(count =3D=3D 0);
>                         if (--count =3D=3D 0) {
> +                               /*
> +                                * On the final event corresponding to the
> +                                * submission of this context, we expect =
either
> +                                * an element-switch event or an completi=
on
> +                                * event (and on completion, the active-i=
dle
> +                                * marker). No more preemptions, lite-res=
tore
> +                                * or otherwise
> +                                */
>                                 GEM_BUG_ON(status & GEN8_CTX_STATUS_PREEM=
PTED);
>                                 GEM_BUG_ON(port_isset(&port[1]) &&
>                                            !(status & GEN8_CTX_STATUS_ELE=
MENT_SWITCH));
> +                               GEM_BUG_ON(!port_isset(&port[1]) &&
> +                                          !(status & GEN8_CTX_STATUS_ACT=
IVE_IDLE));
>                                 GEM_BUG_ON(!i915_request_completed(rq));
>                                 execlists_context_schedule_out(rq);
>                                 trace_i915_request_out(rq);
> @@ -1021,17 +1044,14 @@ static void execlists_submission_tasklet(unsigned=
 long data)
>                                 GEM_TRACE("%s completed ctx=3D%d\n",
>                                           engine->name, port->context_id);
>=20=20
> -                               execlists_port_complete(execlists, port);
> +                               port =3D execlists_port_complete(execlist=
s, port);
> +                               if (port_isset(port))
> +                                       execlists_begin(execlists, port);

Isn't this going to call execlists_begin() roughly once per request?
What's the purpose if we expect it to be a no-op except for the first
request submitted after execlists_end()?  Isn't the intention to provide
a hook for bookkeeping that depends on idle to active and active to idle
transitions of the hardware?

> +                               else
> +                                       execlists_end(execlists);
>                         } else {
>                                 port_set(port, port_pack(rq, count));
>                         }
>

Isn't there an "execlists_clear_active(execlists,
EXECLISTS_ACTIVE_USER);" call in your tree a few lines below that is now
redundant?

> -Chris

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCWrw0CAAKCRCDmTidfVK/
W4AsAP9rZDfoYOQ3T5JXXO+NEUkLgVGEiN1FRxhxWd7geIj9NwEAlWCd8pWMyfss
Zn1Si9XdvzZBWfSJhiSLjZ3PAAqk5wQ=
=5fOZ
-----END PGP SIGNATURE-----
--==-=-=--

--===============0711365871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============0711365871==--
