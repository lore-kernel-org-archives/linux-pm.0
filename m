From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] irq: provide debug_poll_all_shared_irqs()
 method under CONFIG_DEBUG_SHIRQ
Date: Fri, 16 Jan 2009 09:31:14 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901160920200.29252__25693.1008458652$1232127339$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0901161010400.2417-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.0901160733260.29252@localhost.localdomain>
	<200901161727.05026.rjw@sisk.pl> <20090116165123.GB27495@elte.hu>
	<alpine.LFD.2.00.0901160855440.29252@localhost.localdomain>
	<20090116171149.GA14084@elte.hu> <20090116171359.GA15538@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090116171359.GA15538@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: john stultz <johnstul@us.ibm.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org



On Fri, 16 Jan 2009, Ingo Molnar wrote:
> 
> Would it be possible to have a s2ram debug/test mode that puts as much 
> stuff into low-power mode as possible - except for the console.

Yeah, well.. Our own Documentation says that "no_console_suspend" is known 
to work with serial consoles and VGA, but that's not actually true. It 
_often_ works with those, especially if the serial line and the graphics 
are basically on the southbridge (ie integrated). But we do not really 
track any more complex topology.

But we could certainly do a "put everything but PCI bridge chips into D3" 
mode, and then do the whole "echo core > /sys/power/pm_test" thing. Right 
now I _think_ we don't actually put chips into D3 by default, because it 
has caused so many problems (ie only drivers with real suspend routines 
will put their chips into D3).

Of course, if the devices aren't on the power rail, they will lose power 
if we do a _real_ suspend (as opposed to that pm_test thing) and then come 
up in D3 anyway, so that means that we literally lack a lot of test 
coverage on this. 

You can try it out: right now I think we do

	pci_pm_set_unknown_state(pci_dev);

And you could replace it with something like

	/* Bridge chip or VGA controller? */
	if (pci_dev->subordinate || dev_is_graphics(pci_dev))
		pci_pm_set_unknown_state(pci_dev);
	else
		pci_set_power_state(PCI_D3cold);

and see what happens. I suspect a lot of machines are unhappy, and I 
suspect they are unhappy exactly because of the fact that this will 
suddenly show all the irq problems more.

But that, together with 'no_console_suspend', your irq injection, _and_ 
then using pm_test=core should probably be able to give some interesting 
debug data.

I dunno. I'm handwaving. There may be other problems.

			Linus
