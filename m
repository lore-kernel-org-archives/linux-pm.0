From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/1] PM: Add arch_suspend_disable_nonboot_cpus
Date: Mon, 22 Feb 2010 20:14:07 +0100
Message-ID: <201002222014.07280.rjw@sisk.pl>
References: <201002211631.o1LGVsw8022630@d01av02.pok.ibm.com>
	<201002212337.10462.rjw@sisk.pl>
	<4B81B7C5.5060301@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B81B7C5.5060301@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian King <brking@linux.vnet.ibm.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday 21 February 2010, Brian King wrote:
> On 02/21/2010 04:37 PM, Rafael J. Wysocki wrote:
> > On Sunday 21 February 2010, Brian King wrote:
> >> On 02/21/2010 04:27 PM, Rafael J. Wysocki wrote:
> >>> On Sunday 21 February 2010, Brian King wrote:
> >>>> On 02/21/2010 04:08 PM, Rafael J. Wysocki wrote:
> >>>>> I'm not a big fan of __attribute__ ((weak)), though.  While we already use that
> >>>>> in the suspend code, I'm not particularly comfortable with it.
> >>>>>
> >>>>> Have you considered any alternative approaches?
> >>>>
> >>>> I suppose another option would be to implement this similar to how
> >>>> arch_free_page and arch_alloc_page do. Something like this:
> >>>>
> >>>> #ifndef CONFIG_HAVE_ARCH_SUSPEND_CPUS
> >>>> static inline int arch_suspend_disable_nonboot_cpus(void)
> >>>> {
> >>>> 	return disable_nonboot_cpus();
> >>>> }
> >>>>
> >>>> static inline void arch_suspend_enable_nonboot_cpus(void)
> >>>> {
> >>>> 	return enable_nonboot_cpus()'
> >>>> }
> >>>> #else
> >>>> extern int arch_suspend_disable_nonboot_cpus(void);
> >>>> extern void arch_suspend_enable_nonboot_cpus(void);
> >>>> #endif
> >>>>
> >>>> I figured I would just be consistent with arch_suspend_disable_irqs /
> >>>> arch_suspend_enable_irqs.
> >>>
> >>> I just think that doing arch_suspend_[enable|disable]_irqs() this way was
> >>> a mistake.
> >>
> >> Do you prefer the example above? I can send an updated patch. If not,
> >> any other suggestions you might have as to the way you would like this
> >> done would be greatly appreciated.
> > 
> > disable_nonboot_cpus() is also called by kernel_power_off().  Is that fine
> > with your architecture?
> 
> Yes. We only need a different behavior for the suspend/resume path.

OK

> Here is an alternative implementation of the patch. My test machine is
> currently unavailable, so it is not yet been tested. How does this one look?

Well, I'd like to do that cleanly from the start.

Now, the problem is that PM_SLEEP_SMP selects HOTPLUG_CPU, because
that's necessary for the other architectures to make SMP suspend work, but it's
not necessary on your architecture.  Moreover, you don't need to compile
enable_nonboot_cpus() at all.

I'm not sure how to untangle it at the moment, but I think it should be
untangled.

Preferably, on architectures that need HOTPLUG_CPU for the SMP resume to work
PM_SLEEP_SMP should depend on it instead of selecting it, but on your
architectures they may be independent from each other.

Rafael
