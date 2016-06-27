From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 2/3] intel_pstate: add __init/__initdata marker to
 some functions/variables
Date: Mon, 27 Jun 2016 10:26:57 -0700
Message-ID: <1467048417.8970.80.camel@linux.intel.com>
References: <1467022038-924-1-git-send-email-jszhang@marvell.com>
	 <1467022038-924-3-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30277 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749AbcF0RZ3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 Jun 2016 13:25:29 -0400
In-Reply-To: <1467022038-924-3-git-send-email-jszhang@marvell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>, lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2016-06-27 at 18:07 +0800, Jisheng Zhang wrote:
> These functions/variables are not needed after booting, so mark them
> as __init or __initdata.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> =C2=A0drivers/cpufreq/intel_pstate.c | 18 +++++++++---------
> =C2=A01 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 44099e9..861bcba 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1355,7 +1355,7 @@ static const struct x86_cpu_id
> intel_pstate_cpu_ids[] =3D {
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
> =C2=A0
> -static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] =3D {
> +static const struct x86_cpu_id intel_pstate_cpu_oob_ids[]
> __initconst =3D {
> =C2=A0	ICPU(0x56, core_params),
> =C2=A0	{}
> =C2=A0};
> @@ -1577,9 +1577,9 @@ static struct cpufreq_driver
> intel_pstate_driver =3D {
> =C2=A0static int no_load __initdata;
> =C2=A0static int no_hwp __initdata;
> =C2=A0static int hwp_only __initdata;
> -static unsigned int force_load;
> +static unsigned int force_load __initdata;
> =C2=A0
> -static int intel_pstate_msrs_not_valid(void)
> +static int __init intel_pstate_msrs_not_valid(void)
> =C2=A0{
> =C2=A0	if (!pstate_funcs.get_max() ||
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0!pstate_funcs.get_min() ||
> @@ -1589,7 +1589,7 @@ static int intel_pstate_msrs_not_valid(void)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static void copy_pid_params(struct pstate_adjust_policy *policy)
> +static void __init copy_pid_params(struct pstate_adjust_policy
> *policy)
> =C2=A0{
> =C2=A0	pid_params.sample_rate_ms =3D policy->sample_rate_ms;
> =C2=A0	pid_params.sample_rate_ns =3D pid_params.sample_rate_ms *
> NSEC_PER_MSEC;
> @@ -1600,7 +1600,7 @@ static void copy_pid_params(struct
> pstate_adjust_policy *policy)
> =C2=A0	pid_params.setpoint =3D policy->setpoint;
> =C2=A0}
> =C2=A0
> -static void copy_cpu_funcs(struct pstate_funcs *funcs)
> +static void __init copy_cpu_funcs(struct pstate_funcs *funcs)
> =C2=A0{
> =C2=A0	pstate_funcs.get_max=C2=A0=C2=A0=C2=A0=3D funcs->get_max;
> =C2=A0	pstate_funcs.get_max_physical =3D funcs->get_max_physical;
> @@ -1615,7 +1615,7 @@ static void copy_cpu_funcs(struct pstate_funcs
> *funcs)
> =C2=A0
> =C2=A0#ifdef CONFIG_ACPI
> =C2=A0
> -static bool intel_pstate_no_acpi_pss(void)
> +static bool __init intel_pstate_no_acpi_pss(void)
> =C2=A0{
> =C2=A0	int i;
> =C2=A0
> @@ -1644,7 +1644,7 @@ static bool intel_pstate_no_acpi_pss(void)
> =C2=A0	return true;
> =C2=A0}
> =C2=A0
> -static bool intel_pstate_has_acpi_ppc(void)
> +static bool __init intel_pstate_has_acpi_ppc(void)
> =C2=A0{
> =C2=A0	int i;
> =C2=A0
> @@ -1672,7 +1672,7 @@ struct hw_vendor_info {
> =C2=A0};
> =C2=A0
> =C2=A0/* Hardware vendor-specific info that has its own power managem=
ent
> modes */
> -static struct hw_vendor_info vendor_info[] =3D {
> +static struct hw_vendor_info vendor_info[] __initdata =3D {
> =C2=A0	{1, "HP=C2=A0=C2=A0=C2=A0=C2=A0", "ProLiant", PSS},
> =C2=A0	{1, "ORACLE", "X4-2=C2=A0=C2=A0=C2=A0=C2=A0", PPC},
> =C2=A0	{1, "ORACLE", "X4-2L=C2=A0=C2=A0=C2=A0", PPC},
> @@ -1691,7 +1691,7 @@ static struct hw_vendor_info vendor_info[] =3D =
{
> =C2=A0	{0, "", ""},
> =C2=A0};
> =C2=A0
> -static bool intel_pstate_platform_pwr_mgmt_exists(void)
> +static bool __init intel_pstate_platform_pwr_mgmt_exists(void)
> =C2=A0{
> =C2=A0	struct acpi_table_header hdr;
> =C2=A0	struct hw_vendor_info *v_info;
