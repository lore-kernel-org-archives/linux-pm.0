From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 3/3] intel_pstate: Declare
 pid_params/pstate_funcs/hwp_active __read_mostly
Date: Mon, 27 Jun 2016 10:29:54 -0700
Message-ID: <1467048594.8970.81.camel@linux.intel.com>
References: <1467022038-924-1-git-send-email-jszhang@marvell.com>
	 <1467022038-924-4-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:47425 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966AbcF0R2Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 Jun 2016 13:28:25 -0400
In-Reply-To: <1467022038-924-4-git-send-email-jszhang@marvell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>, lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2016-06-27 at 18:07 +0800, Jisheng Zhang wrote:
> pid_params is written once by copy_pid_params() during
> initialization,
> and thereafter is mostly read by hot path intel_pstate_update_util().
> The read of pid_params gets more after commit a4675fbc4a7a ("cpufreq:
> intel_pstate: Replace timers with utilization update callbacks")
>=20
> pstate_funcs is written once by copy_cpu_funcs() during
> initialization,
> and thereafter is mostly read by hot path intel_pstate_update_util()
>=20
> hwp_active is written to once during initialization and thereafter is
> mostly read by hot path intel_pstate_update_util().
>=20
> The fact that they are mostly read and not written to makes them
> candidates for __read_mostly declarations.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> =C2=A0drivers/cpufreq/intel_pstate.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 861bcba..2eda50d 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -281,9 +281,9 @@ struct cpu_defaults {
> =C2=A0static inline int32_t get_target_pstate_use_performance(struct
> cpudata *cpu);
> =C2=A0static inline int32_t get_target_pstate_use_cpu_load(struct cpu=
data
> *cpu);
> =C2=A0
> -static struct pstate_adjust_policy pid_params;
> -static struct pstate_funcs pstate_funcs;
> -static int hwp_active;
> +static struct pstate_adjust_policy pid_params __read_mostly;
> +static struct pstate_funcs pstate_funcs __read_mostly;
> +static int hwp_active __read_mostly;
> =C2=A0
> =C2=A0#ifdef CONFIG_ACPI
> =C2=A0static bool acpi_ppc;
