From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.25-rc6 3/7] pci_choose_state() cleanup
	and fixes
Date: Thu, 20 Mar 2008 16:03:01 -0700
Message-ID: <20080320230301.8EFB235F4AF__12044.2613297657$1206054424$gmane$org@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <200803201408.33466.david-b@pacbell.net>
	<200803201412.44181.david-b@pacbell.net>
	<200803202337.07465.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803202337.07465.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > +	switch (mesg.event) {
> >  	case PM_EVENT_SUSPEND:
> > +		/* NOTE:  platform_pci_choose_state() should only return
> > +		 * states where wakeup won't work if
> > +		 *   - !device_may_wakeup(&dev->dev), or
> > +		 *   - dev can't wake from the target system state
> > +		 */
> > +		if (platform_pci_choose_state) {
> > +			ret = platform_pci_choose_state(dev, mesg);
> > +			if (ret == PCI_POWER_ERROR)
> > +				ret = PCI_D3hot;
> > +			else if ((ret == PCI_D1 || ret == PCI_D2)
> > +					&& pci_no_d1d2(dev))
> > +				ret = PCI_D3hot;
> > +			break;
> > +		}
> > +		/* FALLTHROUGH ... D3hot works, but may be suboptimal */
> >  	case PM_EVENT_HIBERNATE:
> > -		return PCI_D3hot;
> > +		ret = PCI_D3hot;
>
> This is clearly wrong.  It should do the same as for suspend here (_S4D may be
> defined and we should take it into account if it is).

So you're saying the original code was wrong, and this patch should
change that behavior too?



> > +		break;
> >  	default:
> > -		printk("Unrecognized suspend event %d\n", state.event);
> > -		BUG();
> > +		ret = PCI_D0;
> > +		break;
> >  	}
> > -	return PCI_D0;
> > +	return ret;
> >  }
> >  
> >  EXPORT_SYMBOL(pci_choose_state);
>
> I really don't think pci_choose_state() should take the state argument at all.

There is no "state" argument.  It's a pm_message_t, which does
not package the target state.

A patch to change the calling syntax for this would necessarily
be a different patch... and would need to change the callers too.

- Dave
