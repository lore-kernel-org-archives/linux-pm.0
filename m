From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 31/41] Documentation: power: fix spelling mistake
Date: Mon, 25 Apr 2016 12:16:51 +0530
Message-ID: <20160425064651.GB32183@vireshk-i7>
References: <1461543878-3639-1-git-send-email-eric@engestrom.ch>
 <1461566229-4717-1-git-send-email-eric@engestrom.ch>
 <1461566229-4717-5-git-send-email-eric@engestrom.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34818 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbcDYGqz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 02:46:55 -0400
Received: by mail-pf0-f180.google.com with SMTP id n1so64237188pfn.2
        for <linux-pm@vger.kernel.org>; Sun, 24 Apr 2016 23:46:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1461566229-4717-5-git-send-email-eric@engestrom.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eric Engestrom <eric@engestrom.ch>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org

On 25-04-16, 07:36, Eric Engestrom wrote:
> Signed-off-by: Eric Engestrom <eric@engestrom.ch>
> ---
>  Documentation/power/opp.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/power/opp.txt b/Documentation/power/opp.txt
> index c6279c2..1721a86 100644
> --- a/Documentation/power/opp.txt
> +++ b/Documentation/power/opp.txt
> @@ -146,7 +146,7 @@ dev_pm_opp_find_freq_exact - Search for an OPP based on an *exact* frequency and
>  	 rcu_read_lock();
>  	 opp = dev_pm_opp_find_freq_exact(dev, 1000000000, false);
>  	 rcu_read_unlock();
> -	 /* dont operate on the pointer.. just do a sanity check.. */
> +	 /* don't operate on the pointer.. just do a sanity check.. */
>  	 if (IS_ERR(opp)) {
>  		pr_err("frequency not disabled!\n");
>  		/* trigger appropriate actions.. */

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
