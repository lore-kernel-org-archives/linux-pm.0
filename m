From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] USB: don't enable wakeup by default for PCI
	host controllers
Date: Tue, 13 Jan 2009 21:35:15 +0100
Message-ID: <200901132135.15774.rjw__48212.5614923008$1231879236$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0901131133430.2667-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0901131133430.2667-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 13 January 2009, Alan Stern wrote:
> This patch (as1199) changes the initial wakeup settings for PCI USB
> host controllers.  The controllers are marked as capable of waking the
> system, but wakeup is not enabled by default.
> 
> It turns out that enabling wakeup for USB host controllers has a lot
> of bad consequences.  As the simplest example, if a USB mouse or
> keyboard is unplugged immediately after the computer is put to sleep,
> the unplug will cause the system to wake back up again!  We are better
> off marking them as wakeup-capable and leaving wakeup disabled.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Reported-by: Rafael J. Wysocki <rjw@sisk.pl>
> CC: David Brownell <david-b@pacbell.net>

Thanks for the patch, I'll test it later today, although it looks obviously
correct.

Please have a look at the patch I sent here:
http://marc.info/?l=linux-kernel&m=123184641714487&w=4

Thanks,
Rafael


> ---
> 
> This patch should also be queued for 2.6.28.stable.
> 
> 
> Index: usb-2.6/drivers/usb/core/hcd-pci.c
> ===================================================================
> --- usb-2.6.orig/drivers/usb/core/hcd-pci.c
> +++ usb-2.6/drivers/usb/core/hcd-pci.c
> @@ -128,7 +128,6 @@ int usb_hcd_pci_probe(struct pci_dev *de
>  	}
>  
>  	pci_set_master(dev);
> -	device_set_wakeup_enable(&dev->dev, 1);
>  
>  	retval = usb_add_hcd(hcd, dev->irq, IRQF_DISABLED | IRQF_SHARED);
>  	if (retval != 0)
> Index: usb-2.6/drivers/usb/host/ehci-pci.c
> ===================================================================
> --- usb-2.6.orig/drivers/usb/host/ehci-pci.c
> +++ usb-2.6/drivers/usb/host/ehci-pci.c
> @@ -230,7 +230,7 @@ static int ehci_pci_setup(struct usb_hcd
>  		pci_read_config_word(pdev, 0x62, &port_wake);
>  		if (port_wake & 0x0001) {
>  			dev_warn(&pdev->dev, "Enabling legacy PCI PM\n");
> -			device_init_wakeup(&pdev->dev, 1);
> +			device_set_wakeup_capable(&pdev->dev, 1);
>  		}
>  	}
>  
> Index: usb-2.6/drivers/usb/host/ohci-hcd.c
> ===================================================================
> --- usb-2.6.orig/drivers/usb/host/ohci-hcd.c
> +++ usb-2.6/drivers/usb/host/ohci-hcd.c
> @@ -593,12 +593,10 @@ static int ohci_run (struct ohci_hcd *oh
>  	 * to be checked in case boot firmware (BIOS/SMM/...) has set up
>  	 * wakeup in a way the bus isn't aware of (e.g., legacy PCI PM).
>  	 * If the bus glue detected wakeup capability then it should
> -	 * already be enabled.  Either way, if wakeup should be enabled
> -	 * but isn't, we'll enable it now.
> +	 * already be enabled; if so we'll just enable it again.
>  	 */
> -	if ((ohci->hc_control & OHCI_CTRL_RWC) != 0
> -			&& !device_can_wakeup(hcd->self.controller))
> -		device_init_wakeup(hcd->self.controller, 1);
> +	if ((ohci->hc_control & OHCI_CTRL_RWC) != 0)
> +		device_set_wakeup_capable(hcd->self.controller, 1);
>  
>  	switch (ohci->hc_control & OHCI_CTRL_HCFS) {
>  	case OHCI_USB_OPER:
> 
> 
> 


-- 
Everyone knows that debugging is twice as hard as writing a program
in the first place.  So if you're as clever as you can be when you write it,
how will you ever debug it? --- Brian Kernighan
