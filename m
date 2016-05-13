From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] intel_pstate: Simplify conditional in
 intel_pstate_set_policy()
Date: Thu, 12 May 2016 17:36:05 -0700
Message-ID: <1463099765.991.26.camel@linux.intel.com>
References: <3708662.2e5qAbF2Fs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:58862 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249AbcEMAgd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 12 May 2016 20:36:33 -0400
In-Reply-To: <3708662.2e5qAbF2Fs@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, 2016-05-12 at 00:46 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> One of the if () statements in intel_pstate_set_policy() causes
> another if () to be evaluated if the condition is true and it
> doesn't do anything else, so merge the two if () statements into
> one.
>=20
> No functional changes.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=C2=A0 =C2=A0 Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.=
intel.com>

> ---
> =C2=A0drivers/cpufreq/intel_pstate.c |=C2=A0=C2=A0=C2=A011 +++++-----=
-
> =C2=A01 file changed, 5 insertions(+), 6 deletions(-)
>=20
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -1449,12 +1449,11 @@ static int intel_pstate_set_policy(struc
> =C2=A0	intel_pstate_clear_update_util_hook(policy->cpu);
> =C2=A0
> =C2=A0	cpu =3D all_cpu_data[0];
> -	if (cpu->pstate.max_pstate_physical > cpu-
> >pstate.max_pstate) {
> -		if (policy->max < policy->cpuinfo.max_freq &&
> -		=C2=A0=C2=A0=C2=A0=C2=A0policy->max > cpu->pstate.max_pstate * cpu=
-
> >pstate.scaling) {
> -			pr_debug("policy->max > max non turbo
> frequency\n");
> -			policy->max =3D policy->cpuinfo.max_freq;
> -		}
> +	if (cpu->pstate.max_pstate_physical > cpu->pstate.max_pstate=20
> &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0policy->max < policy->cpuinfo.max_freq &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0policy->max > cpu->pstate.max_pstate * cpu-
> >pstate.scaling) {
> +		pr_debug("policy->max > max non turbo frequency\n");
> +		policy->max =3D policy->cpuinfo.max_freq;
> =C2=A0	}
> =C2=A0
> =C2=A0	if (policy->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE) {
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
