From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: Cannot resume after entering WFI or suspend state
Date: Fri, 11 Nov 2016 14:41:01 +0000
Message-ID: <3c21a787-178f-9ef9-6c27-9296cb4533b9@arm.com>
References: <CAMGZvfKPcRbURwuuKtr_TTc1nsn4fUSc6tH6p26CK0ZHdOkkfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756014AbcKKOlE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Nov 2016 09:41:04 -0500
In-Reply-To: <CAMGZvfKPcRbURwuuKtr_TTc1nsn4fUSc6tH6p26CK0ZHdOkkfA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: amit mahadik <amitmaddy@gmail.com>, linux-pm@lists.linux-foundation.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Amit,

On 11/11/16 06:25, amit mahadik wrote:
> Hi, I am trying to understand  the Linux Power management Unit
> framework. I have an ARM Cortex-A9x4 board.

Is this platform upstreamed ? I mean can I look at all the code executed
in the suspend/resume path ?

> When I enable pm_test or pass initcall_debug parameter through U-boot
> via bootargs the system goes into (wfi/suspend state) and resumes
> properly. However, the issue is when I am not using pm_test and

I thought test_suspend=<x> was the command line for that. I don't see
any code parsing pm_test. Could be your local change ?

> initcall_debug and put my system into WFI/SUSPEND state , it does not
> resume even if the registered wakeup IRQ is generated.
>
That's strange an could be timing related.

> Following are my Queries/observations. 1. Reading the log I find that
> Linux Masks the non-wakeup interrupts. This code was not present in
> linux 3.4.14.

/me confused. You are using v3.4.* or v4.4.* kernel ? Why are you mixing
the reference here ?

> 2. I tried to disable IRQCHIP_MASK_ON_SUSPEND flag from irq_chip.
> Doing so the I was able to resume from wfi state only once.

Unless you understand your IRQ controller and it provide no way to set
the wake up irq and it's taken care elsewhere in the hardware, you
should retain that. Which irq driver is this ? again in upstream ?

> After that the system resumed immediately without any interrupt after
> putting it into wfi state. 3. I tried adding IRQF_NO_SUSPEND flag to
> the wakeup interrupt and also used enable_irq_wake() function but
> with no success.

IRQF_NO_SUSPEND is not meant to be used for wakeup purposes. Read the
documentation, it just makes sure, the interrup is not disabled when
suspending and doesn't guarantee anything around wakeup source.

> The system does not respond to any interrupts once in wfi/suspend
> state. 4. I have attached log messages file for reference.
>

It has a new parameter "suspend", so it must have own driver installing
pm_suspend_ops ? Is that upstream ?

You seem to have lot of custom code which is not in the mainline. It's
difficult to help you if we don't have all the necessary information on
your setup.

-- 
Regards,
Sudeep
