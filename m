From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during suspend-resume
Date: Thu, 26 Feb 2009 23:30:51 +0100
Message-ID: <200902262330.52390.rjw__46309.1699443341$1235687625$gmane$org@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl> <200902262258.55835.rjw@sisk.pl>
	<alpine.LFD.2.00.0902261404580.3111@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0902261404580.3111@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 26 February 2009, Linus Torvalds wrote:
> 
> On Thu, 26 Feb 2009, Rafael J. Wysocki wrote:
> > 
> > Well, how exactly the $subject patch does cause this problem to happen?
> 
> Rafael, the problem is that if an interrupt happens while it's disabled - 
> but before the CPU has actually turned all interrupts off - the CPU will 
> ACK the interrupt (but just set a flag for it being PENDING), so now the 
> chipset logic around it will not see it as pending any more, so now the 
> chipset won't auto-wake the CPU immediately (or more likely, it won't 
> even suspend it).

Ah, I see now, thanks.

> It's trivial to fix multiple ways, so I wouldn't worry. The most trivial 
> way is to just have some sysdev drievr code simply do something like
> 
>   static int sysdev_suspend()
>   {
> 	for_each_irq(irq,desc) {
> 		if (!(desc->flags & IRQF_WAKE))
> 			continue;
> 		if (desc->flags & IRQ_PENDING)
> 			return -EBUSY;
> 	}
> 	return 0;
>   }
> 
> and that should automatically mean that if any irq is pending, the suspend 
> will fail and we'll immediately wake up again.

Yeah.

Thanks,
Rafael
