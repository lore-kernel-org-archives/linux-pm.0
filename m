From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpuidle/idle: move idle traces to cpuidle_enter_state
Date: Mon, 14 Jul 2014 22:07:16 +0200
Message-ID: <20140714200716.GQ9918@twins.programming.kicks-ass.net>
References: <1404293458-9799-1-git-send-email-sandeep.tripathy@linaro.org>
 <53B81D94.6000404@linaro.org>
 <1602555.3nqafCzk86@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uI9S8aIOhfZRGnE0"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37065 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756940AbaGNUHb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jul 2014 16:07:31 -0400
Content-Disposition: inline
In-Reply-To: <1602555.3nqafCzk86@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Sandeep Tripathy <sandeep.tripathy@linaro.org>, rostedt@goodmis.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org


--uI9S8aIOhfZRGnE0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2014 at 09:47:46PM +0200, Rafael J. Wysocki wrote:
> On Saturday, July 05, 2014 05:45:24 PM Daniel Lezcano wrote:
> > On 07/02/2014 11:30 AM, Sandeep Tripathy wrote:
> > >   idle_exit event is the first event after a core exits
> > > idle state.=20

This

> > > So this should be traced before local irq
> > > is ebabled.=20

does not follow, interrupt state does not correlate to events or not.

> > > Likewise idle_entry is the last event before
> > > a core enters idle state. This will ease visualising the
> > > cpu idle state from kernel traces.
> > >
> > > Signed-off-by: Sandeep Tripathy <sandeep.tripathy@linaro.org>
> >=20
> > Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>=20
> I'm going to take this for 3.17.
>=20
> Peter, will there be any problems with it if I take it?

don't think so, if there's anything, I'll fix it up.

> > > ---
> > >   drivers/cpuidle/cpuidle.c | 3 +++
> > >   kernel/sched/idle.c       | 4 ----
> > >   2 files changed, 3 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > > index 8236746..97680d0 100644
> > > --- a/drivers/cpuidle/cpuidle.c
> > > +++ b/drivers/cpuidle/cpuidle.c
> > > @@ -99,12 +99,15 @@ int cpuidle_enter_state(struct cpuidle_device *de=
v, struct cpuidle_driver *drv,
> > >   	ktime_t time_start, time_end;
> > >   	s64 diff;
> > >
> > > +	trace_cpu_idle_rcuidle(index, dev->cpu);
> > >   	time_start =3D ktime_get();
> > >
> > >   	entered_state =3D target_state->enter(dev, drv, index);
> > >
> > >   	time_end =3D ktime_get();
> > >
> > > +	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);

If someone were to instrument ktime_get() the changelog is obviously
fail. Now I appreciate that instrumenting the timing infrastructure
might be challenging .. :-)

And I suppose the 'assumption' is that the target_state->enter()
function does not entail 'tracing' ? Is it made sure that these
functions do not generate __mcount or other function tracer stubs etc. ?

--uI9S8aIOhfZRGnE0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTxDh0AAoJEHZH4aRLwOS6wCUQAKILnibMMXdiz2adZ6YJZ9Hc
7YyQy7dGcMnSVdhP0HnBYTgvaahS9G2yIvOkBG31VCfhQ+rtQTHgjJi5ip1Fbw7j
paIONTsruET3NIGNFiJfS4vNMkuVrG25mabEl4Aw2jndFKLkD8MSCZptYS9thKO8
s1D0YWynvE/Q9VtitHNp4nAAHQ4uOag4uM4UhlWSDpeVvqvz0BepXORtxwFf5r3+
mSNofQr/pimTIp6rOul+chsGkTvJ+bc3I92q2DfHCk9A0FzMn0yV6Pupj6JWOZ/x
wcdj0kA2InzCtIK/gP8YnFUozYbrzogQ85OPAtTV7w1YqtQZSgpZUmxVU+YoqiGw
Xi7PMoGyOKY6XA+iFUQ9O7oEcddbSAcDfNosjzXoJFAIokuHnHV8Rc2f8OxOYlO+
7IOUVTpBnqk/fqUAaGfJW/zUAl0Is/9k20nVhLddXhZnVk6zi5KY4WyVK5mN448a
pF3PJBPlY0InCXwbAlQwxm1vf8vOKwOWPCw7SOlWEjYAPJYce8ezQLMngIaerKkT
LgvTphlX3v2R4DnwosCNDjnN7pFXV1yI2SXCGc1bAPXnYH7wn36+u6Wax1bF4EDe
bZdyP4MKKp7ejkKs4l9uN65nUsa7sveugVB8EhQ7S5m0wjXc61OcfezU9lDDiLm0
zp8zBtnXF+jeinB3XXmV
=W7FZ
-----END PGP SIGNATURE-----

--uI9S8aIOhfZRGnE0--
