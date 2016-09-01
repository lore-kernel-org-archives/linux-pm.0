From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/4] cpu: expose pm_qos_resume_latency for each cpu
Date: Thu, 1 Sep 2016 11:26:15 +0200
Message-ID: <CAPDyKFra5YRUPB7a2th6K1hnK=PUz9k27d6DNNoVaJ76QSWe3w@mail.gmail.com>
References: <1472114562-2736-1-git-send-email-alex.shi@linaro.org>
 <1472114562-2736-2-git-send-email-alex.shi@linaro.org> <57C7A597.4050001@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38240 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752739AbcIAJ0R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Sep 2016 05:26:17 -0400
Received: by mail-wm0-f49.google.com with SMTP id 1so83716036wmz.1
        for <linux-pm@vger.kernel.org>; Thu, 01 Sep 2016 02:26:17 -0700 (PDT)
In-Reply-To: <57C7A597.4050001@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alex Shi <alex.shi@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On 1 September 2016 at 05:50, Alex Shi <alex.shi@linaro.org> wrote:
>
> Few commits and patch changed according to Greg's comments.
>
> Regards
> Alex
>
> ====
>
> From 186c534b0b8b9649fbfce05b0b4f90f764c571a4 Mon Sep 17 00:00:00 2001
> From: Alex Shi <alex.shi@linaro.org>
> Date: Tue, 16 Aug 2016 15:29:01 +0800
> Subject: [PATCH 2/4] cpu: expose pm_qos_resume_latency for each cpu
>
> Adding /sys/devices/system/cpu/cpux/power/pm_qos_resume_latency_us for
> each of cpus. The pm_qos_resume_latency usage defined in
> Documentation/ABI/testing/sysfs-devices-power
>
> The cpu-dma PM QoS constraint impacts all the cpus in the system. There
> is no way to let the user to choose a PM QoS constraint per cpu.
>
> The following patch exposes to the userspace a per cpu based sysfs file
> in order to let the userspace to change the value of the PM QoS latency
> constraint.
>
> This change is inoperative in its form and the cpuidle governors have to
> take into account the per cpu latency constraint in addition to the
> global cpu-dma latency constraint in order to operate properly.

In general I think the change makes sense, although it's this last
piece here that I wonder about.

Is it okay that we expose sysfs attributes to userspace that don't
have any effect if they change the values? Perhaps it should be the
responsibility of the menu governor somehow to expose the sysfs nodes
instead? Unless there are some difficulties that prevents us from that
of course.


Kind regards
Uffe

>
> Signed-off-by: Alex Shi <alex.shi@linaro.org>
> To: linux-kernel@vger.kernel.org
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/base/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 4c28e1a..2c3b359 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -17,6 +17,7 @@
>  #include <linux/of.h>
>  #include <linux/cpufeature.h>
>  #include <linux/tick.h>
> +#include <linux/pm_qos.h>
>
>  #include "base.h"
>
> @@ -376,6 +377,7 @@ int register_cpu(struct cpu *cpu, int num)
>
>         per_cpu(cpu_sys_devices, num) = &cpu->dev;
>         register_cpu_under_node(num, cpu_to_node(num));
> +       dev_pm_qos_expose_latency_limit(&cpu->dev, 0);
>
>         return 0;
>  }
> --
> 2.8.1.101.g72d917a
>
>
>
