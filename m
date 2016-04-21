From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Runtime: Defer resuming of the device in pm_runtime_force_resume()
Date: Thu, 21 Apr 2016 21:23:27 +0200
Message-ID: <1575769.B1ataT0Qqy@vostro.rjw.lan>
References: <1461234842-22820-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60761 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751761AbcDUTUf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 15:20:35 -0400
In-Reply-To: <1461234842-22820-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lina Iyer <lina.iyer@linaro.org>, Andy Gross <andy.gross@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-arm-kernel@lists.infradead.org

On Thursday, April 21, 2016 12:34:02 PM Ulf Hansson wrote:
> When the pm_runtime_force_suspend|resume() helpers were invented, we still
> had CONFIG_PM_RUNTIME and CONFIG_PM_SLEEP as separate Kconfig options.
> 
> To make sure these helpers worked for all combinations and without
> introducing too much of complexity, the device was always resumed in
> pm_runtime_force_resume().
> 
> More precisely, when CONFIG_PM_SLEEP was set and CONFIG_PM_RUNTIME was
> unset, we needed to resume the device as the subsystem/driver couldn't
> rely on using runtime PM to do it.
> 
> As the CONFIG_PM_RUNTIME option was merged into CONFIG_PM a while ago, it
> removed this combination, of using CONFIG_PM_SLEEP without the earlier
> CONFIG_PM_RUNTIME.
> 
> For this reason we can now rely on the subsystem/driver to use runtime PM
> to resume the device, instead of forcing that to be done in all cases. In
> other words, let's defer this to a later point when it's actually needed.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Note, this patch is based upon another not yet queued patch [1]. The reason is
> simply because that [1] is a more important patch as it fixes a problem. It was
> posted to linux-pm April 8th and I expect it (or a new revision of it) to be
> applied before $subject patch.
> 
> [1]
> https://patchwork.kernel.org/patch/8782851
> 
> ---
>  drivers/base/power/runtime.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index b746904..a190ca0 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1506,6 +1506,17 @@ int pm_runtime_force_resume(struct device *dev)
>  		goto out;
>  	}
>  
> +	/*
> +	 * The PM core increases the runtime PM usage count in the system PM
> +	 * prepare phase. If the count is greather than 1 at this point, someone
> +	 * else has also increased it. In such case, let's make sure to runtime
> +	 * resume the device as that is likely what is expected. In other case

That doesn't sound quite right.  I'd rather say "In that case, invoke the
runtime resume callback for the device as that is likely what is expected" here.

> +	 * we trust the subsystem/driver to runtime resume the device when it's
> +	 * actually needed.
> +	 */
> +	if (atomic_read(&dev->power.usage_count) < 2)
> +		goto out;
> +
>  	ret = pm_runtime_set_active(dev);
>  	if (ret)
>  		goto out;
> 

Thanks,
Rafael

