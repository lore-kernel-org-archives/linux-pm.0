From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFD PATCH 3/5] sched/cpufreq_schedutil: make worker kthread be
 SCHED_DEADLINE
Date: Mon, 27 Mar 2017 19:05:30 +0100
Message-ID: <20170327180530.2hhthml46o3ey56a@sirena.org.uk>
References: <20170324140900.7334-1-juri.lelli@arm.com>
 <20170324140900.7334-4-juri.lelli@arm.com>
 <20170327165011.dpip23cyolnleas6@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vfh5i47o46hgxcor"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:42988 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbdC0SGE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2017 14:06:04 -0400
Content-Disposition: inline
In-Reply-To: <20170327165011.dpip23cyolnleas6@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@arm.com>, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>


--vfh5i47o46hgxcor
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 27, 2017 at 06:50:11PM +0200, Peter Zijlstra wrote:

> Taken together this seems to suggest we can rework cpufreq drivers to
> function in-context, either directly push the packet on the bus if
> available, or queue it and let whoever owns it sort it without blocking.

Note that this isn't really cpufreq's problem per se, cpufreq is going
to work out what voltage it wants then tell the regulator API to do that
which will in turn go communicate with the PMIC somehow, typically with
regmap over I2C or SPI.  All those layers use mutexes by default.

> So if we can make all that work, we can do away with this horrible
> horrible kthread. Which is, IMO, a much better solution.

> Thoughts?

I think it's doable, but a lot of work especially in the regulator code.

--vfh5i47o46hgxcor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljZVGkACgkQJNaLcl1U
h9AVmwf/bwPFFXYQSLi0kTijf6+HO0CBPv162MkTMT4vpY1UXZ47IvCo/LZsD74i
bfJo62Wu3R+wq/79nEqkCKocexMP3RKop5CpjBuDindRrHFhpMXifaB64IX3MBIp
v6SoAiMC012pTbbO+jWet+P5hz/5JihNhUxlY0tRMlyriYtPRU3ynknrRJ8Gxme8
jECGK9g9l/coVAtUv3ahpU5fG9SKrK7xlyZmG0d4bPbQMoDl6ocuSCc+D48KyhvR
PUcLeIDmgdAtmZbOb3KFsJnBzr89u+/1KMvmRI0rxLPjGuE85zJ8q8coMM/qSlG2
TBJL3Jl47lbjcpjjxANcd6fhF8nuPQ==
=3oHq
-----END PGP SIGNATURE-----

--vfh5i47o46hgxcor--
