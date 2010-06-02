From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime PM for PCI-based USB host controllers
Date: Wed, 2 Jun 2010 21:36:02 +0200
Message-ID: <201006022136.02785.rjw__13387.1791222647$1275507342$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1006021120520.1992-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006021120520.1992-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-pci@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 02 June 2010, Alan Stern wrote:
> On Tue, 1 Jun 2010, Rafael J. Wysocki wrote:
> 
> > > Therefore the default state for unbound PCI devices should be
> > > runtime-PM-enabled.
> > 
> > Why do you think it should?
> 
> So that they can be put into a low-power state.  If they are disabled 
> for runtime PM then they will remain in a high-power state.
> 
> > > Something like the patch below, awkward though it is.  Does this look 
> > > reasonable?
> > 
> > I'm not sure if r8169 and e1000e will work with it.  Probably not, but I'm
> > too tired to check right now. :-)
> 
> You mean because they already include their own runtime power 
> management?  Then they would need to be updated to match these changes, 
> naturally.
> 
> > > @@ -365,15 +380,24 @@ static int pci_device_probe(struct devic
> > >  
> > >  static int pci_device_remove(struct device * dev)
> > >  {
> > > +	struct device_driver *driver = dev->driver;
> > >  	struct pci_dev * pci_dev = to_pci_dev(dev);
> > >  	struct pci_driver * drv = pci_dev->driver;
> > >  
> > >  	if (drv) {
> > > -		if (drv->remove)
> > > +		if (drv->remove) {
> > > +			pm_runtime_get_sync(dev);
> > >  			drv->remove(pci_dev);
> > > +			pm_runtime_put_noidle(dev);
> > > +		}
> > >  		pci_dev->driver = NULL;
> > >  	}
> > 
> > Is "else" missing here or am I missing something?
> 
> I don't think an "else" is missing.  Rather, the entire "if (drv)"  
> line should be eliminated because it can never fail.
> 
> > > +	/* Undo the pm_runtime_get_sync() in local_pci_probe() */
> > > +	dev->driver = NULL;
> > > +	pm_runtime_put_sync(dev);
> > > +	dev->driver = driver;
> > > +
> > >  	/*
> > >  	 * If the device is still on, set the power state as "unknown",
> > >  	 * since it might change by the next time we load the driver.
> > 
> > Do PCI bus type callbacks need to be reworked to work correctly with unbound
> > devices?
> 
> They do; I neglected to take care of them when first writing this 
> patch.  After everything is working I'll submit it for real.  For now, 
> the point was to find out whether this is going in the right direction.

I don't have a fundamental problem with it.  As long as all things can be made
work along these lines, it's fine by me.

Rafael
