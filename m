Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA16D4EFFB2;
	Thu,  8 Oct 2026 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791483454; cv=none; b=spKi9sSNXve2VMTHflYgPrYPLOrIW17nRDOofLh4WsIgf56yMPY/Ug0EnOPAyoCUkaTBoOPtwUybaFCYwKEwyv8JDNDNl+Ke0oQBPFUf268AgkUKGgtrNxu66a/vcC9CViYtGV2G2qfvLOjfJHsMAYcmcJ8C92BPWMEUrJnLFKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791483454; c=relaxed/simple;
	bh=6zs+OKqrv7uadt1H4w3dz/EQ5ag/BH++/P0GK2ILnsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgPhXFaiDtZCRhHTDGqpjgUsgYZ899Jccoh8GeiPkC0CZ1x/Glf0yh54pRqxxei73LQ1LRkf81I71V4j62hT2sSHVdWH6CS3Vlj1rJJtUT8++kOrlvX+SnWcTAKFxS1gyxABBN4z1gzcXRaypXLxPbYQKew+UQ+0YCGphieDBKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mEfeFjh9; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mEfeFjh9"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 680F11477;
	Thu,  8 Oct 2026 11:17:25 -0700 (PDT)
Received: from [10.57.87.21] (unknown [10.57.87.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D95EF3F66F;
	Thu,  8 Oct 2026 11:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791483448; bh=6zs+OKqrv7uadt1H4w3dz/EQ5ag/BH++/P0GK2ILnsg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mEfeFjh9eTZisgbCLMXsSQCoGmj0IseZLbAcIGoM8E5FiFuR6yhgmVjmadtSCk/xu
	 iWBVO8i6XcX+Uc3PJQAq5LCwlKDOIwYQvbqRxjA/fpl8ifdeYKTFQZqG/GIwOY3y9k
	 jeRJZaasGpskuGpLY2YXxWpE7+OTPmXadaYZARBE=
Message-ID: <e18bd763-0d6d-4bfd-b59e-78f952c94aa2@arm.com>
Date: Thu, 8 Oct 2026 19:17:25 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: Add the shallow governors
To: Roman Kagan <rkagan@amazon.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, nh-open-source@amazon.com
References: <20261008-b4-cpuidle-shallow-v1-1-c19e71127b14@amazon.de>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20261008-b4-cpuidle-shallow-v1-1-c19e71127b14@amazon.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/26 19:06, Roman Kagan wrote:
> The idle states offered by a platform trade wakeup latency for energy
> savings, and there are situations where the trade is not worth making:
> while a latency-sensitive workload is running, or during a live update
> via kexec, where everything from the outgoing kernel stopping the
> workload to the incoming kernel resuming it is downtime, and deep idle
> states may lengthen it.
> 
> The mechanisms currently available for that are all one-way.
> cpuidle.off=1, idle=poll and idle=halt can only be requested in the
> kernel command line and cannot be undone, and the PM QoS interfaces
> (/dev/cpu_dma_latency and the per-CPU pm_qos_resume_latency_us
> attribute) can only be used once user space is up, so they cannot cover
> the boot of the incoming kernel.

You can also disable all but the shallowest idle state in sysfs:
echo 1 > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable

> 
> Add governors that keep the CPUs in the shallowest idle states and leave
> the scheduler tick running.  Being governors, they can be selected both
> at run time, by writing a name to the current_governor attribute in
> sysfs, and in the kernel command line, via cpuidle.governor=.  For a
> live update, that makes it possible to switch the outgoing kernel to one
> of them before the kexec, pass the same governor to the incoming kernel
> so that it is in effect from the very beginning of its boot, and switch
> to an energy-efficient governor once the post-update work is done.
> 
> On x86 and on some powerpc platforms, the shallowest idle state is a
> polling loop.  It has the lowest wakeup latency, but also the side
> effects documented for idle=poll: the CPU saves almost no energy,
> competes with its SMT sibling for the core, and on Intel hardware keeps
> the package from using the P-states that require some of its CPUs to be
> idle.  Whether that is acceptable is a policy decision, so there are two
> governors and the user makes it by choosing between them.  The shallow
> governor always selects the shallowest enabled state.  The
> shallow_nopoll one skips polling states, unless the state it would
> select is too slow to leave for the PM QoS latency limit or all of the
> non-polling states are disabled.
> 
> A governor named in the kernel command line is not replaced by a
> higher-rated one registering later, so cpuidle.governor= holds for the
> entire boot.  Both governors have rating 1, below all of the other
> governors, so that neither is picked by default.  Where the cpuidle
> driver registers no polling states, such as on arm64, the two select the
> same states, and neither is a substitute for idle=poll.
> 
> Assisted-by: LLM
> Signed-off-by: Roman Kagan <rkagan@amazon.de>
> ---
>  drivers/cpuidle/governors/Makefile       |   1 +
>  drivers/cpuidle/governors/shallow.c      | 104 +++++++++++++++++++++++++++++++
>  Documentation/admin-guide/pm/cpuidle.rst |  53 +++++++++++++---
>  drivers/cpuidle/Kconfig                  |  20 ++++++
>  4 files changed, 169 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/Makefile b/drivers/cpuidle/governors/Makefile
> index 63abb5393a4d..10e64092c9ec 100644
> --- a/drivers/cpuidle/governors/Makefile
> +++ b/drivers/cpuidle/governors/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_CPU_IDLE_GOV_LADDER) += ladder.o
>  obj-$(CONFIG_CPU_IDLE_GOV_MENU) += menu.o
>  obj-$(CONFIG_CPU_IDLE_GOV_TEO) += teo.o
>  obj-$(CONFIG_CPU_IDLE_GOV_HALTPOLL) += haltpoll.o
> +obj-$(CONFIG_CPU_IDLE_GOV_SHALLOW) += shallow.o
> diff --git a/drivers/cpuidle/governors/shallow.c b/drivers/cpuidle/governors/shallow.c
> new file mode 100644
> index 000000000000..8d4ac46d302a
> --- /dev/null
> +++ b/drivers/cpuidle/governors/shallow.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * shallow.c - the shallow and shallow_nopoll idle governors
> + *
> + * Always select the shallowest enabled idle state, trading idle energy
> + * savings for the lowest wakeup latency the platform can offer.  The
> + * shallow_nopoll one skips polling states unless PM QoS requires them.
> + */
> +
> +#include <linux/cpuidle.h>
> +#include <linux/init.h>
> +
> +/**
> + * shallow_select - select the shallowest enabled idle state
> + * @drv: cpuidle driver containing state data
> + * @dev: the CPU
> + * @stop_tick: indication on whether or not to stop the tick
> + *
> + * The state selected here is the least energy-efficient one offered by the
> + * driver, so there is no point in looking at either the timer events or the
> + * PM QoS latency limits: no constraint can justify going shallower than that.
> + * Leave the tick running, as the CPU is not expected to stay idle for long.
> + *
> + * Return: the index of the first idle state not disabled for @dev, or 0 if
> + * all of them are disabled.
> + */
> +static int shallow_select(struct cpuidle_driver *drv,
> +			  struct cpuidle_device *dev, bool *stop_tick)
> +{
> +	int i;
> +
> +	*stop_tick = false;
> +
> +	/*
> +	 * cpuidle_enter_state() does not check whether the state it is asked
> +	 * to enter has been disabled, so the per-state "disable" attributes
> +	 * need to be honoured here.  If all of the states are disabled, fall
> +	 * back to the first one, like the other governors do.
> +	 */
> +	for (i = 0; i < drv->state_count; i++)
> +		if (!dev->states_usage[i].disable)
> +			return i;
> +
> +	return 0;
> +}
> +
> +/**
> + * shallow_nopoll_select - select the shallowest enabled non-polling idle state
> + * @drv: cpuidle driver containing state data
> + * @dev: the CPU
> + * @stop_tick: indication on whether or not to stop the tick
> + *
> + * Same as shallow_select(), but skip the polling states.  Unlike them, the
> + * shallowest non-polling state may take longer to leave than the PM QoS
> + * latency limit allows, so fall back to shallow_select() in that case, as
> + * well as when all of the non-polling states are disabled.
> + *
> + * Return: the index of the first idle state that is neither disabled for @dev
> + * nor a polling one, or what shallow_select() returns in the cases above.
> + */
> +static int shallow_nopoll_select(struct cpuidle_driver *drv,
> +				 struct cpuidle_device *dev, bool *stop_tick)
> +{
> +	int i;
> +
> +	for (i = 0; i < drv->state_count; i++) {
> +		if (dev->states_usage[i].disable ||
> +		    (drv->states[i].flags & CPUIDLE_FLAG_POLLING))
> +			continue;
> +
> +		if (drv->states[i].exit_latency_ns >
> +		    cpuidle_governor_latency_req(dev->cpu))
> +			break;
> +
> +		*stop_tick = false;
> +		return i;
> +	}
> +
> +	return shallow_select(drv, dev, stop_tick);
> +}
> +
> +static struct cpuidle_governor shallow_governor = {
> +	.name =		"shallow",
> +	.rating =	1,
> +	.select =	shallow_select,
> +};
> +
> +static struct cpuidle_governor shallow_nopoll_governor = {
> +	.name =		"shallow_nopoll",
> +	.rating =	1,
> +	.select =	shallow_nopoll_select,
> +};
> +
> +static int __init init_shallow(void)
> +{
> +	int ret = cpuidle_register_governor(&shallow_governor);
> +
> +	if (ret)
> +		return ret;
> +
> +	return cpuidle_register_governor(&shallow_nopoll_governor);
> +}
> +
> +postcore_initcall(init_shallow);
> diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
> index be4c1120e3f0..8c6a438936d4 100644
> --- a/Documentation/admin-guide/pm/cpuidle.rst
> +++ b/Documentation/admin-guide/pm/cpuidle.rst
> @@ -159,15 +159,16 @@ governor uses that information depends on what algorithm is implemented by it
>  and that is the primary reason for having more than one governor in the
>  ``CPUIdle`` subsystem.
>  
> -There are four ``CPUIdle`` governors available, ``menu``, `TEO <teo-gov_>`_,
> -``ladder`` and ``haltpoll``.  Which of them is used by default depends on the
> -configuration of the kernel and in particular on whether or not the scheduler
> -tick can be `stopped by the idle loop <idle-cpus-and-tick_>`_.  Available
> -governors can be read from the :file:`available_governors`, and the governor
> -can be changed at runtime.  The name of the ``CPUIdle`` governor currently
> -used by the kernel can be read from the :file:`current_governor_ro` or
> -:file:`current_governor` file under :file:`/sys/devices/system/cpu/cpuidle/`
> -in ``sysfs``.
> +There are six ``CPUIdle`` governors available, ``menu``, `TEO <teo-gov_>`_,
> +``ladder``, ``haltpoll``, `shallow <shallow-gov_>`_ and
> +`shallow_nopoll <shallow-gov_>`_.  Which of them is used by default depends on
> +the configuration of the kernel and in particular on whether or not the
> +scheduler tick can be `stopped by the idle loop <idle-cpus-and-tick_>`_.
> +Available governors can be read from the
> +:file:`available_governors`, and the governor can be changed at runtime.  The
> +name of the ``CPUIdle`` governor currently used by the kernel can be read from
> +the :file:`current_governor_ro` or :file:`current_governor` file under
> +:file:`/sys/devices/system/cpu/cpuidle/` in ``sysfs``.
>  
>  Which ``CPUIdle`` driver is used, on the other hand, usually depends on the
>  platform the kernel is running on, but there are platforms with more than one
> @@ -345,6 +346,40 @@ given conditions.  However, it applies a different approach to that problem.
>  .. kernel-doc:: drivers/cpuidle/governors/teo.c
>     :doc: teo-description
>  
> +.. _shallow-gov:
> +
> +The Shallow Governors
> +=====================
> +
> +The ``shallow`` governor always selects the shallowest enabled idle state and
> +leaves the scheduler tick running.  Unlike the governors described above, it
> +makes no attempt to save energy at all; its purpose is to keep the CPU wakeup
> +latency, and in particular the latency of inter-processor interrupts, at the
> +minimum offered by the platform.
> +
> +The ``shallow_nopoll`` governor does the same, except that it skips polling
> +idle states and selects the shallowest enabled idle state that is not a polling
> +one.  That avoids the side effects of idle CPUs spinning, which are described
> +for ``idle=poll`` below, at the cost of a higher wakeup latency.  If the exit
> +latency of that state is above the `PM QoS <cpu-pm-qos_>`_ limit in effect for
> +the CPU, or if all of the non-polling states are disabled, ``shallow_nopoll``
> +selects the state that ``shallow`` would select.
> +
> +Neither of them is used by default, regardless of the configuration of the
> +kernel, and they have to be requested explicitly.  That can be done either by
> +passing ``cpuidle.governor=shallow`` or ``cpuidle.governor=shallow_nopoll`` in
> +the kernel command line, or by writing the governor name to the
> +:file:`current_governor` file described `above <idle-loop_>`_.  A governor
> +requested in the kernel command line is not replaced by a higher-rated one
> +registering later, so it holds for the entire boot and user space can hand the
> +deep idle states back at any later point by switching to a different governor.
> +
> +Note that the shallowest idle state is not necessarily a polling loop.  On the
> +platforms whose ``CPUIdle`` driver does not register the generic polling state,
> +it is the idle instruction of the CPU architecture (for instance, ``WFI`` on
> +arm64), so ``shallow`` is not a substitute for ``idle=poll``.  If the driver
> +registers no polling states at all, the two governors select the same states.
> +
>  .. _idle-states-representation:
>  
>  Representation of Idle States
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index 00e2562041fd..c78aa07ca548 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -44,6 +44,26 @@ config CPU_IDLE_GOV_HALTPOLL
>  
>  	  Some virtualized workloads benefit from using it.
>  
> +config CPU_IDLE_GOV_SHALLOW
> +	bool "Shallow governors (for latency-sensitive systems)"
> +	help
> +	  The shallow governor always selects the shallowest enabled idle
> +	  state, which keeps the CPU wakeup latency at the minimum offered by
> +	  the platform at the cost of giving up idle energy savings.  The
> +	  shallow_nopoll governor selects the shallowest enabled idle state
> +	  that is not a polling one instead, unless PM QoS requires a lower
> +	  latency than that state offers.
> +
> +	  They are never used by default and have to be requested explicitly,
> +	  either by passing cpuidle.governor=shallow or
> +	  cpuidle.governor=shallow_nopoll in the kernel command line, or by
> +	  writing the governor name to the current_governor attribute in
> +	  sysfs.  That makes it possible to keep the CPUs out of deep idle
> +	  states while booting or while running a latency-sensitive workload
> +	  and to switch to an energy-efficient governor afterwards.
> +
> +	  If unsure, say N.
> +
>  config DT_IDLE_STATES
>  	bool
>  
> 
> ---
> base-commit: 08df884136f1c1197bab2a27814404fd329d9aac
> change-id: 20261007-b4-cpuidle-shallow-a4d6190bc8b1
> 
> Best regards,
> --  
> Roman Kagan <rkagan@amazon.de>
> 
> 

