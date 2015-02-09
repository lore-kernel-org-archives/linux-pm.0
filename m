From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: Delays, clocks, timers, hrtimers, etc
Date: Mon, 9 Feb 2015 08:45:42 +0100
Message-ID: <83b8298aa6384cbda3650b9ce1b5c842@BN1AFFO11OLC003.protection.gbl>
References: <54C8E125.3070905@free.fr>
 <20150203120925.GM8656@n2100.arm.linux.org.uk> <54D509EC.7020708@free.fr>
 <20150206191419.GA8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150206191419.GA8656@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Mason <mpeg.blue@free.fr>
Cc: Mike Turquette <mturquette@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, cpufreq <cpufreq@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Soren Brinkmann <sorenb@xilinx.com>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

+ Soren

>> $ grep -rn ARM_GLOBAL_TIMER | grep -v SCHED_CLOCK
>> arch/arm/mach-vexpress/Kconfig:7:	select ARM_GLOBAL_TIMER
>> arch/arm/mach-bcm/Kconfig:87:	select ARM_GLOBAL_TIMER
>> arch/arm/mach-bcm/Kconfig:108:	select ARM_GLOBAL_TIMER
>> arch/arm/mach-rockchip/Kconfig:14:	select ARM_GLOBAL_TIMER
>> arch/arm/mach-sti/Kconfig:4:	select ARM_GLOBAL_TIMER
>> arch/arm/mach-zynq/Kconfig:6:	select ARM_GLOBAL_TIMER if !CPU_FREQ
>>
>> There are indeed a few users; also I wonder why mach-zynq enables
>> ARM_GLOBAL_TIMER only if !CPU_FREQ. (Could it be that they have
>> the CPU CLOCK driving PERIPHCLK?)
> 
> I'm afraid I don't know.

The reason is that cpu clock input and global timer clock input are not independent
that's why changing clock for cpu also affect global timer freq which is wrong.
It is caused by incorrect hw design.
Soren can give you more detail information if you need.

Thanks,
Michal
