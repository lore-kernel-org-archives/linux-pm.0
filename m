From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] Suspend/resume regressions on Lenovo S10-3
Date: Wed, 6 Jun 2012 11:09:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206061108040.1788-100000@iolanthe.rowland.org>
References: <201206061543.03537.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201206061543.03537.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, Arnd Bergmann <arnd@arndb.de>, Linux PM mailing list <linux-pm@vger.kernel.org>, "Tomas M." <tmezzadra@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, preeti@linux.vnet.ibm.com, linux-pm@lists.linux-foundation.org, Ferenc Wagner <wferi@niif.hu>, Arjan van de Ven <arjan@linux.intel.com>, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 6 Jun 2012, Rafael J. Wysocki wrote:

> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -895,8 +895,9 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
> >  	if (unlikely(!pr))
> >  		return -EINVAL;
> >  
> > -
> >  	if (acpi_idle_suspend) {
> > +		local_irq_disable();
> > +		local_irq_enable();
> >  		cpu_relax();
> >  		return -EINVAL;
> >  	}
> 
> May I say this is ugly?  Why can't we track the status of interrupts
> properly here?

It's not just ugly; it's illogical.  What reason could there possibly
be for disabling interrupts and then enabling them again without doing
anything in between?

Alan Stern
