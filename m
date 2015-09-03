From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] kernel/cpu_pm: fix cpu_cluster_pm_exit comment
Date: Thu, 03 Sep 2015 03:01:07 +0200
Message-ID: <1718450.7CLkaUphqG@vostro.rjw.lan>
References: <1441232337-12615-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45684 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755052AbbICAdZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2015 20:33:25 -0400
In-Reply-To: <1441232337-12615-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

On Wednesday, September 02, 2015 04:18:57 PM Lina Iyer wrote:
> cpu_cluster_pm_exit() must be sent after cpu_cluster_pm_enter() has been
> sent for the cluster and before any cpu_pm_exit() notifications are sent
> for any CPU.
> 
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Acked-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

OK, I'll queue this one up for the next PM pull request.

Thanks!


> ---
>  kernel/cpu_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
> index 9656a3c..009cc9a 100644
> --- a/kernel/cpu_pm.c
> +++ b/kernel/cpu_pm.c
> @@ -180,7 +180,7 @@ EXPORT_SYMBOL_GPL(cpu_cluster_pm_enter);
>   * low power state that may have caused some blocks in the same power domain
>   * to reset.
>   *
> - * Must be called after cpu_pm_exit has been called on all cpus in the power
> + * Must be called after cpu_cluster_pm_enter has been called for the power
>   * domain, and before cpu_pm_exit has been called on any cpu in the power
>   * domain. Notified drivers can include VFP co-processor, interrupt controller
>   * and its PM extensions, local CPU timers context save/restore which
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
