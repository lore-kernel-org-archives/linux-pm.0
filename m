From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 1/9] ACPI / PM: Let acpi_dev_pm_detach() return an
 error code
Date: Sun, 24 Aug 2014 00:45:15 +0200
Message-ID: <20140823224515.GA19046@xo-6d-61-c0.localdomain>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
 <1409838756-31963-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35040 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991AbaIDPbj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 11:31:39 -0400
Content-Disposition: inline
In-Reply-To: <1409838756-31963-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>

On Thu 2014-09-04 15:52:28, Ulf Hansson wrote:
> To give callers the option of acting on a errors while removing the
> pm_domain ops for the device in the ACPI PM domain, let
> acpi_dev_pm_detach() return an int to provide the error code.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>

Acked-by: Pavel Machek <Pavel@ucw.cz>

> ---
>  drivers/acpi/device_pm.c | 8 +++++++-
>  include/linux/acpi.h     | 7 +++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 67075f8..0d52ce1 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1055,6 +1055,8 @@ static struct dev_pm_domain acpi_general_pm_domain = {
>   *
>   * Callers must ensure proper synchronization of this function with power
>   * management callbacks.
> + *
> + * Returns 0 on successfully attached PM domain or negative error code.
>   */
>  int acpi_dev_pm_attach(struct device *dev, bool power_on)
>  {
> @@ -1087,8 +1089,10 @@ EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
>   *
>   * Callers must ensure proper synchronization of this function with power
>   * management callbacks.
> + *
> + * Returns 0 on successfully detached PM domain or negative error code.
>   */
> -void acpi_dev_pm_detach(struct device *dev, bool power_off)
> +int acpi_dev_pm_detach(struct device *dev, bool power_off)
>  {
>  	struct acpi_device *adev = ACPI_COMPANION(dev);
>  
> @@ -1107,7 +1111,9 @@ void acpi_dev_pm_detach(struct device *dev, bool power_off)
>  			acpi_device_wakeup(adev, ACPI_STATE_S0, false);
>  			acpi_dev_pm_low_power(dev, adev, ACPI_STATE_S0);
>  		}
> +		return 0;
>  	}
> +	return -EINVAL;
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_pm_detach);
>  #endif /* CONFIG_PM */
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 807cbc4..c83cca5 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -587,7 +587,7 @@ static inline int acpi_subsys_freeze(struct device *dev) { return 0; }
>  #if defined(CONFIG_ACPI) && defined(CONFIG_PM)
>  struct acpi_device *acpi_dev_pm_get_node(struct device *dev);
>  int acpi_dev_pm_attach(struct device *dev, bool power_on);
> -void acpi_dev_pm_detach(struct device *dev, bool power_off);
> +int acpi_dev_pm_detach(struct device *dev, bool power_off);
>  #else
>  static inline struct acpi_device *acpi_dev_pm_get_node(struct device *dev)
>  {
> @@ -597,7 +597,10 @@ static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
>  {
>  	return -ENODEV;
>  }
> -static inline void acpi_dev_pm_detach(struct device *dev, bool power_off) {}
> +static inline int acpi_dev_pm_detach(struct device *dev, bool power_off)
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  #ifdef CONFIG_ACPI
> -- 
> 1.9.1

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
