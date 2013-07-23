From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] cpuidle: export cpuidle_idle_call symbol
Date: Tue, 23 Jul 2013 23:33:22 +0200
Message-ID: <16375354.KJ7QhjYo9F@vostro.rjw.lan>
References: <1374571681-31911-1-git-send-email-dongsheng.wang@freescale.com> <1374571681-31911-2-git-send-email-dongsheng.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:36411 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932567Ab3GWVXT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Jul 2013 17:23:19 -0400
In-Reply-To: <1374571681-31911-2-git-send-email-dongsheng.wang@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Tuesday, July 23, 2013 05:28:01 PM Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Export cpuidle_idle_call symbol, make this function can be invoked
> in the module.

Why?

Rafael


> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> Branch: pm-cpuidle
> 
>  drivers/cpuidle/cpuidle.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 534320a..d0a61d6 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -168,6 +168,7 @@ int cpuidle_idle_call(void)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(cpuidle_idle_call);
>  
>  /**
>   * cpuidle_install_idle_handler - installs the cpuidle idle loop handler
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
