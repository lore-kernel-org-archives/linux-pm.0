From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] intel_idle: Fixed C6 state on Avoton/Rangeley processors
Date: Tue, 26 Nov 2013 13:53:58 +0100
Message-ID: <1574800.Vl6NB1rGSk@amdc1032>
References: <1385450037.4588.10.camel@po-d-abo-ubu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:31368 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115Ab3KZMyN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2013 07:54:13 -0500
In-reply-to: <1385450037.4588.10.camel@po-d-abo-ubu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bockholdt Arne <a.bockholdt@precitec-optronik.de>
Cc: Len Brown <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


Hi,

On Tuesday, November 26, 2013 07:13:57 AM Bockholdt Arne wrote:
> Corrected the MWAIT flag for C-State C6 on Intel Avoton/Rangeley processors.
> 
> Signed-off-by: Arne Bockholdt <linux-kernel@bockholdt.com>
> ---
> 
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index cbd4e9a..92d1206 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -329,7 +329,7 @@ static struct cpuidle_state atom_cstates[] __initdata = {
>  	{
>  		.enter = NULL }
>  };
> -static struct cpuidle_state avn_cstates[CPUIDLE_STATE_MAX] = {
> +static struct cpuidle_state avn_cstates[] __initdata = {

The above fixup has already been submitted in a separate patch:

	https://lkml.org/lkml/2013/11/21/177

and it has nothing to do with the purpose of your patch.

Thus please drop it from your patch.

>  	{
>  		.name = "C1-AVN",
>  		.desc = "MWAIT 0x00",
> @@ -340,7 +340,7 @@ static struct cpuidle_state avn_cstates[CPUIDLE_STATE_MAX] = {
>  	{
>  		.name = "C6-AVN",
>  		.desc = "MWAIT 0x51",
> -		.flags = MWAIT2flg(0x58) | CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
> +		.flags = MWAIT2flg(0x51) | CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
>  		.exit_latency = 15,
>  		.target_residency = 45,
>  		.enter = &intel_idle },

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

