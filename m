From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/9] ARM: get rid of arch_cpu_idle_prepare()
Date: Mon, 27 Jan 2014 16:07:36 +0000
Message-ID: <20140127160736.GP15937@n2100.arm.linux.org.uk>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org> <1390802904-28399-2-git-send-email-nicolas.pitre@linaro.org> <52E6175F.1050401@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52E6175F.1050401@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 27, 2014 at 09:22:55AM +0100, Daniel Lezcano wrote:
> On 01/27/2014 07:08 AM, Nicolas Pitre wrote:
>> ARM and ARM64 are the only two architectures implementing
>> arch_cpu_idle_prepare() simply to call local_fiq_enable().
>>
>> We have secondary_start_kernel() already calling local_fiq_enable() and
>> this is done a second time in arch_cpu_idle_prepare() in that case. And
>> enabling FIQs has nothing to do with idling the CPU to start with.
>>
>> So let's introduce init_fiq_boot_cpu() to take care of FIQs on the boot
>> CPU and remove arch_cpu_idle_prepare(). This is now done a bit earlier
>> at late_initcall time but this shouldn't make a difference in practice
>> i.e. when FIQs are actually used.
>>
>> Signed-off-by: Nicolas Pitre <nico@linaro.org>
>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

What kind of review did you do when giving that attributation?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
