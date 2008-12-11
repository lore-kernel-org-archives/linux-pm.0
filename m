From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI: fix incorrect error return in
	pci_enable_wake
Date: Thu, 11 Dec 2008 21:19:51 +0100
Message-ID: <200812112119.51610.rjw__26702.9808288955$1229027082$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0812111510160.15474-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0812111510160.15474-100000@iolanthe.rowland.org>
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
Cc: Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 11 of December 2008, Alan Stern wrote:
> This patch (as1186) fixes a minor mistake in pci_enable_wake().  When
> the routine is asked to disable remote wakeup, it should not return an
> error merely because the device is not allowed to do wakeups!
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

[This should go to Jesse, BTW, already CCed.]
> ---
> 
> Index: usb-2.6/drivers/pci/pci.c
> ===================================================================
> --- usb-2.6.orig/drivers/pci/pci.c
> +++ usb-2.6/drivers/pci/pci.c
> @@ -1107,7 +1107,7 @@ int pci_enable_wake(struct pci_dev *dev,
>  	int error = 0;
>  	bool pme_done = false;
>  
> -	if (!device_may_wakeup(&dev->dev))
> +	if (enable && !device_may_wakeup(&dev->dev))
>  		return -EINVAL;
>  
>  	/*
