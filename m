From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Fix typo modifcation -> modification
Date: Thu, 24 Sep 2015 13:58:21 -0700
Message-ID: <CAKohpokkc-_PK1i+qVEfG4+W-jA-82T2P=w+tofWz2fYWX0NjQ@mail.gmail.com>
References: <1443122924-17017-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35099 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbbIXU6W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2015 16:58:22 -0400
Received: by vkao3 with SMTP id o3so44728815vka.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2015 13:58:22 -0700 (PDT)
In-Reply-To: <1443122924-17017-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 24 September 2015 at 12:28, Stephen Boyd <sboyd@codeaurora.org> wrote:
> Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/base/power/opp/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index 8a72f0e586e8..62b918144b5b 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -961,7 +961,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_add);
>   * share a common logic which is isolated here.
>   *
>   * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
> - * copy operation, returns 0 if no modifcation was done OR modification was
> + * copy operation, returns 0 if no modification was done OR modification was
>   * successful.
>   *
>   * Locking: The internal device_opp and opp structures are RCU protected.
> @@ -1049,7 +1049,7 @@ unlock:
>   * mutex locking or synchronize_rcu() blocking calls cannot be used.
>   *
>   * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
> - * copy operation, returns 0 if no modifcation was done OR modification was
> + * copy operation, returns 0 if no modification was done OR modification was
>   * successful.
>   */
>  int dev_pm_opp_enable(struct device *dev, unsigned long freq)
> @@ -1075,7 +1075,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_enable);
>   * mutex locking or synchronize_rcu() blocking calls cannot be used.
>   *
>   * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
> - * copy operation, returns 0 if no modifcation was done OR modification was
> + * copy operation, returns 0 if no modification was done OR modification was
>   * successful.
>   */
>  int dev_pm_opp_disable(struct device *dev, unsigned long freq)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
