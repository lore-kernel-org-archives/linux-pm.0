From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 8/9] mmmc: core: Keep PM domain powered during ->probe()
 of SDIO func driver
Date: Fri, 13 Mar 2015 16:10:14 +0000
Message-ID: <20150313161014.GR8656@n2100.arm.linux.org.uk>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
 <1426261429-31883-9-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:43390 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbbCMQKX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 12:10:23 -0400
Content-Disposition: inline
In-Reply-To: <1426261429-31883-9-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org

On Fri, Mar 13, 2015 at 04:43:48PM +0100, Ulf Hansson wrote:
> To sucessfully probe some devices their corresponding PM domains may
> need to be powered.
> 
> Use the dev_pm_domain_get|put() APIs, to control the behavior of the PM
> domain.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio_bus.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index 71357b8..0d89b4b 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -320,7 +320,14 @@ int sdio_add_func(struct sdio_func *func)
>  	if (ret)
>  		return ret;
>  
> +	ret = dev_pm_domain_get(func->dev.pm_domain);
> +	if (ret) {
> +		dev_pm_domain_detach(&func->dev, false);
> +		return ret;
> +	}
> +
>  	ret = device_add(&func->dev);
> +	dev_pm_domain_put(func->dev.pm_domain);

This is broken.  It assumes that the device will be probed in device_add().
That's not always the case.  Come on Ulf, I'm dismayed at you producing
bad and fragile patches like this.  You are the apparent maintainer for
several important subsystems, and you are putting yourself up for more,
yet you don't seem to know the basics about the kernel infrastructure.
That makes you dangerous.

Look, device_add() adds the device to the list of available devices,
publishes it in sysfs, triggers a uevent, and tries to find a driver to
bind it to.

If it doesn't find a driver already registered in the kernel, that could
be because the required driver is a module.  In that case, device_add()
will already have returned.

At some point later, the module will be loaded by user space, and that
will cause the list of devices to be scanned, looking for devices which
the newly registered driver can bind to.  With your code above, these
will _not_ result in the PM domain being "got" before probing.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
