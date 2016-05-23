From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 2/4] PM / Runtime: Prevent re-resuming devices in pm_runtime_force_resume()
Date: Mon, 23 May 2016 14:30:09 -0700
Message-ID: <m27fekmpi6.fsf@baylibre.com>
References: <1463485296-22742-1-git-send-email-ulf.hansson@linaro.org>
	<1463485296-22742-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35982 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbcEWVaM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 May 2016 17:30:12 -0400
Received: by mail-pa0-f52.google.com with SMTP id bt5so65767596pac.3
        for <linux-pm@vger.kernel.org>; Mon, 23 May 2016 14:30:11 -0700 (PDT)
In-Reply-To: <1463485296-22742-3-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Tue, 17 May 2016 13:41:34 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> If the device has already been resumed before pm_runtime_force_resume() is
> invoked, prevent calling the ->runtime_resume() callback for the device,
> as it's not the expected behaviour from the subsystem/driver.

I'm not following how this description matches the code.

Based on the code, it seems like it should say "If the device has not
been runtime suspended, don't runtime resume it."   IOW, "device has
already been resumed" is not what pm_runtime_status_suspended() is
checking for.

Kevin

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/runtime.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index b746904..09e4eb1 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1506,6 +1506,9 @@ int pm_runtime_force_resume(struct device *dev)
>  		goto out;
>  	}
>  
> +	if (!pm_runtime_status_suspended(dev))
> +		goto out;
> +
>  	ret = pm_runtime_set_active(dev);
>  	if (ret)
>  		goto out;
