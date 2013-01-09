From: Tushar Behera <tushar.behera@linaro.org>
Subject: Re: [PATCH] clk: remove unreachable code
Date: Wed, 09 Jan 2013 12:05:30 +0530
Message-ID: <50ED0FB2.4060007@linaro.org>
References: <1357650191-30842-1-git-send-email-rajagopal.venkat@linaro.org> <1357712988-22317-1-git-send-email-rajagopal.venkat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35000 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845Ab3AIGfi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jan 2013 01:35:38 -0500
Received: by mail-pa0-f44.google.com with SMTP id hz11so828093pad.17
        for <linux-pm@vger.kernel.org>; Tue, 08 Jan 2013 22:35:37 -0800 (PST)
In-Reply-To: <1357712988-22317-1-git-send-email-rajagopal.venkat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajagopal Venkat <rajagopal.venkat@linaro.org>
Cc: mturquette@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/09/2013 11:59 AM, Rajagopal Venkat wrote:
> while reparenting a clock, NULL check is done for clock in
> consideration and its new parent. So re-check is not required.
> If done, else part becomes unreachable.
> 
> Signed-off-by: Rajagopal Venkat <rajagopal.venkat@linaro.org>
> ---

It is good to have revision history of the patches (version number and
changelog).

>  drivers/clk/clk.c |   13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 251e45d..1c4097c 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1040,7 +1040,6 @@ void __clk_reparent(struct clk *clk, struct clk *new_parent)
>  {
>  #ifdef CONFIG_COMMON_CLK_DEBUG
>  	struct dentry *d;
> -	struct dentry *new_parent_d;
>  #endif
>  
>  	if (!clk || !new_parent)
> @@ -1048,22 +1047,14 @@ void __clk_reparent(struct clk *clk, struct clk *new_parent)
>  
>  	hlist_del(&clk->child_node);
>  
> -	if (new_parent)
> -		hlist_add_head(&clk->child_node, &new_parent->children);
> -	else
> -		hlist_add_head(&clk->child_node, &clk_orphan_list);
> +	hlist_add_head(&clk->child_node, &new_parent->children);
>  
>  #ifdef CONFIG_COMMON_CLK_DEBUG
>  	if (!inited)
>  		goto out;
>  
> -	if (new_parent)
> -		new_parent_d = new_parent->dentry;
> -	else
> -		new_parent_d = orphandir;
> -
>  	d = debugfs_rename(clk->dentry->d_parent, clk->dentry,
> -			new_parent_d, clk->name);
> +			new_parent->dentry, clk->name);
>  	if (d)
>  		clk->dentry = d;
>  	else
> 


-- 
Tushar Behera
