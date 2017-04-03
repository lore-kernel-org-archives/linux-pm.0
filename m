From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/3] cpuidle: powernv: Avoid a branch in the core
 snooze_loop() loop
Date: Tue, 4 Apr 2017 09:54:17 +1000
Message-ID: <20170404095417.39e62ab3@roar.ozlabs.ibm.com>
References: <20170403215414.16951-1-anton@ozlabs.org>
        <20170403215414.16951-3-anton@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36824 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbdDCXya (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2017 19:54:30 -0400
Received: by mail-pg0-f67.google.com with SMTP id 81so33079573pgh.3
        for <linux-pm@vger.kernel.org>; Mon, 03 Apr 2017 16:54:29 -0700 (PDT)
In-Reply-To: <20170403215414.16951-3-anton@ozlabs.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anton Blanchard <anton@ozlabs.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, rjw@rjwysocki.net, daniel.lezcano@linaro.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org

On Tue,  4 Apr 2017 07:54:14 +1000
Anton Blanchard <anton@ozlabs.org> wrote:

> From: Anton Blanchard <anton@samba.org>
> 
> When in the snooze_loop() we want to take up the least amount of
> resources. On my version of gcc (6.3), we end up with an extra
> branch because it predicts snooze_timeout_en to be false, whereas it
> is almost always true.
> 
> Use likely() to avoid the branch and be a little nicer to the
> other non idle threads on the core.

Patches 2 and 3 look fine. Should they be replicated to cpuidle-pseries.c
as well?

Thanks,
Nick

> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  drivers/cpuidle/cpuidle-powernv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 8c991c254b95..251a60bfa8ee 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -58,7 +58,7 @@ static int snooze_loop(struct cpuidle_device *dev,
>  	ppc64_runlatch_off();
>  	HMT_very_low();
>  	while (!need_resched()) {
> -		if (snooze_timeout_en && get_tb() > snooze_exit_time)
> +		if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time)
>  			break;
>  	}
>  
