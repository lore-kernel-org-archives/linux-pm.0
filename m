From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] PM / clock_ops: Print acquired clock name in addition
 to con_id
Date: Thu, 4 Jun 2015 11:27:01 +0200
Message-ID: <CAPDyKFrXNOCKg0qsbzCbVnk5d37wBGw-A_Yo1ejv1KjPOVkNcg@mail.gmail.com>
References: <1432917331-3285-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33682 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbbFDJ1C (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 05:27:02 -0400
Received: by qgfa63 with SMTP id a63so14724959qgf.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2015 02:27:02 -0700 (PDT)
In-Reply-To: <1432917331-3285-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Grygorii Strashko <Grygorii.Strashko@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-clk@vger.kernel.org

On 29 May 2015 at 18:35, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> Currently the con_id of the acquired clock is printed for debugging
> purposes.  But in several cases, the con_id is NULL, which doesn't
> provide much debugging information when printed.  These cases are:
>   - When explicitly passing a NULL con_id (which means the first clock
>     tied to the device, if available),
>   - When not using pm_clk_add(), but pm_clk_add_clk() (which takes a
>     "struct clk *" directly).
>
> Hence print the actual clock name in addition to (and not instead of;
> thanks Grygorii Strashko!) the con_id.
>
> Note that the clock name is not available with legacy clock frameworks,
> and the hex pointer address will be printed instead.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
> This is v2 of "PM / clock_ops: Print acquired clock name instead of
> con_id".
>
> v2:
>   - Print both clock and con_id, as suggested by Grygorii Strashko
>     <grygorii.strashko@linaro.org>.
> ---
>  drivers/base/power/clock_ops.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> index 442ce010559bf531..acef9f9f759a2530 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -68,7 +68,8 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
>         } else {
>                 clk_prepare(ce->clk);
>                 ce->status = PCE_STATUS_ACQUIRED;
> -               dev_dbg(dev, "Clock %s managed by runtime PM.\n", ce->con_id);
> +               dev_dbg(dev, "Clock %pC con_id %s managed by runtime PM.\n",

Oh, I didn't know "%pC" handle the clock name printing. Cool! :-)

> +                       ce->clk, ce->con_id);
>         }
>  }
>
> --
> 1.9.1
>

Kind regards
Uffe
