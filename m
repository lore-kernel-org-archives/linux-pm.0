From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 6/8] PM / ACPI: Enable the runtime PM centric approach for system sleep
Date: Tue, 29 Aug 2017 17:27:55 +0200
Message-ID: <2855684.NY3Ly9PzrE@aspire.rjw.lan>
References: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org> <1504018610-10822-7-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42624 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751299AbdH2Pgg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 11:36:36 -0400
In-Reply-To: <1504018610-10822-7-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org

On Tuesday, August 29, 2017 4:56:48 PM CEST Ulf Hansson wrote:
> This change enables the ACPI PM domain to cope with drivers that deploys
> the runtime PM centric path for system sleep.

[cut]

> @@ -1052,11 +1066,20 @@ EXPORT_SYMBOL_GPL(acpi_subsys_complete);
>   * @dev: Device to handle.
>   *
>   * Follow PCI and resume devices suspended at run time before running their
> - * system suspend callbacks.
> + * system suspend callbacks. However, try to avoid it in case the runtime PM
> + * centric path is used for the device and then trust the driver to do the
> + * right thing.
>   */
>  int acpi_subsys_suspend(struct device *dev)
>  {
> -	pm_runtime_resume(dev);
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +
> +	if (!adev)
> +		return 0;
> +
> +	if (!dev_pm_is_rpm_sleep(dev) || acpi_dev_needs_resume(dev, adev))
> +		pm_runtime_resume(dev);
> +
>  	return pm_generic_suspend(dev);
>  }
>  EXPORT_SYMBOL_GPL(acpi_subsys_suspend);

Well, I tried to avoid calling acpi_dev_needs_resume() for multiple times
and that's why I added the update_state thing.

Moreover, the is_rpm_sleep flag here has to mean not only that
direct_complete should not be used with the device, but also that its driver
is fine with not resuming it.

IMO it is not a good idea to use one flag for these two different things at the
same time at all.

Thanks,
Rafael
