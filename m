From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/4] cpu: expose pm_qos_resume_latency for each cpu
Date: Wed, 31 Aug 2016 15:18:29 +0200
Message-ID: <20160831131829.GB19101@kroah.com>
References: <1472114562-2736-1-git-send-email-alex.shi@linaro.org>
 <1472114562-2736-2-git-send-email-alex.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:37577 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760190AbcHaNSU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Aug 2016 09:18:20 -0400
Content-Disposition: inline
In-Reply-To: <1472114562-2736-2-git-send-email-alex.shi@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alex Shi <alex.shi@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Thu, Aug 25, 2016 at 04:42:40PM +0800, Alex Shi wrote:
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
> ---
>  drivers/base/cpu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 4c28e1a..ba11e23 100644
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
> @@ -376,6 +377,8 @@ int register_cpu(struct cpu *cpu, int num)
>  
>  	per_cpu(cpu_sys_devices, num) = &cpu->dev;
>  	register_cpu_under_node(num, cpu_to_node(num));
> +	if (dev_pm_qos_expose_latency_limit(&cpu->dev, 0))
> +		pr_debug("CPU%d: add resume latency failed\n", num);

Why is this a debug message?  And you have a struct device, why not use
it?

Also, what userspace changes does this require, or affect?  Any new
sysfs files?

thanks,

greg k-h
