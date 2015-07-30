From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] PM / Domains: Return -EPROBE_DEFER if we fail to init or turn-on domain
Date: Thu, 30 Jul 2015 16:28:24 -0700
Message-ID: <7hvbd11azr.fsf@deeprootsystems.com>
References: <1438070668-19956-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34654 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbbG3X22 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2015 19:28:28 -0400
Received: by pacan13 with SMTP id an13so31015215pac.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2015 16:28:28 -0700 (PDT)
In-Reply-To: <1438070668-19956-1-git-send-email-jonathanh@nvidia.com> (Jon
	Hunter's message of "Tue, 28 Jul 2015 09:04:28 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org

[ sorry for the lag, been on vacation... ]

Hi Jon,

Jon Hunter <jonathanh@nvidia.com> writes:

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

That's a good description of the problem, but doesn't describe the fix
the fix.

Please summarize the solution being implemented here...

> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

... otherwise, patch itself looks fine.  Feel free to add

Acked-by: Kevin Hilman <khilman@linaro.org>
