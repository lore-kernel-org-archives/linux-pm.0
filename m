From: Mason <mpeg.blue@free.fr>
Subject: Re: Delays, clocks, timers, hrtimers, etc
Date: Mon, 09 Feb 2015 15:27:39 -0800
Message-ID: <54D9426B.9030802@free.fr>
References: <54C8E125.3070905@free.fr> <20150203120925.GM8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20150203120925.GM8656@n2100.arm.linux.org.uk>
Sender: cpufreq-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, cpufreq <cpufreq@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Russell King - ARM Linux wrote:

> Mason wrote:
>  
>> Q1. the {n,u,m}delay function family
>>
>> [...]
>
> Timers are preferred because of the problems with the software delay loop.

Can you confirm that if one intends to use timer-based delays, one must
call register_current_timer_delay at init?

There aren't many callers of register_current_timer_delay.

   arch/arm/kernel/arch_timer.c:   register_current_timer_delay(&arch_delay_timer);
   arch/arm/mach-u300/timer.c:     register_current_timer_delay(&u300_delay_timer);
   drivers/clocksource/nomadik-mtu.c:      register_current_timer_delay(&mtu_delay_timer);

Does that mean that every other platform is using software delay-loops
instead of timer-based delay-loops?

(AFAIU, architected / generic timers are new-ish in Cortex A7 and A15.)

Regards.

