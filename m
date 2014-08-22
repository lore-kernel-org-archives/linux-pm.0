From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 5/6] ARM: shmobile: Add CPU notifier for CPUIdle boot vector
Date: Fri, 22 Aug 2014 19:48:33 +0900
Message-ID: <CANqRtoR5aCLv9_Qnh5gzjd3-zZCnZGk95sO0sLc7FXR+-r5Kxw@mail.gmail.com>
References: <53DB6284.3090506@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:65341 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbaHVKse (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Aug 2014 06:48:34 -0400
In-Reply-To: <53DB6284.3090506@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: keita kobayashi <keita.kobayashi.ym@renesas.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi Kobayashi-san,

Thanks for your patches. About the use of CPU notifiers, please see my
question below:

On Fri, Aug 1, 2014 at 6:48 PM, keita kobayashi
<keita.kobayashi.ym@renesas.com> wrote:
> Add CPU notifiers for the shared mach-shmobile cpuidle code.
>
> Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
> ---
>  arch/arm/mach-shmobile/cpuidle.c |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
> index 19c0c98..1771dd3 100644
> --- a/arch/arm/mach-shmobile/cpuidle.c
> +++ b/arch/arm/mach-shmobile/cpuidle.c
> @@ -20,6 +20,27 @@
>  #include <asm/io.h>
>  #include "common.h"
>
> +static int shmobile_cpuidle_notifier_call(struct notifier_block *nfb,
> +                                         unsigned long action, void *hcpu)
> +{
> +       unsigned int cpu = (long)hcpu;
> +
> +       switch (action) {
> +       case CPU_ONLINE:
> +       case CPU_STARTING:
> +       case CPU_STARTING_FROZEN:
> +               /* For this particular CPU register CPUIdle boot vector */
> +               shmobile_smp_hook(cpu, virt_to_phys(cpu_resume), 0);
> +               break;
> +       };
> +
> +       return NOTIFY_OK;
> +}

In my earlier CPUIdle and reset vector sharing experiments it seemed
enough to install the reset vector with CPU notifier using CPU_ONLINE.

Can you please explain the reason why you also include CPU_STARTING
and CPU_STARTING_FROZEN above?

Thanks,

/ magnus
