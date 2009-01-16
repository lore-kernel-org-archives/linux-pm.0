From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] irq: provide debug_poll_all_shared_irqs()
	method under	CONFIG_DEBUG_SHIRQ
Date: Fri, 16 Jan 2009 18:13:59 +0100
Message-ID: <20090116171359.GA15538__10599.1847966381$1232126199$gmane$org@elte.hu>
References: <Pine.LNX.4.44L0.0901161010400.2417-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.0901160733260.29252@localhost.localdomain>
	<200901161727.05026.rjw@sisk.pl> <20090116165123.GB27495@elte.hu>
	<alpine.LFD.2.00.0901160855440.29252@localhost.localdomain>
	<20090116171149.GA14084@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090116171149.GA14084@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > So I do think this is worth doing as a "make it easier to _see_ all 
> > the nasty suspend/resume problems", but at the same time it's going to 
> > be really really painful to debug, and it's not an option we can 
> > likely ever enable in some distro kernel - because a regular user 
> > can't even send a bug-report (just a "resume used to work, now it 
> > stopped working" thing).
> 
> Yeah, indeed. Perhaps a sysctl that turns it off by default might help? 
> Under CONFIG_PM_DEBUG or so.

btw., i think the main problem with debugging is whether one can 'see' the 
problem, literally.

Would it be possible to have a s2ram debug/test mode that puts as much 
stuff into low-power mode as possible - except for the console. That would 
still include a fair amount of random drivers that is at issue here. And 
once the crash/hang happens while it can be seen where it hangs/crashes, 
it becomes a lot more debuggable IMO.

Or is this impossible / not feasible / inefficient?

	Ingo
