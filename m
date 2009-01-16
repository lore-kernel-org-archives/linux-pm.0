From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] irq: provide debug_poll_all_shared_irqs()
	method under	CONFIG_DEBUG_SHIRQ
Date: Fri, 16 Jan 2009 18:11:49 +0100
Message-ID: <20090116171149.GA14084__42430.4770109758$1232126063$gmane$org@elte.hu>
References: <Pine.LNX.4.44L0.0901161010400.2417-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.0901160733260.29252@localhost.localdomain>
	<200901161727.05026.rjw@sisk.pl> <20090116165123.GB27495@elte.hu>
	<alpine.LFD.2.00.0901160855440.29252@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0901160855440.29252@localhost.localdomain>
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
Cc: john stultz <johnstul@us.ibm.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 16 Jan 2009, Ingo Molnar wrote:
> > 
> > The sooner we start seeing these kinds of problems the better - 
> > delaying debug patches to after feature work is never a good idea - 
> > delaying feature changes works much better ;-)
> 
> The problem with this particular debug feature is that when it finds 
> something, the machine usually just hangs because the interrupt handler 
> is just looping over reading some status register that returns 0xff, and 
> thinks that means "interrupt pending".
> 
> Or maybe it's not looping, it's using some value as an index, or just 
> isn't ready to be called at all because it shut down things and as a 
> result it actually crashes with a NULL pointer dereference or something.
> 
> And if you are in the middle of a resume, the result is not pretty. The 
> crash is often totally undebuggable. You can test it by using the 
> 'no_console_suspend' and 'acpi_sleep=s3_bios' kernel parameters, and 
> _maybe_ it will get things working. You're probably more likely to get a 
> working setup if you use VGA text mode rather than FBCON, though.
> 
> In other words: the actual problems you hit tend to be very similar to 
> the nasty problems that DEBUG_SHIRQ can uncover - but with the _normal_ 
> DEBUG_SHIRQ you at least usually have a console, so you can add printk's 
> to see where it happened, and you get oopses etc.
> 
> So I do think this is worth doing as a "make it easier to _see_ all the 
> nasty suspend/resume problems", but at the same time it's going to be 
> really really painful to debug, and it's not an option we can likely 
> ever enable in some distro kernel - because a regular user can't even 
> send a bug-report (just a "resume used to work, now it stopped working" 
> thing).

Yeah, indeed. Perhaps a sysctl that turns it off by default might help? 
Under CONFIG_PM_DEBUG or so.

	Ingo
