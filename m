From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] PM / OPP: Use snprintf to avoid kasprintf and kfree
Date: Thu, 21 Sep 2017 10:48:32 -0700
Message-ID: <20170921174832.GA17243@ubuntu>
References: <6cdcf0c59a9a045941188356a2c4973c876c9fc6.1505972576.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:49955 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751636AbdIURse (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2017 13:48:34 -0400
Received: by mail-pg0-f45.google.com with SMTP id m30so3903334pgn.6
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2017 10:48:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6cdcf0c59a9a045941188356a2c4973c876c9fc6.1505972576.git.arvind.yadav.cs@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 21-09-17, 11:15, Arvind Yadav wrote:
> Use snprintf to avoid unnecessary initializations, avoid calling kfree.
> 

Suggested-by: Joe Perches <joe@perches.com>

> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2:
>              Remove kasprintf instead of error checking.
> 
>  drivers/base/power/opp/debugfs.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
> index 81cf120..a2fa785 100644
> --- a/drivers/base/power/opp/debugfs.c
> +++ b/drivers/base/power/opp/debugfs.c
> @@ -41,16 +41,15 @@ static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
>  {
>  	struct dentry *d;
>  	int i;
> -	char *name;
>  
>  	for (i = 0; i < opp_table->regulator_count; i++) {
> -		name = kasprintf(GFP_KERNEL, "supply-%d", i);
> +		char name[15];
> +
> +		snprintf(name, sizeof(name), "supply-%d", i);
>  
>  		/* Create per-opp directory */
>  		d = debugfs_create_dir(name, pdentry);
>  
> -		kfree(name);
> -
>  		if (!d)
>  			return false;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
