From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 2/2] cpufreq: intel_pstate: Fix set_policy interface for
 no_turbo
Date: Tue, 07 Jun 2016 17:48:06 -0700
Message-ID: <1465346886.25099.6.camel@linux.intel.com>
References: <1465346333-3104-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1465346333-3104-2-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <CAJZ5v0gtBQbWn2HSr_LRn6cFhqARVv=ve07DE30_c2XwfFYS9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13758 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754041AbcFHAq2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Jun 2016 20:46:28 -0400
In-Reply-To: <CAJZ5v0gtBQbWn2HSr_LRn6cFhqARVv=ve07DE30_c2XwfFYS9A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, 2016-06-08 at 02:42 +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 8, 2016 at 2:38 AM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > When turbo is disabled, the set_policy interface is broken.
> > For example, when turbo is disabled and
> > cpuinfo.max =3D 2900000 (full max turbo frequency)
> > Setting the limits results in frequency less than settings:
> > Set 1000000 KHz results in 0700000 KHz
> > Set 1500000 KHz results in 1100000 KHz
> > Set 2000000 KHz results in=C2=A0=C2=A01500000 KHz
> >=20
> > This is because limits->max_perf fraction is calculated using max
> > turbo frequency as the reference, but when the max P-State is
> > capped in the function intel_pstate_get_min_max, the reference
> > is not the max turbo P-State. This results in reducing max
> > P-State.
> >=20
> > One option is to always use max turbo as reference for calculating
> > limits. But this will not be correct. By definition the
> > intel_pstate
> > sysfs limits, shows percentage of available performance. So when
> > BIOS has disabled turbo, the available performance is max non
> > turbo.
> > So the max_perf_pct should still show 100%.
> >=20
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> I guess we need this in -stable?
Yes.
>=20
> If so, all of them, or is there a specific starting point?
I think this is from (even in 3.10, it should have the same behavior
looking at the code).

Thanks,
Srinivas

>=20
> >=20
> > ---
> > =C2=A0drivers/cpufreq/intel_pstate.c | 10 ++++++++--
> > =C2=A01 file changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 724b905..2116666 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -1561,8 +1561,14 @@ static int intel_pstate_cpu_init(struct
> > cpufreq_policy *policy)
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* cpuinfo and defa=
ult policy values */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0policy->cpuinfo.min=
_freq =3D cpu->pstate.min_pstate * cpu-
> > >pstate.scaling;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0policy->cpuinfo.max_freq=
 =3D
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0cpu->pstate.turbo_pstate * cpu->pstate.scaling;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0update_turbo_state();
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (limits->turbo_disabl=
ed)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0policy->cpuinfo.max_freq =3D
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
cpu->pstate.max_pstate * cpu-
> > >pstate.scaling;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0policy->cpuinfo.max_freq =3D
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
cpu->pstate.turbo_pstate * cpu-
> > >pstate.scaling;
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0intel_pstate_init_a=
cpi_perf_limits(policy);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0policy->cpuinfo.tra=
nsition_latency =3D CPUFREQ_ETERNAL;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpumask_set_cpu(pol=
icy->cpu, policy->cpus);
> > --
