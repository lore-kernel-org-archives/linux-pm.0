From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC][PATCH] uli526x: Add suspend and resume routines
Date: Tue, 07 Aug 2007 17:40:36 -0400
Message-ID: <46B8E6D4.30405__30821.987524587$1186586416$gmane$org@garzik.org>
References: <200708052114.01790.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708052114.01790.rjw@sisk.pl>
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
Cc: Kyle McMartin <kyle@mcmartin.ca>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Grant Grundler <grundler@parisc-linux.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> +static int uli526x_suspend(struct pci_dev *pdev, pm_message_t state)
> +{
> +	struct net_device *dev = pci_get_drvdata(pdev);
> +	int err = 0;
> +
> +	ULI526X_DBUG(0, "uli526x_suspend", 0);
> +
> +	if (dev && netdev_priv(dev)) {
> +		pci_power_t power_state;
> +
> +		pci_save_state(pdev);
> +
> +		if (!netif_running(dev))
> +			return 0;
> +
> +		netif_device_detach(dev);
> +		uli526x_reset_prepare(dev);
> +
> +		power_state = pci_choose_state(pdev, state);
> +		pci_enable_wake(pdev, power_state, 0);
> +		err = pci_set_power_state(pdev, power_state);
> +		if (err) {
> +			netif_device_attach(dev);
> +			/* Re-initialize ULI526X board */
> +			uli526x_init(dev);
> +			/* Restart upper layer interface */
> +			netif_wake_queue(dev);
> +		}
> +	}
> +	return err;
> +}
> +
> +/*
> + *	Resume the interface.
> + */
> +
> +static int uli526x_resume(struct pci_dev *pdev)
> +{
> +	struct net_device *dev = pci_get_drvdata(pdev);
> +	struct uli526x_board_info *db = netdev_priv(dev);
> +
> +	ULI526X_DBUG(0, "uli526x_resume", 0);
> +
> +	if (dev && db) {
> +		int err;
> +
> +		pci_restore_state(pdev);
> +
> +		if (!netif_running(dev))
> +			return 0;
> +
> +		err = pci_set_power_state(pdev, PCI_D0);
> +		if (err) {
> +			printk(KERN_WARNING
> +				"%s: Could not put device into D0\n",
> +				dev->name);
> +			return err;
> +		}
> +
> +		netif_device_attach(dev);
> +		/* Re-initialize ULI526X board */
> +		uli526x_init(dev);
> +		/* Restart upper layer interface */
> +		netif_wake_queue(dev);
> +	}
> +	return 0;


Ugh -- please fix indentation.  This is not proper Linux code.

If you have the -vast majority- of code on an indented branch, as you 
have here, then you should either add an early 'return x;' or a goto, 
and unindent the main body of code.

I'll let our new tulip maintainer see what he thinks about the 
implementation.  Seems fairly sane to me, but should at least get an "it 
works" test.

	Jeff
