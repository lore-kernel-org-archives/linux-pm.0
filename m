From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH RFC v1 1/3] ARM: Add irq disabled version of soft_restart.
Date: Mon, 24 Feb 2014 23:56:30 -0800
Message-ID: <530C4CAE.5000202@ti.com>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-2-git-send-email-sebastian.capella@linaro.org>
 <20140222102616.GG21483@n2100.arm.linux.org.uk>
 <20140224231345.10580.62916@capellas-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140224231345.10580.62916@capellas-linux>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Capella <sebastian.capella@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Robin Holt <holt@sgi.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 02/24/2014 03:13 PM, Sebastian Capella wrote:
> Quoting Russell King - ARM Linux (2014-02-22 02:26:17)
>> On Tue, Feb 18, 2014 at 05:52:07PM -0800, Sebastian Capella wrote:
>>> From: Russ Dill <Russ.Dill@ti.com>
>>>
>>> This adds the ability to run soft_restart with local_irq/fiq_disable
>>> already called. This is helpful for the hibernation code paths.
>>
>> I'd rather keep this simple.  There's no problem with calling soft_restart
>> with interrupts already disabled.  local_irq_disable()/local_fiq_disable()
>> there should be harmless.
> 
> Hi Russell,
> 
> I'm observing a data abort loop when I replace this call:
> 
> In the local_irq_disable, it ends up calling trace_hardirqs_off
> (CONFIG_TRACE_IRQFLAGS_SUPPORT is enabled), which calls
> trace_hardirqs_off_caller which checks lockdep_recursion in the
> current task, but we've switched to a temporary stack with the
> call_with_stack, and get_current is returning NULL.  This
> triggers a data abort, which calls trace_hardirqs_off
> again and so on.
> 
> Do you have any suggestions here?
> 
> Thanks,
> 
> Sebastian
> 

So the alternative is to have a version of the call that calls a special
no trace version of local_irq_disable()/local_fiq_disable(). Which would
be preferable? Having a noirq version of soft_restart seems much simpler
to me.
