From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v3 1/2] CPPC as a PID controller backend
Date: Mon, 15 Dec 2014 10:22:48 -0500
Message-ID: <CAJ5Y-eaJoJLTy29fy1LiL2NSfqR_yhjCpcym7uROK3cS=nSeUA@mail.gmail.com>
References: <1416429381-3839-1-git-send-email-ashwin.chaugule@linaro.org>
	<1416429381-3839-2-git-send-email-ashwin.chaugule@linaro.org>
	<6251973.kCIHGsD2QL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:47818 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbaLOPWu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Dec 2014 10:22:50 -0500
Received: by mail-wg0-f41.google.com with SMTP id y19so14855356wgg.14
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2014 07:22:48 -0800 (PST)
In-Reply-To: <6251973.kCIHGsD2QL@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "rwells@codeaurora.org" <rwells@codeaurora.org>, Linda Knippers <linda.knippers@hp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Dirk Brandewie <dirk.brandewie@gmail.com>, Patch Tracking <patches@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

Hi Rafael,

On 15 December 2014 at 10:21, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, November 19, 2014 03:36:20 PM Ashwin Chaugule wrote:
>>
>> +config ACPI_PID
>> +     bool "ACPI based PID controller"
>
> Sorry, but what sense does this make?  How's the user supposed to understand
> what the choice is about?
>
>> +     depends on PCC && !X86
>> +     help
>> +       The ACPI PID driver is an implementation of the CPPC (Collaborative
>> +       Processor Performance Controls) as defined in the ACPI 5.0+ spec. The
>
> OK, so this is a cpufreq driver based on ACPI CPPC and using a PID controller
> as a built-in governor, right?

Right. I'll elaborate the first line. :)

>
>> +       PID governor is derived from the intel_pstate driver and is used as a
>> +       standalone governor for CPPC. CPPC allows the OS to request CPU performance
>> +       with an abstract metric and lets the platform (e.g. BMC) interpret and
>> +       optimize it for power and performance in a platform specific manner. See
>> +       the ACPI 5.0+ specification for more details on CPPC.
>> +

[..]

>> +
>> +#include <linux/kernel.h>
>> +#include <linux/kernel_stat.h>
>> +#include <linux/module.h>
>> +#include <linux/ktime.h>
>> +#include <linux/hrtimer.h>
>> +#include <linux/tick.h>
>> +#include <linux/slab.h>
>> +#include <linux/sched.h>
>> +#include <linux/list.h>
>> +#include <linux/cpu.h>
>> +#include <linux/cpufreq.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/types.h>
>> +#include <linux/fs.h>
>> +#include <linux/debugfs.h>
>> +#include <linux/acpi.h>
>> +#include <linux/mailbox_controller.h>
>> +#include <linux/mailbox_client.h>
>> +#include <trace/events/power.h>
>
> Are all of the headers really necessary?  Doesn't the file compile without any of them?

Seems like I could remove some. I'll give it a try. Although I got
most of it from intel_pstate so assumed it would be required.

>> +static int cpc_read64(u64 *val, struct cpc_register_resource *reg)
>> +{
>> +     struct acpi_pcct_subspace *cppc_ss = pcc_channel->con_priv;
>> +     u64 addr = (u64)cppc_ss->base_address;
>> +     int err = 0;
>> +     int cmd;
>> +
>> +     switch (reg->space_id) {
>> +             case ACPI_ADR_SPACE_PLATFORM_COMM:
>> +                     {
>> +                             cmd = PCC_CMD_READ;
>> +                             err = mbox_send_message(pcc_channel, &cmd);
>> +                             if (err < 0) {
>> +                                     pr_err("Failed PCC READ: (%d)\n", err);
>> +                                     return err;
>> +                             }
>> +
>> +                             *val = readq((void *) (reg->address + addr));
>> +                     }
>> +                     break;
>> +
>> +             case ACPI_ADR_SPACE_FIXED_HARDWARE:
>> +                     break;
>> +
>> +             default:
>> +                     pr_err("Unknown space_id detected in cpc reg: %d\n", reg->space_id);
>> +                     err = -EINVAL;
>> +                     break;
>> +     }
>> +
>> +     return err;
>> +}
>> +
>> +static int cpc_write64(u64 val, struct cpc_register_resource *reg)
>> +{
>> +     struct acpi_pcct_subspace *cppc_ss = pcc_channel->con_priv;
>> +     u64 addr = (u64)cppc_ss->base_address;
>> +     int err = 0;
>> +     int cmd;
>> +
>> +     switch (reg->space_id) {
>> +             case ACPI_ADR_SPACE_PLATFORM_COMM:
>> +                     {
>> +                             writeq(val, (void *)(reg->address + addr));
>> +
>> +                             cmd = PCC_CMD_WRITE;
>> +                             err = mbox_send_message(pcc_channel, &cmd);
>> +                             if (err < 0) {
>> +                                     pr_err("Failed PCC WRITE: (%d)\n", err);
>> +                                     return err;
>> +                             }
>> +                     }
>> +                     break;
>> +
>> +             case ACPI_ADR_SPACE_FIXED_HARDWARE:
>> +                     break;
>> +
>> +             default:
>> +                     pr_err("Unknown space_id detected in cpc reg: %d\n", reg->space_id);
>> +                     err = -EINVAL;
>> +                     break;
>> +     }
>> +
>> +     return err;
>> +}
>
> There seems to be quite a lot of code duplication between the two functions
> above.  Any chance to combine them somehow?

Ok, I could fold them in one routine and add a new arg to take the PCC command.

Thanks,
Ashwin
