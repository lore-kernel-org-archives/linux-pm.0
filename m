From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] Driver core: Set initial runtime PM states at probe err and driver unbind
Date: Wed, 18 Nov 2015 02:44:54 +0100
Message-ID: <24970376.MRZAreB2rt@vostro.rjw.lan>
References: <1447770929-16652-1-git-send-email-ulf.hansson@linaro.org> <1447770929-16652-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57741 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751702AbbKRBPZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 20:15:25 -0500
In-Reply-To: <1447770929-16652-3-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Eduardo Valentin <edubezval@gmail.com>

On Tuesday, November 17, 2015 03:35:29 PM Ulf Hansson wrote:
> There are two common expectations among several subsystems/drivers that
> deploys runtime PM support, but which isn't met by the driver core.
> 
> Expectation 1)
> At ->probe() the subsystem/driver expects the runtime PM status of the
> device to be RPM_SUSPENDED, which is the initial status being assigned at
> device registration.
> 
> This expectation is especially common among some of those subsystems/
> drivers that manages devices with an attached PM domain, as those requires
> the ->runtime_resume() callback at the PM domain level to be invoked
> during ->probe().
> 
> Moreover these subsystems/drivers entirely relies on runtime PM resources
> being managed at the PM domain level, thus don't implement their own set
> of runtime PM callbacks.
> 
> These are two scenarios that suffers from this unmet expectation.
> 
> i) A failed ->probe() sequence requests probe deferral:
> 
> ->probe()
>   ...
>   pm_runtime_enable()
>   pm_runtime_get_sync()
>   ...
> 
> err:
>   pm_runtime_put()
>   pm_runtime_disable()
>   ...
> 
> As there are no guarantees that such sequence turns the runtime PM status
> of the device into RPM_SUSPENDED, the re-trying ->probe() may start with
> the status in RPM_ACTIVE.
> 
> In such case the runtime PM core won't invoke the ->runtime_resume()
> callback because of a pm_runtime_get_sync(), as it considers the device to
> be already runtime resumed.
> 
> ii) A driver re-bind sequence:
> 
> At driver unbind, the subsystem/driver's >remove() callback invokes a
> sequence of runtime PM APIs, to undo actions during ->probe() and to put
> the device into low power state.
> 
> ->remove()
>   ...
>   pm_runtime_put()
>   pm_runtime_disable()
>   ...
> 
> Similar as in the failing ->probe() case, this sequence don't guarantee
> the runtime PM status of the device to turn into RPM_SUSPENDED.
> 
> Trying to re-bind the driver thus causes the same issue as when re-trying
> ->probe(), in the probe deferral scenario.
> 
> Expectation 2)
> Drivers that invokes the pm_runtime_irq_safe() API during ->probe(),
> triggers the runtime PM core to increase the usage count for the device's
> parent and permanently make it runtime resumed.
> 
> The usage count is only dropped at device removal, which also allows it to
> be runtime suspended again.
> 
> A re-trying ->probe() repeats the call to pm_runtime_irq_safe() and thus
> once more triggers the usage count of the device's parent to be increased.
> 
> This leads to not only an imbalance issue of the usage count of the
> device's parent, but also to keep it runtime resumed permanently even if
> ->probe() fails.
> 
> To address these issues, let's change the policy of the driver core to
> meet these expectations. More precisely, at ->probe() failures and driver
> unbind, restore the initial states of runtime PM.
> 
> Although to still allow subsystem's to control PM for devices that doesn't
> ->probe() successfully, don't restore the initial states unless runtime PM
> is disabled.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/dd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index a641cf3..8402e45 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -340,6 +340,7 @@ probe_failed:
>  	dev_set_drvdata(dev, NULL);
>  	if (dev->pm_domain && dev->pm_domain->dismiss)
>  		dev->pm_domain->dismiss(dev);
> +	pm_runtime_remove(dev, false);
>  
>  	switch (ret) {
>  	case -EPROBE_DEFER:
> @@ -695,6 +696,7 @@ static void __device_release_driver(struct device *dev)
>  		dev_set_drvdata(dev, NULL);
>  		if (dev->pm_domain && dev->pm_domain->dismiss)
>  			dev->pm_domain->dismiss(dev);
> +		pm_runtime_remove(dev, false);
>  
>  		klist_remove(&dev->p->knode_driver);
>  		if (dev->bus)
> 

Please fold this into the other patch (after changing it as suggested by
Alan).  Otherwise it is not entirely clear what happens here without looking
at that patch too.

Thanks,
Rafael

