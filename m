From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] PM / OPP: optimize dev_pm_opp_set_rate() performance
 a bit
Date: Mon, 25 Jul 2016 15:34:10 -0700
Message-ID: <20160725223410.GF25667@ubuntu>
References: <1469427076-2078-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34051 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754954AbcGYWeR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jul 2016 18:34:17 -0400
Received: by mail-pf0-f177.google.com with SMTP id p64so68258240pfb.1
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2016 15:34:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1469427076-2078-1-git-send-email-jszhang@marvell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 25-07-16, 14:11, Jisheng Zhang wrote:
> In dev_pm_opp_set_rate(), _find_opp_table() is called 4 times: once by
> _get_opp_clk(), once by dev_pm_opp_set_rate() itself, and twice by
> dev_pm_opp_find_freq_ceil(). If there are several opp_tables in the
> system, three times of opp table finding is a big waste. This patch
> reduced the call of _find_opp_table() to twice.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
> Since v2:
>  - fix gcc warnings
> 
> Since v1:
>  - avoid opp_table pointer usage after the rcu_read_unlock() as pointed
>    out by Viresh, thus we can only reduced the call of _find_opp_table
>    to twice.
> 
>  drivers/base/power/opp/core.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
