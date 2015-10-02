From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] ARM: cpuidle: make cpuidle_ops interfaces ARM64
 compliant
Date: Fri, 2 Oct 2015 11:37:58 +0200
Message-ID: <560E5076.7020906@linaro.org>
References: <1443689933-28882-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1443689933-28882-2-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36453 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbbJBJiC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2015 05:38:02 -0400
Received: by wicgb1 with SMTP id gb1so24697170wic.1
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2015 02:38:00 -0700 (PDT)
In-Reply-To: <1443689933-28882-2-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Lina Iyer <lina.iyer@linaro.org>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Jisheng Zhang <jszhang@marvell.com>


Hi Lorenzo,


On 10/01/2015 10:58 AM, Lorenzo Pieralisi wrote:
> In preparation for sharing PSCI idle operations on ARM and ARM64,
> this patch refines the ARM cpuidle_ops interfaces so that the
> two arches can use the same interfaces seamlessly.
>
> Based-on-patch-by: Jisheng Zhang <jszhang@marvell.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Lina Iyer <lina.iyer@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   arch/arm/include/asm/cpuidle.h | 4 ++--
>   arch/arm/kernel/cpuidle.c      | 4 ++--
>   drivers/soc/qcom/spm.c         | 9 +++++++--
>   3 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cp=
uidle.h
> index 0f84249..ee36dd4 100644
> --- a/arch/arm/include/asm/cpuidle.h
> +++ b/arch/arm/include/asm/cpuidle.h
> @@ -30,8 +30,8 @@ static inline int arm_cpuidle_simple_enter(struct c=
puidle_device *dev,
>   struct device_node;
>
>   struct cpuidle_ops {
> -	int (*suspend)(int cpu, unsigned long arg);
> -	int (*init)(struct device_node *, int cpu);

I don't know the reason why the 'cpu_psci_cpu_init_idle' signature was=20
changed. It has before the same signature as this ops.

As in ARM, we can have more than one driver using the cpuidle_ops=20
infrastructure, removing the struct device_node * parameter will force=20
to add a call to of_get_cpu_node(cpu, NULL) in each driver with a call=20
to of_node_put (btw it is missing below in qcom_cpuidle_init), the=20
rollback labels and this will lead to duplicated code.

So why not change ARM64 signature instead ?

> +	int (*suspend)(unsigned long arg);
> +	int (*init)(unsigned int cpu);
>   };
>
>   struct of_cpuidle_method {
> diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
> index 318da33..a75b7ae 100644
> --- a/arch/arm/kernel/cpuidle.c
> +++ b/arch/arm/kernel/cpuidle.c
> @@ -56,7 +56,7 @@ int arm_cpuidle_suspend(int index)
>   	int cpu =3D smp_processor_id();
>
>   	if (cpuidle_ops[cpu].suspend)
> -		ret =3D cpuidle_ops[cpu].suspend(cpu, index);
> +		ret =3D cpuidle_ops[cpu].suspend(index);
>
>   	return ret;
>   }
> @@ -144,7 +144,7 @@ int __init arm_cpuidle_init(int cpu)
>
>   	ret =3D arm_cpuidle_read_ops(cpu_node, cpu);
>   	if (!ret && cpuidle_ops[cpu].init)
> -		ret =3D cpuidle_ops[cpu].init(cpu_node, cpu);
> +		ret =3D cpuidle_ops[cpu].init(cpu);
>
>   	of_node_put(cpu_node);
>
> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
> index b04b05a..8deaea0 100644
> --- a/drivers/soc/qcom/spm.c
> +++ b/drivers/soc/qcom/spm.c
> @@ -197,8 +197,9 @@ static int qcom_cpu_spc(int cpu)
>   	return ret;
>   }
>
> -static int qcom_idle_enter(int cpu, unsigned long index)
> +static int qcom_idle_enter(unsigned long index)
>   {
> +	int cpu =3D smp_processor_id();
>   	return per_cpu(qcom_idle_ops, cpu)[index](cpu);
>   }
>
> @@ -207,7 +208,7 @@ static const struct of_device_id qcom_idle_state_=
match[] __initconst =3D {
>   	{ },
>   };
>
> -static int __init qcom_cpuidle_init(struct device_node *cpu_node, in=
t cpu)
> +static int __init qcom_cpuidle_init(unsigned int cpu)
>   {
>   	const struct of_device_id *match_id;
>   	struct device_node *state_node;
> @@ -217,6 +218,10 @@ static int __init qcom_cpuidle_init(struct devic=
e_node *cpu_node, int cpu)
>   	idle_fn *fns;
>   	cpumask_t mask;
>   	bool use_scm_power_down =3D false;
> +	struct device_node *cpu_node =3D of_get_cpu_node(cpu, NULL);
> +
> +	if (!cpu_node)
> +		return -ENODEV;
>
>   	for (i =3D 0; ; i++) {
>   		state_node =3D of_parse_phandle(cpu_node, "cpu-idle-states", i);
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

