From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH v4 1/2] ARM: avoid tracers in soft_restart
Date: Wed, 26 Feb 2014 16:18:36 -0800
Message-ID: <20140227001836.28695.76893@capellas-linux>
References: <1393441857-15472-1-git-send-email-sebastian.capella@linaro.org>
 <1393441857-15472-2-git-send-email-sebastian.capella@linaro.org>
 <20140226233744.GG21483@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140226233744.GG21483@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Robin Holt <robin.m.holt@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Quoting Russell King - ARM Linux (2014-02-26 15:37:44)
> On Wed, Feb 26, 2014 at 11:10:56AM -0800, Sebastian Capella wrote:
> > Use of tracers in local_irq_disable is causes recursive aborts when
> > called with irqs disabled and using a temporary stack (hibernation).
> > Replace local_irq_disable with raw_local_irq_disable instead to
> > avoid tracers.
> > 
> > Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Robin Holt <robin.m.holt@gmail.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  arch/arm/kernel/process.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> > index 92f7b15..f58b723 100644
> > --- a/arch/arm/kernel/process.c
> > +++ b/arch/arm/kernel/process.c
> > @@ -100,7 +100,7 @@ void soft_restart(unsigned long addr)
> >       u64 *stack = soft_restart_stack + ARRAY_SIZE(soft_restart_stack);
> >  
> >       /* Disable interrupts first */
> > -     local_irq_disable();
> > +     raw_local_irq_disable();
> >       local_fiq_disable();
> 
> Great, I'm happy with this now.  I assume that the plan is to submit this
> to my patch system when everyone's given their fill of acks?

Thanks Russell!

I'll look into how to send it to your patch system and wait for people
to respond.

Sebastian Capella
