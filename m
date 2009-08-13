From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [RFC] PCI: Runtime power management
Date: Thu, 13 Aug 2009 22:47:01 +0100
Message-ID: <20090813214701.GC14532__29997.611026238$1250200169$gmane$org@srcf.ucam.org>
References: <20090813002925.GA2532@srcf.ucam.org>
	<Pine.LNX.4.44L0.0908131100440.2940-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0908131100440.2940-100000@iolanthe.rowland.org>
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
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 13, 2009 at 11:17:05AM -0400, Alan Stern wrote:
> On Thu, 13 Aug 2009, Matthew Garrett wrote:
> 
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> 
> > +#ifdef CONFIG_PM_RUNTIME
> > +
> > +static int pci_pm_runtime_suspend(struct device *dev)
> > +{
> > +	struct pci_dev *pci_dev = to_pci_dev(dev);
> > +	struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> > +	int error;
> > +
> > +	device_set_wakeup_enable(dev, 1);
> 
> This is a userspace policy parameter.  Kernel code should not alter it.
> Instead you should test device_may_wakeup.

Ugh. I'd really prefer us to assume that drivers are able to cope unless 
proven otherwise. Userspace policy makes sense where we don't have any 
idea whether something will work or not, but I'd really expect that most 
PCI drivers will either cope (in which case they'll have enabling code) 
or won't (in which case they won't). Why would we want userspace to 
influence this?

> > +	enable_irq(pci_dev->irq);
> > +resume:
> > +	pci_pm_resume(dev);
> > +out:
> > +	pci_enable_runtime_wake(pci_dev, false);
> > +	return error;
> > +}
> 
> The goto statements and unwinding code don't match up.

I'll look at that.

> > +	if (error)
> > +		return error;
> > +
> > +	return 0;
> > +}
> 
> Log an error message when something goes wrong?

Seems fair.

> > +static void pci_pm_runtime_idle(struct device *dev)
> > +{
> > +	struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> > +
> > +	if (pm && pm->runtime_idle)
> > +		pm->runtime_idle(dev);
> > +
> > +	pm_schedule_suspend(dev, 0);
> > +}
> 
> This misses the point.  The whole idea of runtime_idle is to tell you 
> that the device is idle and might be ready to be suspended.  If you're 
> going to call pm_schedule_suspend anyway, there's no reason to invoke 
> pm->runtime_idle.

My understanding of the API was that pm_device_put() invokes 
runtime_idle if the refcount hits 0. The bus layer has no idea of the 
refcount, and calling suspend directly from the driver would defeat the 
point of the system-wide recounting.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
