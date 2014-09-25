From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 01/27] PM: Add helper pm_runtime_last_busy_and_autosuspend()
Date: Thu, 25 Sep 2014 10:13:55 +0200
Message-ID: <CAPDyKFpcUPkx5-YCbjKBCLA7MrGoq_szVLWv6B+AQfU8aJBJ4A@mail.gmail.com>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
	<1411575342-31048-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:51420 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbaIYIN4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Sep 2014 04:13:56 -0400
Received: by mail-qa0-f53.google.com with SMTP id cm18so4262552qab.12
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2014 01:13:55 -0700 (PDT)
In-Reply-To: <1411575342-31048-2-git-send-email-vinod.koul@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, subhransu.s.prusty@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

On 24 September 2014 18:14, Vinod Koul <vinod.koul@intel.com> wrote:
> From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
>
> pm_runtime_mark_last_busy and pm_runtime_put_autosuspend are used together
> in quite a lot of places. Add a helper for these.
> Also updated Documentation for this
>
> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>  Documentation/power/runtime_pm.txt |    4 ++++
>  include/linux/pm_runtime.h         |    6 ++++++
>  2 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
> index f32ce54..5d9565b 100644
> --- a/Documentation/power/runtime_pm.txt
> +++ b/Documentation/power/runtime_pm.txt
> @@ -490,6 +490,10 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
>        power.use_autosuspend isn't set, otherwise returns the expiration time
>        in jiffies
>
> +   int pm_runtime_last_busy_and_autosuspend(struct device *dev);
> +    - invoke pm_runtime_mark_last_busy(dev) and then run
> +      pm_runtime_put_autosuspend(dev) and return its result
> +
>  It is safe to execute the following helper functions from interrupt context:
>
>  pm_request_idle()
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 367f49b..256ec50 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -277,4 +277,10 @@ static inline void pm_runtime_dont_use_autosuspend(struct device *dev)
>         __pm_runtime_use_autosuspend(dev, false);
>  }
>
> +static inline int pm_runtime_last_busy_and_autosuspend(struct device *dev)

This doesn't help code readability I think. The function name is quite
long as Pavel also pointed out. :-)

And, I also lack the "put" prefix, following the other functions in
the runtime PM API - which would make the name even longer. :-)

Kind regards
Uffe
