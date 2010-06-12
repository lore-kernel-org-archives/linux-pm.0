From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI: change device runtime PM settings for
	probe and remove
Date: Sun, 13 Jun 2010 00:39:57 +0200
Message-ID: <201006130039.57610.rjw__30728.3633192585$1276382632$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1006081522270.1372-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006081522270.1372-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 08, 2010, Alan Stern wrote:
> This patch (as1388) changes the way the PCI core handles runtime PM
> settings when probing or unbinding drivers.  Now the core will make
> sure the device is enabled for runtime PM, with a usage count >= 1,
> when a driver is probed.  It does the same when calling a driver's
> remove method.
> 
> If the driver wants to use runtime PM, all it has to do is call
> pm_runtime_pu_noidle() near the end of its probe routine (to cancel
> the core's usage increment) and pm_runtime_get_noresume() near the
> start of its remove routine (to restore the usage count).  It does not
> need to mess around with setting the runtime state to enabled,
> disabled, active, or suspended.
> 
> The patch updates e1000e and r8169, the only PCI drivers that already
> use the existing runtime PM interface.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> CC: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

Jesse, please queue up for 2.6.36.

Rafael


> ---
> 
> Index: usb-2.6/drivers/pci/pci-driver.c
> ===================================================================
> --- usb-2.6.orig/drivers/pci/pci-driver.c
> +++ usb-2.6/drivers/pci/pci-driver.c
> @@ -289,8 +289,26 @@ struct drv_dev_and_id {
>  static long local_pci_probe(void *_ddi)
>  {
>  	struct drv_dev_and_id *ddi = _ddi;
> +	struct device *dev = &ddi->dev->dev;
> +	int rc;
>  
> -	return ddi->drv->probe(ddi->dev, ddi->id);
> +	/* Unbound PCI devices are always set to disabled and suspended.
> +	 * During probe, the device is set to enabled and active and the
> +	 * usage count is incremented.  If the driver supports runtime PM,
> +	 * it should call pm_runtime_put_noidle() in its probe routine and
> +	 * pm_runtime_get_noresume() in its remove routine.
> +	 */
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	rc = ddi->drv->probe(ddi->dev, ddi->id);
> +	if (rc) {
> +		pm_runtime_disable(dev);
> +		pm_runtime_set_suspended(dev);
> +		pm_runtime_put_noidle(dev);
> +	}
> +	return rc;
>  }
>  
>  static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
> @@ -369,11 +387,19 @@ static int pci_device_remove(struct devi
>  	struct pci_driver * drv = pci_dev->driver;
>  
>  	if (drv) {
> -		if (drv->remove)
> +		if (drv->remove) {
> +			pm_runtime_get_sync(dev);
>  			drv->remove(pci_dev);
> +			pm_runtime_put_noidle(dev);
> +		}
>  		pci_dev->driver = NULL;
>  	}
>  
> +	/* Undo the runtime PM settings in local_pci_probe() */
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_put_noidle(dev);
> +
>  	/*
>  	 * If the device is still on, set the power state as "unknown",
>  	 * since it might change by the next time we load the driver.
> Index: usb-2.6/drivers/net/e1000e/netdev.c
> ===================================================================
> --- usb-2.6.orig/drivers/net/e1000e/netdev.c
> +++ usb-2.6/drivers/net/e1000e/netdev.c
> @@ -5721,11 +5721,8 @@ static int __devinit e1000_probe(struct 
>  
>  	e1000_print_device_info(adapter);
>  
> -	if (pci_dev_run_wake(pdev)) {
> -		pm_runtime_set_active(&pdev->dev);
> -		pm_runtime_enable(&pdev->dev);
> -	}
> -	pm_schedule_suspend(&pdev->dev, MSEC_PER_SEC);
> +	if (pci_dev_run_wake(pdev))
> +		pm_runtime_put_noidle(&pdev->dev);
>  
>  	return 0;
>  
> @@ -5771,8 +5768,6 @@ static void __devexit e1000_remove(struc
>  	struct e1000_adapter *adapter = netdev_priv(netdev);
>  	bool down = test_bit(__E1000_DOWN, &adapter->state);
>  
> -	pm_runtime_get_sync(&pdev->dev);
> -
>  	/*
>  	 * flush_scheduled work may reschedule our watchdog task, so
>  	 * explicitly disable watchdog tasks from being rescheduled
> @@ -5797,11 +5792,8 @@ static void __devexit e1000_remove(struc
>  		clear_bit(__E1000_DOWN, &adapter->state);
>  	unregister_netdev(netdev);
>  
> -	if (pci_dev_run_wake(pdev)) {
> -		pm_runtime_disable(&pdev->dev);
> -		pm_runtime_set_suspended(&pdev->dev);
> -	}
> -	pm_runtime_put_noidle(&pdev->dev);
> +	if (pci_dev_run_wake(pdev))
> +		pm_runtime_get_noresume(&pdev->dev);
>  
>  	/*
>  	 * Release control of h/w to f/w.  If f/w is AMT enabled, this
> Index: usb-2.6/drivers/net/r8169.c
> ===================================================================
> --- usb-2.6.orig/drivers/net/r8169.c
> +++ usb-2.6/drivers/net/r8169.c
> @@ -3208,11 +3208,8 @@ rtl8169_init_one(struct pci_dev *pdev, c
>  
>  	device_set_wakeup_enable(&pdev->dev, tp->features & RTL_FEATURE_WOL);
>  
> -	if (pci_dev_run_wake(pdev)) {
> -		pm_runtime_set_active(&pdev->dev);
> -		pm_runtime_enable(&pdev->dev);
> -	}
> -	pm_runtime_idle(&pdev->dev);
> +	if (pci_dev_run_wake(pdev))
> +		pm_runtime_put_noidle(&pdev->dev);
>  
>  out:
>  	return rc;
> @@ -3235,17 +3232,12 @@ static void __devexit rtl8169_remove_one
>  	struct net_device *dev = pci_get_drvdata(pdev);
>  	struct rtl8169_private *tp = netdev_priv(dev);
>  
> -	pm_runtime_get_sync(&pdev->dev);
> -
>  	flush_scheduled_work();
>  
>  	unregister_netdev(dev);
>  
> -	if (pci_dev_run_wake(pdev)) {
> -		pm_runtime_disable(&pdev->dev);
> -		pm_runtime_set_suspended(&pdev->dev);
> -	}
> -	pm_runtime_put_noidle(&pdev->dev);
> +	if (pci_dev_run_wake(pdev))
> +		pm_runtime_get_noresume(&pdev->dev);
>  
>  	/* restore original MAC address */
>  	rtl_rar_set(tp, dev->perm_addr);
