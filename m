From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI PM: Restore standard config registers of
	all devices early (was: Re: EeePC resume failure - timers)
Date: Fri, 16 Jan 2009 17:27:04 +0100
Message-ID: <200901161727.05026.rjw__44094.258620362$1232123411$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0901161010400.2417-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.0901160733260.29252@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0901160733260.29252@localhost.localdomain>
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
Cc: Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Linux PCI <linux-pci@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 16 January 2009, Linus Torvalds wrote:
> 
> On Fri, 16 Jan 2009, Alan Stern wrote:
> > 
> > USB does this.  However I admit that fixing every PCI driver would be a 
> > big chore...
> 
> I suspect USB is one of the very few drivers that may get suspend/resume 
> very close to right, partly because _everybody_ has a USB controller these 
> days, partly because USB interrupts are very commonly shared, and partly 
> because there are several core people who work on USB.
> 
> That's actually very rare (especially the last point - most drivers hardly 
> have _any_ maintainer, much less anybody who can see the big picture and 
> knows about the rest of the system).
> 
> So if everybody did what USB does, we'd indeed be fine, and suspend and 
> resume would probably work on practically every machine out there. But as 
> you note, it's not really an option. The common case for 99% of all 
> drivers is probably that none of the core kernel people can even test 
> them, and they likely do not exist even in some distro test area.
> 
> So I'm the one who pushed Rafael towards his patch, because we've worked 
> on suspend/resume for years, but while we're _much_ better than we used to 
> be (especially on machines that are really bog-standard and only have the 
> common chips), I don't think we'll ever really "get there" if we rely on 
> the drivers always getting things right.
> 
> And getting things right does mean changing every single PCI interrupt 
> handler to know about suspend/resume - not to mention do the 
> suspend/resume sequence right in the first place. Neither of the two is 
> very likely to really happen.
> 
> I did suggest that we could also add some test-infrastructure like the 
> DEBUG_SHIRQ thing we already have, which sends an interrupt immediately on 
> resume after interrupts have been enabled. That will likely uncover a 
> _lot_ of problems, and it's almost certainly worth doing regardless.

For the record, I put that onto my todo list, which unfortunately is quite long
at the moment (and getting longer).

> But even then, it would just be so much _simpler_ if the generic layer 
> just took care of this issue, so that drivers could just ignore it, and a 
> driver would only have to worry about its _own_ resume issues. 
> 
> So yes, doing it in the generic PCI layer clearly has some problems, and 
> no, it's not "perfect". In a perfect world, doing it in the driver has 
> real advantages - it's the most flexible approach, and it allows the 
> driver to do what it wants. But from all I've ever seen, I'm personally 
> pretty convinced that when it comes to drivers, the less the driver writer 
> has to worry about, the better off we are.

I agree.

IMO suspend-resume is quite difficult to implement in a PCI driver unless
the driver writer knows very well how PCI PM is supposed to work and interact
with things like interrupts control, ACPI etc.

> I'm franklly hoping that most PCI drivers would not need to have a 
> suspend/resume method at all - the PCI layer should get the normal PCI 
> suspend parts right, and the upper layers should do the rest. For example, 
> a network driver shouldn't have to close itself down - the network layer 
> should just do it for it (all the netif_stop_queue() etc crud to make 
> sure that the network layer doesn't try to touch it). 
> 
> So we're clearly not there yet. But after having yet another random 
> machine that just didn't resume because of yet another new random driver, 
> I'm just not seeing anything else that is viable long-term.
> 
> IOW, we can ask driver writers to write perfect code, or we can spend some 
> effort on trying to make things work even when they don't. I know which 
> approach I consider to be realistic.

So, does it mean the patch looks reasonable? ;-)

Rafael
