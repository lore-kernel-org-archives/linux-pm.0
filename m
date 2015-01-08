From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] drivers: cpuidle: don't initialize big.LITTLE driver
 if MCPM is unavailable
Date: Thu, 08 Jan 2015 09:53:47 +0100
Message-ID: <54AE459B.8010703@linaro.org>
References: <1420698544-10277-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35681 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbbAHIxw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jan 2015 03:53:52 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so1779094wiv.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2015 00:53:51 -0800 (PST)
In-Reply-To: <1420698544-10277-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 01/08/2015 07:29 AM, Sudeep Holla wrote:
> If big.LITTLE driver is initialized even when MCPM is unavailable,
> we get the below warning the first time cpu tries to enter deeper
> C-states.

Can you elaborate why MCPM could be unavailable when the tc2 pm code=20
registers the mcpm platform ops before the cpuidle driver ?



> ------------[ cut here ]------------
> WARNING: CPU: 4 PID: 0 at kernel/arch/arm/common/mcpm_entry.c:130 mcp=
m_cpu_suspend+0x6d/0x74()
> Modules linked in:
> CPU: 4 PID: 0 Comm: swapper/4 Not tainted 3.19.0-rc3-00007-gaf5a2cb1a=
d5c-dirty #11
> Hardware name: ARM-Versatile Express
> [<c0013fa5>] (unwind_backtrace) from [<c001084d>] (show_stack+0x11/0x=
14)
> [<c001084d>] (show_stack) from [<c04fe7f1>] (dump_stack+0x6d/0x78)
> [<c04fe7f1>] (dump_stack) from [<c0020645>] (warn_slowpath_common+0x6=
9/0x90)
> [<c0020645>] (warn_slowpath_common) from [<c00206db>] (warn_slowpath_=
null+0x17/0x1c)
> [<c00206db>] (warn_slowpath_null) from [<c001cbdd>] (mcpm_cpu_suspend=
+0x6d/0x74)
> [<c001cbdd>] (mcpm_cpu_suspend) from [<c03c6919>] (bl_powerdown_finis=
her+0x21/0x24)
> [<c03c6919>] (bl_powerdown_finisher) from [<c001218d>] (cpu_suspend_a=
bort+0x1/0x14)
> [<c001218d>] (cpu_suspend_abort) from [<00000000>] (  (null))
> ---[ end trace d098e3fd00000008 ]---
>
> This patch fixes the issue by checking for the availability of MCPM
> before initializing the big.LITTLE cpuidle driver
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>   drivers/cpuidle/cpuidle-big_little.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/c=
puidle-big_little.c
> index e3e225fe6b45..40c34faffe59 100644
> --- a/drivers/cpuidle/cpuidle-big_little.c
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -182,6 +182,10 @@ static int __init bl_idle_init(void)
>   	 */
>   	if (!of_match_node(compatible_machine_match, root))
>   		return -ENODEV;
> +
> +	if (!mcpm_is_available())
> +		return -EUNATCH;
> +
>   	/*
>   	 * For now the differentiation between little and big cores
>   	 * is based on the part number. A7 cores are considered little
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

