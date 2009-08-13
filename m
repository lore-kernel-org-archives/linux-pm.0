From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] usb: Add support for runtime power management
	of the hcd
Date: Thu, 13 Aug 2009 11:22:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908131117130.2940-100000__8680.75164403326$1250177334$gmane$org@iolanthe.rowland.org>
References: <20090813003544.GB2532@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090813003544.GB2532@srcf.ucam.org>
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

> --- a/drivers/usb/core/hcd-pci.c
> +++ b/drivers/usb/core/hcd-pci.c
> @@ -363,6 +363,18 @@ static int hcd_pci_restore(struct device *dev)
>  	return resume_common(dev, true);
>  }
>  
> +static int hcd_pci_runtime_suspend(struct device *dev)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	struct usb_hcd *hcd = pci_get_drvdata(pci_dev);
> +	struct usb_device *rhdev = hcd->self.root_hub;
> +
> +	if (!(hcd->driver->flags & HCD_RUNTIME_PM))
> +		return -EINVAL;
> +
> +	return 0;
> +}

You have to call the HCD's pci_suspend method!  Not to mention calling 
synchronize_irq and all the other stuff in hcd_pci_suspend and 
hcd_pci_suspend_noirq.

Ditto for resuming.

Alan Stern
