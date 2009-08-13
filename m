From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] PCI: Runtime power management
Date: Thu, 13 Aug 2009 11:17:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908131100440.2940-100000__33074.7976586737$1250176826$gmane$org@iolanthe.rowland.org>
References: <20090813002925.GA2532@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090813002925.GA2532@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 13 Aug 2009, Matthew Garrett wrote:

> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c

> +#ifdef CONFIG_PM_RUNTIME
> +
> +static int pci_pm_runtime_suspend(struct device *dev)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +	int error;
> +
> +	device_set_wakeup_enable(dev, 1);

This is a userspace policy parameter.  Kernel code should not alter it.
Instead you should test device_may_wakeup.

> +	error = pci_enable_runtime_wake(pci_dev, true);
> +
> +	if (error)
> +		return -EBUSY;
> +
> +	if (pm && pm->runtime_suspend)
> +		error = pm->runtime_suspend(dev);
> +
> +	if (error)
> +		goto out;
> +
> +	error = pci_pm_suspend(dev);
> +
> +	if (error)
> +		goto resume;
> +
> +	disable_irq(pci_dev->irq);
> +	error = pci_pm_suspend_noirq(dev);
> +	enable_irq(pci_dev->irq);
> +
> +	if (error)
> +		goto resume_noirq;
> +
> +	return 0;
> +
> +resume_noirq:
> +	disable_irq(pci_dev->irq);
> +	pci_pm_resume_noirq(dev);
> +	enable_irq(pci_dev->irq);
> +resume:
> +	pci_pm_resume(dev);
> +out:
> +	pci_enable_runtime_wake(pci_dev, false);
> +	return error;
> +}

The goto statements and unwinding code don't match up.

> +static int pci_pm_runtime_resume(struct device *dev)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +	int error = 0;
> +
> +	disable_irq(pci_dev->irq);
> +	error = pci_pm_resume_noirq(dev);
> +	enable_irq(pci_dev->irq);
> +
> +	if (error)
> +		return error;
> +
> +	error = pci_pm_resume(dev);
> +
> +	if (error)
> +		return error;
> +
> +	if (pm->runtime_resume)
> +		error = pm->runtime_resume(dev);
> +
> +	if (error)
> +		return error;
> +
> +	error = pci_enable_runtime_wake(pci_dev, false);
> +
> +	if (error)
> +		return error;
> +
> +	return 0;
> +}

Log an error message when something goes wrong?

> +static void pci_pm_runtime_idle(struct device *dev)
> +{
> +	struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +
> +	if (pm && pm->runtime_idle)
> +		pm->runtime_idle(dev);
> +
> +	pm_schedule_suspend(dev, 0);
> +}

This misses the point.  The whole idea of runtime_idle is to tell you 
that the device is idle and might be ready to be suspended.  If you're 
going to call pm_schedule_suspend anyway, there's no reason to invoke 
pm->runtime_idle.

Alan Stern
