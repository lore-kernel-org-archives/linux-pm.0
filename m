From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] PM: Update function header for dev_pm_get_subsys_data()
Date: Wed, 04 Feb 2015 15:39:21 +0100
Message-ID: <3077727.Z72p7WD0Qf@vostro.rjw.lan>
References: <1422553145-14798-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52118 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933989AbbBDOQ1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 09:16:27 -0500
In-Reply-To: <1422553145-14798-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>

On Thursday, January 29, 2015 06:39:04 PM Ulf Hansson wrote:
> The commit "PM: Make dev_pm_get_subsys_data() always return 0 on success"
> changed the return value from dev_pm_get_subsys_data(). Let's update the
> comment in the function header to reflect this change as well.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

[1-2/2] queued up for 3.20, thanks!

> ---
>  drivers/base/power/common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index b0f1388..a1ee51d 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -19,8 +19,8 @@
>   * @dev: Device to handle.
>   *
>   * If power.subsys_data is NULL, point it to a new object, otherwise increment
> - * its reference counter.  Return 1 if a new object has been created, otherwise
> - * return 0 or error code.
> + * its reference counter.  Return 0 if new object has been created or refcount
> + * increased, otherwise negative error code.
>   */
>  int dev_pm_get_subsys_data(struct device *dev)
>  {
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
