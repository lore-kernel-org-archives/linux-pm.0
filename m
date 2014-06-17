From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] intel_pstate: Correct rounding in busy calculation again
Date: Tue, 17 Jun 2014 22:14:54 +0200
Message-ID: <1683709.c1ANN4rtbx@vostro.rjw.lan>
References: <1403024179-26280-1-git-send-email-dsmythies@telus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57195 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964854AbaFQT5U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jun 2014 15:57:20 -0400
In-Reply-To: <1403024179-26280-1-git-send-email-dsmythies@telus.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <doug.smythies@gmail.com>
Cc: linux-pm@vger.kernel.org, dsmythies@telus.net, dirk.brandewie@gmail.com

On Tuesday, June 17, 2014 09:56:19 AM Doug Smythies wrote:
> There was a mistake in the actual rounding portion of the previous patch,

Do you mean commit f0fe3cd7e12d here?

> such that the rounding was asymetric and incorrect.
> (see also: f0fe3cd7e12d8290c82284b5c8aee723cbd0371a intel_pstate: Correct rounding in busy calculation)

Please also say something about why it was incorrect in the
changelog, in terms of what undesirable behaviour it would lead to.

> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> ---
>  drivers/cpufreq/intel_pstate.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 4e7f492..924bb2d 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -196,10 +196,7 @@ static signed int pid_calc(struct _pid *pid, int32_t busy)
>  	pid->last_err = fp_error;
>  
>  	result = pterm + mul_fp(pid->integral, pid->i_gain) + dterm;
> -	if (result >= 0)
> -		result = result + (1 << (FRAC_BITS-1));
> -	else
> -		result = result - (1 << (FRAC_BITS-1));
> +	result = result + (1 << (FRAC_BITS-1));
>  	return (signed int)fp_toint(result);
>  }
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
