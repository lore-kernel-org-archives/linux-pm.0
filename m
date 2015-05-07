From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH] thermal: of: fix cooling_spec.args for 64bit
Date: Thu, 07 May 2015 10:51:32 +0100
Message-ID: <9hha8xg3ecb.fsf@e105922-lin.cambridge.arm.com>
References: <1430972952-16303-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:46017 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754458AbbEGK0r (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 06:26:47 -0400
In-Reply-To: <1430972952-16303-1-git-send-email-wni@nvidia.com> (Wei Ni's
	message of "Thu, 7 May 2015 12:29:12 +0800")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, linux-pm@vger.kernel.org

Wei Ni <wni@nvidia.com> writes:

> The THERMAL_NO_LIMIT is defined as -1UL, when it is set in DT,
> the of-thermal will use of_parse_phandle_with_args() to parse it.
> Since the args is uint32_t, so in 32bit system, the of framework
> will read it as 0xffffffff, it's the expected value "-1".
> But in 64bit system, this value is read as 0x00000000ffffffff,
> it's not a negative value, it will cause problems.
>
> This change can fix this issue.

If I understand the issue correctly, a patch fixing this is already
merged. Does "commit a940cb34f: thermal: Fix cdev registration with
THERMAL_NO_LIMIT on 64bit" not work for you?

>
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/of-thermal.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 9e8c614103ef..8d6b4070dea3 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -613,8 +613,10 @@ static int thermal_of_populate_bind_params(struct device_node *np,
>  	}
>  	__tbp->cooling_device = cooling_spec.np;
>  	if (cooling_spec.args_count >= 2) { /* at least min and max */
> -		__tbp->min = cooling_spec.args[0];
> -		__tbp->max = cooling_spec.args[1];
> +		__tbp->min = cooling_spec.args[0] == -1U ?
> +			THERMAL_NO_LIMIT : cooling_spec.args[0];
> +		__tbp->max = cooling_spec.args[1] == -1U ?
> +			THERMAL_NO_LIMIT : cooling_spec.args[1];
>  	} else {
>  		pr_err("wrong reference to cooling device, missing limits\n");
>  	}
