From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: For d3_delay and d3cold_delay, zero means zero
Date: Tue, 14 Mar 2017 08:03:05 -0500
Message-ID: <20170314130305.GH8232@bhelgaas-glaptop.roam.corp.google.com>
References: <1489484696-14093-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750803AbdCNNDJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Mar 2017 09:03:09 -0400
Content-Disposition: inline
In-Reply-To: <1489484696-14093-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-pci <linux-pci@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukas Wunner <lukas@wunner.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi Adrian,

On Tue, Mar 14, 2017 at 11:44:56AM +0200, Adrian Hunter wrote:
> Do not sleep at all for the respective cases of d3_delay is zero or
> d3cold_delay is zero.

Can you please include a hint here about (1) what msleep() does with an
argument of zero, and (2) why this change is desirable, e.g., maybe it
makes suspend/resume faster or something?

> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/pci/pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7904d02ffdb9..9779483f81fd 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -66,7 +66,8 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
>  	if (delay < pci_pm_d3_delay)
>  		delay = pci_pm_d3_delay;
>  
> -	msleep(delay);
> +	if (delay)
> +		msleep(delay);
>  }
>  
>  #ifdef CONFIG_PCI_DOMAINS
> @@ -827,7 +828,8 @@ static void __pci_start_power_transition(struct pci_dev *dev, pci_power_t state)
>  		 * because have already delayed for the bridge.
>  		 */
>  		if (dev->runtime_d3cold) {
> -			msleep(dev->d3cold_delay);
> +			if (dev->d3cold_delay)
> +				msleep(dev->d3cold_delay);
>  			/*
>  			 * When powering on a bridge from D3cold, the
>  			 * whole hierarchy may be powered on into
> -- 
> 1.9.1
> 
