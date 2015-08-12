From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 4/9] kernel/cpu_pm: fix cpu_cluster_pm_exit comment
Date: Wed, 12 Aug 2015 13:13:15 -0700
Message-ID: <7htws4mfj8.fsf@deeprootsystems.com>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
	<1438731339-58317-5-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34591 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbbHLUNR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 16:13:17 -0400
Received: by pawu10 with SMTP id u10so21339646paw.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2015 13:13:17 -0700 (PDT)
In-Reply-To: <1438731339-58317-5-git-send-email-lina.iyer@linaro.org> (Lina
	Iyer's message of "Tue, 4 Aug 2015 17:35:34 -0600")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, Nicolas Pitre <nicolas.pitre@linaro.org>

Lina Iyer <lina.iyer@linaro.org> writes:

> cpu_cluster_pm_exit() must be sent after cpu_cluster_pm_enter() has been
> sent for the cluster and before any cpu_pm_exit() notifications are sent
> for any CPU.
>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

Acked-by: Kevin Hilman <khilman@linaro.org>

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
