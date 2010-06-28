From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [update] Re: [PATCH] PM: Make it possible to avoid
 wakeup events from being lost
Date: Mon, 28 Jun 2010 12:11:20 -0700
Message-ID: <20100628121120.4f764413__25281.1616090641$1277752762$gmane$org@virtuousgeek.org>
References: <Pine.LNX.4.44L0.1006281006360.1977-100000@iolanthe.rowland.org>
	<201006282101.54041.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006282101.54041.rjw@sisk.pl>
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
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, linux-pci@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 28 Jun 2010 21:01:53 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> --- linux-2.6.orig/drivers/pci/pci.c
> +++ linux-2.6/drivers/pci/pci.c
> @@ -1275,6 +1275,22 @@ bool pci_check_pme_status(struct pci_dev
>  	return ret;
>  }
>  
> +/*
> + * Time to wait before the system can be put into a sleep state after reporting
> + * a wakeup event signaled by a PCI device.
> + */
> +#define PCI_WAKEUP_COOLDOWN	100
> +
> +/**
> + * pci_wakeup_event - Report a wakeup event related to a given PCI device.
> + * @dev: Device to report the wakeup event for.
> + */
> +void pci_wakeup_event(struct pci_dev *dev)
> +{
> +	if (device_may_wakeup(&dev->dev))
> +		pm_wakeup_event(&dev->dev, PCI_WAKEUP_COOLDOWN);
> +}
> +
>  /**
>   * pci_pme_wakeup - Wake up a PCI device if its PME Status bit is set.
>   * @dev: Device to handle.
> @@ -1285,8 +1301,10 @@ bool pci_check_pme_status(struct pci_dev
>   */
>  static int pci_pme_wakeup(struct pci_dev *dev, void *ign)
>  {
> -	if (pci_check_pme_status(dev))
> +	if (pci_check_pme_status(dev)) {
>  		pm_request_resume(&dev->dev);
> +		pci_wakeup_event(dev);
> +	}
>  	return 0;
>  }
>  

I assume the units here are ms?  And the wakeup event propagation check
is pushed down into pci_wakeup_event, is there no place to check
whether the device is configured to generate wakeups in the core device
or PM code?

Other than that, the PCI part is
Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>

-- 
Jesse Barnes, Intel Open Source Technology Center
