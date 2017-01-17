From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 2/3] cpu: expose pm_qos_resume_latency for each cpu
Date: Tue, 17 Jan 2017 11:23:30 +0100
Message-ID: <20170117102330.GB2085@mai>
References: <1484227624-6740-1-git-send-email-alex.shi@linaro.org>
 <1484227624-6740-3-git-send-email-alex.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38533 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdAQKaF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jan 2017 05:30:05 -0500
Received: by mail-wm0-f47.google.com with SMTP id r144so215471463wme.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Jan 2017 02:30:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1484227624-6740-3-git-send-email-alex.shi@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alex Shi <alex.shi@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, vincent.guittot@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On Thu, Jan 12, 2017 at 09:27:03PM +0800, Alex Shi wrote:
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
> 
> BTW
> The pm_qos_resume_latency usage defined in
> Documentation/ABI/testing/sysfs-devices-power
> The /sys/devices/.../power/pm_qos_resume_latency_us attribute
> contains the PM QoS resume latency limit for the given device,
> which is the maximum allowed time it can take to resume the
> device, after it has been suspended at run time, from a resume
> request to the moment the device will be ready to process I/O,
> in microseconds.  If it is equal to 0, however, this means that
> the PM QoS resume latency may be arbitrary.
> 
> Signed-off-by: Alex Shi <alex.shi@linaro.org>
> To: linux-kernel@vger.kernel.org
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
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
>  	per_cpu(cpu_sys_devices, num) = &cpu->dev;
>  	register_cpu_under_node(num, cpu_to_node(num));
> +	dev_pm_qos_expose_latency_limit(&cpu->dev, 0);

This patch should be submitted as the last patch in the latencies constraint
changes patchset IMO. It is pointless to provide an interface before a
feature which is still under discussion.


-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
