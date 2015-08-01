From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] PM / Domains: Return -EPROBE_DEFER if we fail to init or turn-on domain
Date: Sat, 01 Aug 2015 02:12:57 +0200
Message-ID: <3210072.Pu2pugj7KG@vostro.rjw.lan>
References: <1438334400-26367-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47059 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752792AbbGaXp6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 19:45:58 -0400
In-Reply-To: <1438334400-26367-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org

On Friday, July 31, 2015 10:20:00 AM Jon Hunter wrote:
> When a device is probed, the function dev_pm_domain_attach() is called
> to see if there is a power-domain that is associated with the device and
> needs to be turned on. If dev_pm_domain_attach() does not return
> -EPROBE_DEFER then the device will be probed.
> 
> For devices using genpd, dev_pm_domain_attach() will call
> genpd_dev_pm_attach(). If genpd_dev_pm_attach() does not find a power
> domain associated with the device then it returns an error code not
> equal to -EPROBE_DEFER to allow the device to be probed. However, if
> genpd_dev_pm_attach() does find a power-domain that is associated with
> the device, then it does not return -EPROBE_DEFER on failure and hence
> the device will still be probed. Furthermore, genpd_dev_pm_attach() does
> not check the error code returned by pm_genpd_poweron() to see if the
> power-domain was turned on successfully.
> 
> Fix this by checking the return code from pm_genpd_poweron() and
> returning -EPROBE_DEFER from genpd_dev_pm_attach on failure, if there
> is a power-domain associated with the device.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Kevin Hilman <khilman@linaro.org>

Queued up for 4.3, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
