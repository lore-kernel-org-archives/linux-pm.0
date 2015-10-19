From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 04/17] powerpc: mpic: use IRQCHIP_SKIP_SET_WAKE instead
 of redundant mpic_irq_set_wake
Date: Mon, 19 Oct 2015 12:46:09 -0500
Message-ID: <1445276769.5185.292.camel@freescale.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
	 <1442850433-5903-5-git-send-email-sudeep.holla@arm.com>
	 <1442981170.19102.322.camel@freescale.com> <562529EF.7050404@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <562529EF.7050404@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Hongtao Jia <hongtao.jia@freescale.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Wang Dongsheng-B40534 <Dongsheng.Wang@freescale.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 2015-10-19 at 18:35 +0100, Sudeep Holla wrote:
> Hi Ben,
> 
> On 23/09/15 05:06, Scott Wood wrote:
> > On Mon, 2015-09-21 at 16:47 +0100, Sudeep Holla wrote:
> > > mpic_irq_set_wake return -ENXIO for non FSL MPIC and sets 
> > > IRQF_NO_SUSPEND
> > > flag for FSL ones. enable_irq_wake already returns -ENXIO if irq_set_wak
> > > is not implemented. Also there's no need to set the IRQF_NO_SUSPEND flag
> > > as it doesn't guarantee wakeup for that interrupt.
> > > 
> > > This patch removes the redundant mpic_irq_set_wake and sets the
> > > IRQCHIP_SKIP_SET_WAKE for only FSL MPIC.
> > > 
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Paul Mackerras <paulus@samba.org>
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Cc: Scott Wood <scottwood@freescale.com>
> > > Cc: Hongtao Jia <hongtao.jia@freescale.com>
> > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > Cc: linuxppc-dev@lists.ozlabs.org
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >   arch/powerpc/sysdev/mpic.c | 23 ++++-------------------
> > >   1 file changed, 4 insertions(+), 19 deletions(-)
> > 
> > Acked-by: Scott Wood <scottwood@freescale.com>
> > 
> 
> Can you pick this up via your tree ?

OK.

-Scott
