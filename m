From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: fix comment about return value of
 cpufreq_register_driver()
Date: Mon, 22 Feb 2016 10:54:46 +0530
Message-ID: <20160222052446.GD28226@vireshk-i7>
References: <1456026601-31282-1-git-send-email-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35146 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbcBVFZF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 00:25:05 -0500
Received: by mail-pa0-f50.google.com with SMTP id ho8so87229893pac.2
        for <linux-pm@vger.kernel.org>; Sun, 21 Feb 2016 21:25:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456026601-31282-1-git-send-email-ebiggers3@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 20-02-16, 21:50, Eric Biggers wrote:
> The comment has been incorrect since commit 4dea5806d332
> ("cpufreq: return EEXIST instead of EBUSY for second registering").
> 
> Signed-off-by: Eric Biggers <ebiggers3@gmail.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e979ec7..bfefc91 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2384,7 +2384,7 @@ EXPORT_SYMBOL_GPL(cpufreq_boost_enabled);
>   * submitted by the CPU Frequency driver.
>   *
>   * Registers a CPU Frequency driver to this core code. This code
> - * returns zero on success, -EBUSY when another driver got here first
> + * returns zero on success, -EEXIST when another driver got here first
>   * (and isn't unregistered in the meantime).
>   *
>   */

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
