From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI / PM: Clean up outdated comments in
 pci_target_state()
Date: Tue, 22 May 2018 08:06:12 -0500
Message-ID: <20180522130612.GB161672@bhelgaas-glaptop.roam.corp.google.com>
References: <2360046.ecez94sF1Y@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2360046.ecez94sF1Y@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 21, 2018 at 01:11:12PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Two comments in pci_target_state() are outdated, as the function
> doesn't set the target power state for the device any more, only
> finds one for it, so fix them accordingly.
> 
> Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume you'll merge this; let me know if you'd rather that I take it.

> ---
>  drivers/pci/pci.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -2025,8 +2025,7 @@ static pci_power_t pci_target_state(stru
>  
>  	if (platform_pci_power_manageable(dev)) {
>  		/*
> -		 * Call the platform to choose the target state of the device
> -		 * and enable wake-up from this state if supported.
> +		 * Call the platform to find the target state for the device.
>  		 */
>  		pci_power_t state = platform_pci_choose_state(dev);
>  
> @@ -2059,8 +2058,7 @@ static pci_power_t pci_target_state(stru
>  	if (wakeup) {
>  		/*
>  		 * Find the deepest state from which the device can generate
> -		 * wake-up events, make it the target state and enable device
> -		 * to generate PME#.
> +		 * PME#.
>  		 */
>  		if (dev->pme_support) {
>  			while (target_state
> 
