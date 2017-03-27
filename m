From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFD PATCH 3/5] sched/cpufreq_schedutil: make worker kthread be
 SCHED_DEADLINE
Date: Mon, 27 Mar 2017 19:09:41 +0100
Message-ID: <20170327180941.3z7i5wurvsg3bmia@sirena.org.uk>
References: <20170324140900.7334-1-juri.lelli@arm.com>
 <37277532.TseFq3j8HT@aspire.rjw.lan>
 <20170327171336.GD10289@e106622-lin>
 <1721120.3Th1GMboUn@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n3qrdkprev6v37ix"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:43056 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbdC0SKP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2017 14:10:15 -0400
Content-Disposition: inline
In-Reply-To: <1721120.3Th1GMboUn@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Juri Lelli <juri.lelli@arm.com>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>


--n3qrdkprev6v37ix
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 27, 2017 at 07:37:39PM +0200, Rafael J. Wysocki wrote:

> One is that if we want *all* drivers to work with schedutil, we need to keep
> the kthread for the ones that will never be reworked (because nobody cares
> etc).  But then perhaps the kthread implementation may be left alone (because
> nobody cares etc).

A very large proportion of the affected code (at least once you get into
the realm of talking to the PMICs) is shared in core code in various
subsystems rather than in individual drivers so the problem might be
tractable.

--n3qrdkprev6v37ix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljZVWQACgkQJNaLcl1U
h9Bgxwf+JtePtCPPtO2T+mmuR99WfQuR0ymyCN44ZHwLinkJH0qLLbOkvYQ5N+eS
9V+oZMStOWGd6+ve4jlB3FW71AJmwNXoJr5nXD5wsKr3BHPfhxe00p8cUUDVXJn+
jF90dTdM5YXbXaxIivQe5oaneKtufvemQV1OJAgVaWGdk9SVjjJUcINWk/Eyh5ex
IkwpjxAubuh6vT2WK/sqEohWRA99NWDGl7nPDRcptS32wA4z4UIpI9YFsjM8E3SL
cza3iUqn/d+XK0Ggv6gg7Lj8TIuaW5vOo6RkFUft8Ac6IaI+Cm9fiyEN4rMl/pnp
fi/hmVQFDveweI0sb9sjspnUNu0F5Q==
=VLVF
-----END PGP SIGNATURE-----

--n3qrdkprev6v37ix--
