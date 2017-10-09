From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal/intel_powerclamp: pr_err()/pr_info() strings
 should end with newlines
Date: Mon, 9 Oct 2017 14:33:14 +0200
Message-ID: <7555b065-f4de-2988-283b-b6800ce189ab@linaro.org>
References: <277b8d12fc6980ec2ffd039a872f681ec0e49c19.1507549738.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:52311 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbdJIMdR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Oct 2017 08:33:17 -0400
Received: by mail-wm0-f49.google.com with SMTP id k4so23021364wmc.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Oct 2017 05:33:16 -0700 (PDT)
In-Reply-To: <277b8d12fc6980ec2ffd039a872f681ec0e49c19.1507549738.git.arvind.yadav.cs@gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/10/2017 13:51, Arvind Yadav wrote:
> pr_err()/pr_info() messages should end with a new-line to avoid
> other messages being concatenated.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/thermal/intel_powerclamp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
> index d718cd1..4540e89 100644
> --- a/drivers/thermal/intel_powerclamp.c
> +++ b/drivers/thermal/intel_powerclamp.c
> @@ -675,13 +675,13 @@ static int __init powerclamp_probe(void)
>  {
>  
>  	if (!x86_match_cpu(intel_powerclamp_ids)) {
> -		pr_err("CPU does not support MWAIT");
> +		pr_err("CPU does not support MWAIT\n");
>  		return -ENODEV;
>  	}
>  
>  	/* The goal for idle time alignment is to achieve package cstate. */
>  	if (!has_pkg_state_counter()) {
> -		pr_info("No package C-state available");
> +		pr_info("No package C-state available\n");
>  		return -ENODEV;
>  	}


Hi Arvind,

you are sending these fixes for all the drivers around. There is a way
to fix this once and for all: use the coccinelle tools [1], add the
script in the changelog with a big patchset and add the script in the
coccinelle scripts directory [2].

  -- Daniel

[1] Documentation/dev-tools/coccinelle.rst
[2] scripts/coccinelle/misc


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
