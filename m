From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.25-rc6 3/7] pci_choose_state() cleanup
	and fixes
Date: Sun, 13 Apr 2008 21:59:05 -0700
Message-ID: <200804132159.06350.david-b__15870.8203853623$1208150856$gmane$org@pacbell.net>
References: <200803201408.33466.david-b@pacbell.net>
	<200803221049.16696.david-b@pacbell.net>
	<200803221934.34139.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803221934.34139.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Just to wrap this up ... if this #3 isn't going to merge,
then #4 can't merge either (teaching USB to use that call
to talk to ACPI etc).

See below.

However, several of the other patches in that series should
still IMO go upstream... I think I saw only one of them get
into the ACPI tree.


On Saturday 22 March 2008, Rafael J. Wysocki wrote:
> On Saturday, 22 of March 2008, David Brownell wrote:
> > On Friday 21 March 2008, Rafael J. Wysocki wrote:
> > > On Friday, 21 of March 2008, David Brownell wrote:
> > > > All it does is implement the rules that have been defined for
> > > > ages now:  most of the pm_message_t transitions should not
> > > > change device power states.
> > > 
> > > But they do at the moment, so you're going to change how the code
> > > currently works on a quite large scale.
> > 
> > Are you arguing that this bug "should not be fixed"?
> > 
> > Or are you arguing that there's something wrong with
> > the rules, so that they "should not be followed"?
> > 
> > Or something else?
> 
> Something else.  As I said before somewhere, I'd introduce a new function
> imilar to pci_choose_state(), but with the semantics you want it to have.
> Then, I'd make drivers switch to it and remove the original pci_choose_state()
> when it's no longer used.  Clean and safe.

The implementation of pci_choose_state() which first merged was
admittedly very broken.  That bothered me a lot ... since it
didn't adhere to my original proposal for such a function.

So while there's a part of me that would rather see my original
proposal working, rather than this broken version which reused
that name ... I can certainly live with some *other* function
doing the right thing, instead.


> > > > > I'd make it return PCI_D3hot if platform_pci_choose_state()
> > > > > is undefined or fails 
> > > > 
> > > > See above:  this implements the current rules, which say
> > > > that in most cases devices shoudn't change powerstates.
> > > 
> > > Okay, say you're changing pci_choose_state() to follow the
> > > documentation. 
> > 
> > Not just documentation -- the current architecture of the
> > whole suspend process.  Surely it's essential not to have
> > bugs like those at the core of that process?
> > 
> > If that process is broken, but this PCI bug hides it, we'll
> > be having a boatload of unexpected trouble in a while...
> 
> I'm not against fixing bugs, but let's do that without giving
> users and testers a hard time if possible.

I'm opposed to making design bugs in the first place.  I was
quite surprised to see so many functions got changed to use
the broken pci_choose_state() thing!


> > > Are you sure, however, that it won't cause any regressions to appear?
> > 
> > No more than any other bugfix turning up other latent bugs.
> > That's why we have a process which lets fixes cook for a while
> > before they merge.
> 
> In fact if a bugfix turns up any later bugs, then we should fix all of the
> later bugs along with that bugfix, preferably in one series of patches.

Fine.


> > > > +	switch (mesg.event) {
> > > >  	case PM_EVENT_SUSPEND:
> > > >  	case PM_EVENT_HIBERNATE:
> > > > -		return PCI_D3hot;
> > > > +		/* NOTE:  platform_pci_choose_state() should only return
> > > > +		 * states where wakeup won't work if
> > > > +		 *   - !device_may_wakeup(&dev->dev), or
> > > > +		 *   - dev can't wake from the target system state
> > > > +		 */
> > > > +		if (platform_pci_choose_state) {
> > > > +			ret = platform_pci_choose_state(dev, mesg);
> > > > +			if (ret == PCI_POWER_ERROR)
> > > > +				ret = PCI_D3hot;
> > > > +			else if ((ret == PCI_D1 || ret == PCI_D2)
> > > > +					&& pci_no_d1d2(dev))
> > > > +				ret = PCI_D3hot;
> > > > +			break;
> > > > +		}
> > > > +		/* D3hot works, but may be suboptimal */
> > > > +		ret = PCI_D3hot;
> > > > +		break;
> > > 
> > > I would do:
> > > 
> > > +		if (platform_pci_choose_state) {
> > > +			ret = platform_pci_choose_state(dev, mesg);
> > > +			if (ret == PCI_POWER_ERROR || (pci_no_d1d2(dev)
> > > +			    && (ret == PCI_D1 || ret == PCI_D2)))
> > 
> > That's ... phenomenally ugly and incomprehensible! It hides 
> > almost the entire structure of the conditionals.
> 
> I obviously disagree with that.  What exactly is incomprehensible in it?
> "Return D3hot if an error has been returned or a state we can't use has been
> returned".  Quite simple, no?

I've learned over time that complex conditions are *VERY* easily
misunderstood.  And that's pretty complex ... fortunately it has
no negation, but the previous version was simpler.  It clearly
split out the error condition from the "no D1/D2 support", and
that latter condition was easier to see (since it wasn't tangled
up with any unrelated logic).


 
> > > +				ret = PCI_D3hot;
> > > +		} else {
> > > +			/* D3hot works, but may be suboptimal */
> > > +			ret = PCI_D3hot;
> > > +		}
> > 
> > Extra/pointless brackets after "else" ...
> 
> Please have a look at Chapter 3 in Documentation/CodingStyle (just before 3.1).
> 
> > so you think the quickie fix should have removed that first "break"?  Simpler
> > to just have said so.
> > 
> > > +		break;
> > 
> > 
> > ======== CUT HERE
> > Clean up pci_choose_state():
> > 
> >  - pci_choose_state() should only return PCI_D0, unless the system is
> >    entering a suspend (or hibernate) system state.
> > 
> >  - Only use platform_pci_choose_state() when entering a suspend
> >    state ... and avoid PCI_D1 and PCI_D2 when appropriate.
> > 
> >  - Corrrect kerneldoc.
> > 
> > Note that for now only ACPI provides platform_pci_choose_state(), so
> > this could be a minor change in behavior on some non-PC systems:  it
> > avoids D3 except in the final stage of hibernation.
> > 
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> > ---
> >  drivers/pci/pci.c |   53 ++++++++++++++++++++++++++++++-----------------------
> >  1 file changed, 30 insertions(+), 23 deletions(-)
> > 
> > --- g26.orig/drivers/pci/pci.c	2008-03-22 10:25:48.000000000 -0700
> > +++ g26/drivers/pci/pci.c	2008-03-22 10:44:28.000000000 -0700
> > @@ -523,46 +523,53 @@ pci_set_power_state(struct pci_dev *dev,
> >  }
> >  
> >  pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
> > - 
> > +
> >  /**
> >   * pci_choose_state - Choose the power state of a PCI device
> >   * @dev: PCI device to be suspended
> > - * @state: target sleep state for the whole system. This is the value
> > - *	that is passed to suspend() function.
> > + * @mesg: value passed to suspend() function.
> >   *
> >   * Returns PCI power state suitable for given device and given system
> > - * message.
> > + * power state transition.
> >   */
> > -
> > -pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
> > +pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t mesg)
> >  {
> >  	pci_power_t ret;
> >  
> > +	/* PCI legacy PM? */
> >  	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
> >  		return PCI_D0;
> >  
> > -	if (platform_pci_choose_state) {
> > -		ret = platform_pci_choose_state(dev, state);
> > -		if (ret != PCI_POWER_ERROR)
> > -			return ret;
> > -	}
> > -
> > -	switch (state.event) {
> > -	case PM_EVENT_ON:
> > -		return PCI_D0;
> > -	case PM_EVENT_FREEZE:
> > -	case PM_EVENT_PRETHAW:
> > -		/* REVISIT both freeze and pre-thaw "should" use D0 */
> > +	switch (mesg.event) {
> >  	case PM_EVENT_SUSPEND:
> >  	case PM_EVENT_HIBERNATE:
> > -		return PCI_D3hot;
> > +		/*
> > +		 * D3hot works on all devices, but may be suboptimal on
> > +		 * a given system.  Factors include wakeups, power use,
> > +		 * the optional D3hot->D0 reset, latency, and more.
> > +		 *
> > +		 * If there's a platform_pci_choose_state(), it could
> > +		 * provide better answers for this system.  It should
> > +		 * only return states where wakeup won't work if:
> > +		 *   - !device_may_wakeup(&dev->dev), or
> > +		 *   - dev can't wake from the target system state
> > +		 */
> > +		ret = PCI_D3hot;
> > +		if (platform_pci_choose_state) {
> > +			ret = platform_pci_choose_state(dev, mesg);
> > +			if (ret == PCI_POWER_ERROR)
> > +				ret = PCI_D3hot;
> > +			else if ((ret == PCI_D1 || ret == PCI_D2)
> > +					&& pci_no_d1d2(dev))
> > +				ret = PCI_D3hot;
> 
> And so this reads "If an error is has been returned, return D3hot.  And by
> the way, if D1 or D2 has been returned and we can't use any of them,
> return D3hot".  I really don't see why it's better than just one condition, but
> whatever.

As I said:  One big complex condition is harder to understand.
Particularly compared to two simple standalone conditions.


 
> > +		}
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
> > -
> >  EXPORT_SYMBOL(pci_choose_state);
> >  
> >  static int pci_save_pcie_state(struct pci_dev *dev)
> > --
> 
> Thanks,
> Rafael
> 
