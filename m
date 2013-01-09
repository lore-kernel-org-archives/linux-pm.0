From: Tushar Behera <tushar.behera@linaro.org>
Subject: Re: [PATCH] clk: remove unreachable code
Date: Wed, 09 Jan 2013 11:20:15 +0530
Message-ID: <50ED0517.5090907@linaro.org>
References: <1357650191-30842-1-git-send-email-rajagopal.venkat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1357650191-30842-1-git-send-email-rajagopal.venkat@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajagopal Venkat <rajagopal.venkat@linaro.org>
Cc: mturquette@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 01/08/2013 06:33 PM, Rajagopal Venkat wrote:
> while reparenting a clock, NULL check is done for clock in
> consideration and its new parent. So re-check is not required.
> If done, else part becomes unreachable.
> 
> Signed-off-by: Rajagopal Venkat <rajagopal.venkat@linaro.org>
> ---
>  drivers/clk/clk.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 251e45d..f896584 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1048,10 +1048,7 @@ void __clk_reparent(struct clk *clk, struct clk *new_parent)
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
> 

The same logic holds good for following piece of code too.

1060 |-------if (new_parent)
1061 |-------|-------new_parent_d = new_parent->dentry;
1062 |-------else
1063 |-------|-------new_parent_d = orphandir;


-- 
Tushar Behera
