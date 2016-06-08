From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 1/1] PCI / PM: enforce type casting for pci_power_t
Date: Wed, 08 Jun 2016 02:16:58 +0200
Message-ID: <1652791.MK3RD42PLf@vostro.rjw.lan>
References: <1465321713-146178-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1465321713-146178-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 07, 2016 08:48:33 PM Andy Shevchenko wrote:
> When cast pci_power_t type of variables a static analizer tool complains on
> that.
> 
> 	include/linux/pci.h:119:37: warning: cast from restricted pci_power_t
> 
> Enforce type casting to make static analizer happy.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

ACK

> ---
>  include/linux/pci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b67e4df..8d74834 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -116,7 +116,7 @@ extern const char *pci_power_names[];
>  
>  static inline const char *pci_power_name(pci_power_t state)
>  {
> -	return pci_power_names[1 + (int) state];
> +	return pci_power_names[1 + (__force int) state];
>  }
>  
>  #define PCI_PM_D2_DELAY		200
> 
