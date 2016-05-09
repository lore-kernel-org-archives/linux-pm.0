From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] intel_pstate: Clean up intel_pstate_get()
Date: Mon, 09 May 2016 12:22:56 -0700
Message-ID: <1462821776.27421.85.camel@linux.intel.com>
References: <6744251.0XRRsX0MUN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49482 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbcEITWD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 May 2016 15:22:03 -0400
In-Reply-To: <6744251.0XRRsX0MUN@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, 2016-05-07 at 02:24 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> intel_pstate_get() contains a local variable that's initialized but
> never used and it can be written in fewer lines of code, so clean
> it up.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/cpufreq/intel_pstate.c |=C2=A0=C2=A0=C2=A0=C2=A09 ++---=
----
> =C2=A01 file changed, 2 insertions(+), 7 deletions(-)
>=20
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -1390,14 +1390,9 @@ static int intel_pstate_init_cpu(unsigne
> =C2=A0
> =C2=A0static unsigned int intel_pstate_get(unsigned int cpu_num)
> =C2=A0{
> -	struct sample *sample;
> -	struct cpudata *cpu;
> +	struct cpudata *cpu =3D all_cpu_data[cpu_num];
> =C2=A0
> -	cpu =3D all_cpu_data[cpu_num];
> -	if (!cpu)
> -		return 0;
> -	sample =3D &cpu->sample;
> -	return get_avg_frequency(cpu);
> +	return cpu ? get_avg_frequency(cpu) : 0;
> =C2=A0}
> =C2=A0
> =C2=A0static void intel_pstate_set_update_util_hook(unsigned int cpu_=
num)
>=20
