From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH 6/10] PCI PM: Rearrange code in
	pci-driver.c
Date: Mon, 5 Jan 2009 12:25:01 +0100
Message-ID: <20090105112501.GK27199__26276.3977902525$1231155033$gmane$org@atrey.karlin.mff.cuni.cz>
References: <200812190049.34343.rjw@sisk.pl> <200812281607.28007.rjw@sisk.pl>
	<200812302333.45560.rjw@sisk.pl> <200812302343.07164.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200812302343.07164.rjw@sisk.pl>
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
Cc: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "H. Peter Anvin" <hpa@zytor.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Rename two functions and rearrange code in drivers/pci/pci-driver.c
> so that it's easier to follow.  In particular, separate invocations
> of the legacy callbacks from the rest of the new callbacks' code.
> 
> No functional changes should result from this.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/pci/pci-driver.c |  104 +++++++++++++++++++++++++++++------------------
>  1 file changed, 65 insertions(+), 39 deletions(-)
>

> @@ -504,17 +504,21 @@ static int pci_pm_suspend(struct device 
>  	struct device_driver *drv = dev->driver;
>  	int error = 0;
>  
> +	if (pci_has_legacy_pm_support(pci_dev)) {
> +		error = pci_legacy_suspend(dev, PMSG_SUSPEND);
> +		goto Exit;
> +	}
> +
>  	if (drv && drv->pm) {
>  		if (drv->pm->suspend) {
>  			error = drv->pm->suspend(dev);
>  			suspend_report_result(drv->pm->suspend, error);
>  		}
> -	} else if (pci_has_legacy_pm_support(pci_dev)) {
> -		error = pci_legacy_suspend(dev, PMSG_SUSPEND);
>  	} else {
>  		pci_pm_default_suspend(pci_dev);
>  	}
>

Does this mean that pci_has_legacy_pm_support() => !(drv && drv->pm) ?
Should pci_has_legacy_pm_support() check for that and WARN() in case
both sets of callbacks are set?
									Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
