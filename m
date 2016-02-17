From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH] thermal: devfreq_cooling: remove impossible condition
Date: Wed, 17 Feb 2016 15:32:08 +0000
Message-ID: <87r3gb8i9z.fsf@e105922-lin.cambridge.arm.com>
References: <1454398326-5365-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:53981 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1423845AbcBQPcP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2016 10:32:15 -0500
In-Reply-To: <1454398326-5365-1-git-send-email-sudipm.mukherjee@gmail.com>
	(Sudip Mukherjee's message of "Tue, 2 Feb 2016 13:02:06 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Sudip Mukherjee <sudipm.mukherjee@gmail.com> writes:

> state is an unsigned long and can never be less than 0.
>
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  drivers/thermal/devfreq_cooling.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index 01f0015..81631b1 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -312,7 +312,7 @@ static int devfreq_cooling_state2power(struct thermal_cooling_device *cdev,
>  	unsigned long freq;
>  	u32 static_power;
>  
> -	if (state < 0 || state >= dfc->freq_table_size)
> +	if (state >= dfc->freq_table_size)
>  		return -EINVAL;
>  
>  	freq = dfc->freq_table[state];

Makes sense.

Acked-by: Punit Agrawal <punit.agrawal@arm.com>

Thanks for sending the fix.
