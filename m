From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: Fwd: Cannot resume after entering WFI or suspend state
Date: Fri, 11 Nov 2016 16:07:06 +0000
Message-ID: <12fcdeb9-72d9-c67c-d26c-95b7c6e1053d@arm.com>
References: <CAMGZvfKPcRbURwuuKtr_TTc1nsn4fUSc6tH6p26CK0ZHdOkkfA@mail.gmail.com>
 <3c21a787-178f-9ef9-6c27-9296cb4533b9@arm.com>
 <CAMGZvfJkL9c1wi+2s+9eiJDH5VGtKN9ywB_y4reCTwU8ar49GQ@mail.gmail.com>
 <CAMGZvfLmZfddVAY9=_CYDzZZMepgxpbTKEAeaJv_bSpku5A6aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933797AbcKKQHJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Nov 2016 11:07:09 -0500
In-Reply-To: <CAMGZvfLmZfddVAY9=_CYDzZZMepgxpbTKEAeaJv_bSpku5A6aQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: amit mahadik <amitmaddy@gmail.com>, linux-pm@lists.linux-foundation.org
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>

Hi Amit,

You should not use html, please make sure you don't use it in future
when replying on the list. Also try to use some better email client
that doesn't spoil the formatting too much when responding(for me it
looks like you inserted >> manually which is not correct) and never top
post.

On 11/11/16 15:14, amit mahadik wrote:
> Hi Sudeep,
>                 Thanks for your reply.
>
> /*1. Is this platform upstreamed ? I mean can I look at all the code
> executed **in the suspend/resume path *?/
>
>  >>> No. This platform is not upstreamed. Earlier it had kernel version
> 3.4.14 running on it. I am in the process of porting new version
>      4.4.16 on it.
>

OK

> */2. I thought test_suspend=<x> was the command line for that. I don't
> see any code parsing pm_test. Could be your local change ?/*
>
>>>> I tried with test_suspend=mem and gave repeat parameter > 1. But the code is stuck
> after it executes custom power management           code. The same code
> PM code (in mach-xx/pm.c) file works for kernel 3.4.
>>>> If I enable PM debugging kernel option I get a sysfs entry.
> (/sys/power/pm_test). If I select parameter other than none, the kernel
>             code has checkpoints to resume the system. Like
> suspend_test(TEST_PLATFORM / TEST_CORE)
>

So you need to debug that yourself unless it's shared.


> */3. me confused. You are using v3.4.* or v4.4.* kernel ? Why are you
> mixing the reference here ?/*
> */
> /*
>>>> My platform had 3.4.14 kernel running on it. Thats why I am using it as my reference.The PM code is working fine on 3.4.14.
> */
> /*
> */4. Unless you understand your IRQ controller and it provide no way to
> set the wake up irq and it's taken care elsewhere in the       hardware,
> you should retain that. Which irq driver is this ? again in upstream ?/*
> */5. IRQF_NO_SUSPEND is not meant to be used for wakeup purposes. Read
> the documentation, it just makes sure, the interrupt     is not
>  disabled when suspending and doesn't guarantee anything around wakeup
> source./*
> */
> /*
>>>> I have retained the code. IRQ driver is GIC driver (drivers/irqchip/irq-gic.c). The wakeup irq mask is taken care in Hardware.
>       I have also used enable_wake_irq() function.
>

In that case, just retain that flag, GIC has no mechanism to set wake 
up. Also it's better if we mask non wakeup sources on suspend.

> */6. It has a new parameter "suspend", so it must have own driver
> installing pm_suspend_ops ? Is that upstream ?/*
> */
> /*
>>>> Yes suspend is a new parameter, having its own driver installing pm_suspend_ops. The code is not upstream.
>        My issue is that after giving suspend command (echo suspend >
> /sys/power/state) my code reaches my own driver and executes the
>        corresponding suspend code. However., the platform does not
> recognize my wakeup irq.
>

Is it enabled at the interrupt controller ? Is GIC also powered down in 
the suspend path ? If so, the power controller need to have logic to 
listen to your wakeup source. BTW what's your wakeup source ? Is it 
enabled ? You can check the sysfs entry.

-- 
Regards,
Sudeep
