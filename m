From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH -next] PM / OPP: Make _find_opp_table_unlocked() static
Date: Tue, 7 Feb 2017 09:44:22 +0530
Message-ID: <20170207041422.GM3131@vireshk-i7>
References: <20170206142955.790-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34429 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbdBGEOZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 23:14:25 -0500
Received: by mail-pg0-f46.google.com with SMTP id 14so34651989pgg.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2017 20:14:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170206142955.790-1-weiyj.lk@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wei Yongjun <weiyongjun1@huawei.com>, linux-pm@vger.kernel.org

On 06-02-17, 14:29, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fixes the following sparse warning:
> 
> drivers/base/power/opp/core.c:49:18: warning:
>  symbol '_find_opp_table_unlocked' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/base/power/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index 541d32c..91ec323 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -46,7 +46,7 @@ static struct opp_device *_find_opp_dev(const struct device *dev,
>  	return NULL;
>  }
>  
> -struct opp_table *_find_opp_table_unlocked(struct device *dev)
> +static struct opp_table *_find_opp_table_unlocked(struct device *dev)
>  {
>  	struct opp_table *opp_table;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
