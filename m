From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] intel_idle: make intel_idle_state_table_update() static
Date: Wed, 23 Mar 2016 16:12:04 -0400
Message-ID: <CAJvTdKnh81ygA_XkL2O1ofTLurfKDPWZWuQXSBVYhr7GLPFLRQ@mail.gmail.com>
References: <1458657170-2394-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:36645 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbcCWUMG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Mar 2016 16:12:06 -0400
In-Reply-To: <1458657170-2394-1-git-send-email-jszhang@marvell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Thank you Jisheng, for pointing this out.

your patch conflicts with a patch already in-flight, so I'll not apply
it directly,
but I will fix this problem straight away.

thanks,
Len Brown, Intel Open Source Technology Center

On Tue, Mar 22, 2016 at 10:32 AM, Jisheng Zhang <jszhang@marvell.com> wrote:
> intel_idle_state_table_update() is only used internally in intel_idle,
> so make it static.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/idle/intel_idle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index cd4510a..2e0341e 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1001,7 +1001,7 @@ static void intel_idle_cpuidle_devices_uninit(void)
>   * Currently used to access tuned IVT multi-socket targets
>   * Assumption: num_sockets == (max_package_num + 1)
>   */
> -void intel_idle_state_table_update(void)
> +static void intel_idle_state_table_update(void)
>  {
>         /* IVT uses a different table for 1-2, 3-4, and > 4 sockets */
>         if (boot_cpu_data.x86_model == 0x3e) { /* IVT */
> --
> 2.8.0.rc3
>



-- 
Len Brown, Intel Open Source Technology Center
