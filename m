From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Update][PATCH 7/8] PM / Domains: System-wide
	transitions support for generic domains (v3)
Date: Thu, 23 Jun 2011 00:16:46 +0200
Message-ID: <201106230016.46704.rjw__19633.9953029112$1308781099$gmane$org@sisk.pl>
References: <201106112223.04972.rjw@sisk.pl> <201106200006.07642.rjw@sisk.pl>
	<8739j1lemc.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <8739j1lemc.fsf@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, June 22, 2011, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > Make generic PM domains support system-wide power transitions
> > (system suspend and hibernation).  Add suspend, resume, freeze, thaw,
> > poweroff and restore callbacks to be associated with struct
> > generic_pm_domain objects and make pm_genpd_init() use them as
> > appropriate.
> >
> > The new callbacks do nothing for devices belonging to power domains
> > that were powered down at run time (before the transition).  
> 
> Great, this is the approach I prefer too, but...
> 
> Now I'm confused.  Leaving runtime suspended devices alone is what I was
> doing in my subsystem but was told not to.  According to
> 
>     http://www.mail-archive.com/linux-omap@vger.kernel.org/msg50690.html
> 
> "it's generally agreed that _all_ devices should return to full 
> power during system resume -- even if they were runtime suspended 
> before the system sleep."

Well, let's say this part of the documentation is slightly outdated.

It basically refers to the model in which system suspend is a separate global
hardware or firmware operation, so the state of devices may be changed by the
BIOS or whatever takes over control in the meantime.  In that case the kernel
has to ensure that the states of devices are consistent with what it thinks
about them and the simplest way to achieve that is to put the devices to
full power during resume (and back to low power if that's desirable).

However, in the case of the systems this patchset is intended for system
suspend is achieved by putting various hardware components into low-power
states directly in a coordinated way and the system sleep state effectively
follows from the low-power states the hardware components end up in.  The
system is woken up from this state by an interrupt or another mechanism under
the kernel's control.  As a result, the kernel never gives control away, so
the state of devices after the resume is precisely known to it.
In consequence, it need not ensure that the state of devices is consistent with
its view, because it knows that this is the case. :-)

So the documentation should be updated to say what hardware model it is
referring to.

Thanks,
Rafael
