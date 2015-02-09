From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: Delays, clocks, timers, hrtimers, etc
Date: Mon, 09 Feb 2015 11:01:10 -0800
Message-ID: <54D903F6.3050608@codeaurora.org>
References: <54C8E125.3070905@free.fr>
 <e028a4eb604a491f4438557f4a1373ef@agner.ch> <54D52F84.9050600@free.fr>
 <266c7b1ff2d1a8ba0ae4866f4fb4eca5@agner.ch> <54D576B1.4000001@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <54D576B1.4000001@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mason <mpeg.blue@free.fr>, Stefan Agner <stefan@agner.ch>
Cc: Mark Rutland <mark.rutland@arm.com>, Linux PM <linux-pm@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, cpufreq <cpufreq@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 02/06/15 18:21, Mason wrote:
>
>
> config HAVE_ARM_TWD
>   bool
>   depends on SMP
>   select CLKSRC_OF if OF
>   help
>     This options enables support for the ARM timer and watchdog unit
>
> One problem I see is that HAVE_ARM_TWD depends on SMP...
>
> One of the systems I want to support is UP (single-core Cortex A9).
> Does that mean I should use an SMP kernel even for that system?
> Or is there a different subsystem for UP systems?

I don't see any problem with the TWD dropping the dependency on SMP. The
code should work the same on a UP configuration and if that's the only
timer you have that can deliver interrupts to your processor then it
would be required. You'd still need a clocksource though, which the TWD
doesn't provide.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
