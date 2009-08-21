From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Fri, 21 Aug 2009 19:01:06 +0200
Message-ID: <200908211901.06616.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0908211022210.2912-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908211022210.2912-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>, Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Greg KH <greg@kroah.com>, Alek Du <alek.du@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Dave Airlie <airlied@redhat.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Friday 21 August 2009, Alan Stern wrote:
> On Fri, 21 Aug 2009, Zhenyu Wang wrote:
> 
> > > I can't understand why Alex's patch could fix for you, or because you've
> > > seen 'state_saved' is false in your testing, and Alex's patch just workaround
> > > state restore for you? I don't understand why 'state_saved' is false in your
> > > case, as pci layer should do save state for us by default, no?
> 
> The PCI layer _does_ save the state, in pci_legacy_suspend_late().  
> And then in pci_pm_default_resume_noirq() it restores the state and
> sets state_saved to false.  That's why state_saved is false when
> agp_intel_resume() runs.
> 
> > > Could you try with this one? And what's your gfx chip?
> 
> 00:02.0 VGA compatible controller: Intel Corporation 82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device (rev 03)
> 
> 
> > oops, here's right one for testing...
> > 
> > diff --git a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
> > index 8c9d50d..5ed62c1 100644
> > --- a/drivers/char/agp/intel-agp.c
> > +++ b/drivers/char/agp/intel-agp.c
> > @@ -2303,6 +2303,13 @@ static void __devexit agp_intel_remove(struct pci_dev *pdev)
> >  }
> >  
> >  #ifdef CONFIG_PM
> > +static int agp_intel_suspend(struct pci_dev *pdev, pm_message_t state)
> > +{
> > +	pci_save_state(pdev);
> > +	pci_set_power_state(pdev, 3);
> > +	return 0;
> > +}
> 
> I don't think this will help.  The state _is_ getting saved, so saving
> it again won't make any difference.  The problem occurs because the
> state is restored at the wrong time.

Yes.  Moreover, it doesn't need to be restored at that point, because it has
already been restored earlier by the PCI bus type code.

So, Zhenyu, it is completely unnecessary to call pci_restore_state() from
a driver's ->resume() routine, because the PCI bus type driver has
already called it in its ->resume_noirq().  And please note that
pci_pm_default_resume_noirq() clears state_saved, which is why the Alek's
patch helps.

Without the Alek's patch on the Alan's system the config registers of both
PCI devices are restored twice, first by the PCI bus type at the "noirq" stage
and next by the driver.  The Alek's patch turns the second restorations into
NOPs, which is fine, because they are unnecessary in general and they break
things on the Alan's system.

Thanks,
Rafael
