From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC V2 PATCH 2/6] powerpc: Implement broadcast timer interrupt
 as an IPI message
Date: Thu, 22 Aug 2013 13:10:57 +1000
Message-ID: <1377141057.25016.265.camel@pasglop>
References: <20130814115311.5193.32212.stgit@preeti.in.ibm.com>
	 <20130814115602.5193.60835.stgit@preeti.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:40994 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031Ab3HVDMp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 21 Aug 2013 23:12:45 -0400
In-Reply-To: <20130814115602.5193.60835.stgit@preeti.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: fweisbec@gmail.com, paul.gortmaker@windriver.com, paulus@samba.org, shangw@linux.vnet.ibm.com, galak@kernel.crashing.org, deepthi@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com, arnd@arndb.de, linux-pm@vger.kernel.org, rostedt@goodmis.org, rjw@sisk.pl, john.stultz@linaro.org, tglx@linutronix.de, chenhui.zhao@freescale.com, michael@ellerman.id.au, r58472@freescale.com, geoff@infradead.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, schwidefsky@de.ibm.com, svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org

On Wed, 2013-08-14 at 17:26 +0530, Preeti U Murthy wrote:
> -static irqreturn_t unused_action(int irq, void *data)
> +static irqreturn_t timer_action(int irq, void *data)
>  {
> -       /* This slot is unused and hence available for use, if needed
> */
> +       timer_interrupt();
>         return IRQ_HANDLED;
>  }
>  

That means we'll do irq_enter/irq_exit twice no ? And things like
may_hard_irq_enable() are also already done by do_IRQ so you
don't need timer_interrupt() to do it again.

We probably are better off breaking timer_interrupt in two:

void __timer_interrupt(struct pt_regs * regs)

Does the current stuff between irq_enter and irq_exit, timer_interrupt
does the remaining around it and calls __timer_interrupt.

Then from timer_action, you call __timer_interrupt()

Cheers,
Ben.



