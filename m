From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 2/2] cpufreq: acpi-cpufreq: Drop pointless label from
 acpi_cpufreq_target()
Date: Thu, 25 Feb 2016 15:38:34 -0800
Message-ID: <1456443514.17628.26.camel@linux.intel.com>
References: <3419119.Zd6aAZrh1K@vostro.rjw.lan>
	 <1905248.5bkSJ3vszA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13100 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447AbcBYXkG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 25 Feb 2016 18:40:06 -0500
In-Reply-To: <1905248.5bkSJ3vszA@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

On Fri, 2016-02-26 at 00:03 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> The "out" label at the final return statement in
> acpi_cpufreq_target()
> is totally pointless, so drop them and modify the code to return the
> right values immediately instead of jumping to it.
>=20
> No functional changes.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/cpufreq/acpi-cpufreq.c |=C2=A0=C2=A0=C2=A0=C2=A06 ++---=
-
> =C2=A01 file changed, 2 insertions(+), 4 deletions(-)
>=20
> Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
> +++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
> @@ -434,7 +434,7 @@ static int acpi_cpufreq_target(struct cp
> =C2=A0		} else {
> =C2=A0			pr_debug("Already at target state (P%d)\n",
> =C2=A0				next_perf_state);
> -			goto out;
> +			return 0;
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> @@ -456,8 +456,7 @@ static int acpi_cpufreq_target(struct cp
> =C2=A0		cmd.val =3D (u32) perf-
> >states[next_perf_state].control;
> =C2=A0		break;
> =C2=A0	default:
> -		result =3D -ENODEV;
> -		goto out;
> +		return -ENODEV;
> =C2=A0	}
> =C2=A0
> =C2=A0	/* cpufreq holds the hotplug lock, so we are safe from here
> on */
> @@ -480,7 +479,6 @@ static int acpi_cpufreq_target(struct cp
> =C2=A0	if (!result)
> =C2=A0		perf->state =3D next_perf_state;
> =C2=A0
> -out:
> =C2=A0	return result;
> =C2=A0}
> =C2=A0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
