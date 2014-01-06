From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: speedstep: remove unused speedstep_get_state
Date: Mon, 06 Jan 2014 23:24:21 +0100
Message-ID: <1756077.6t9Ofi9GiT@vostro.rjw.lan>
References: <1389040212.2562.3.camel@x41>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62180 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755383AbaAFWKf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2014 17:10:35 -0500
In-Reply-To: <1389040212.2562.3.camel@x41>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, January 06, 2014 09:30:12 PM Paul Bolle wrote:
> The only caller of speedstep_get_state() was removed in commit d4019f0a92ab
> ("cpufreq: move freq change notifications to cpufreq core"). So building
> speedstep-smi.o now triggers a GCC warning:
>     drivers/cpufreq/speedstep-smi.c:148:12: warning: 'speedstep_get_state' defined but not used [-Wunused-function]
> 
> Remove this unused function.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Queued up for 3.14, thanks!

> ---
> This seems to be a rather obvious fix. Hasn't it been submitted before?
> 
>  drivers/cpufreq/speedstep-smi.c | 32 --------------------------------
>  1 file changed, 32 deletions(-)
> 
> diff --git a/drivers/cpufreq/speedstep-smi.c b/drivers/cpufreq/speedstep-smi.c
> index 0f5326d..998c17b 100644
> --- a/drivers/cpufreq/speedstep-smi.c
> +++ b/drivers/cpufreq/speedstep-smi.c
> @@ -141,38 +141,6 @@ static int speedstep_smi_get_freqs(unsigned int *low, unsigned int *high)
>  }
>  
>  /**
> - * speedstep_get_state - set the SpeedStep state
> - * @state: processor frequency state (SPEEDSTEP_LOW or SPEEDSTEP_HIGH)
> - *
> - */
> -static int speedstep_get_state(void)
> -{
> -	u32 function = GET_SPEEDSTEP_STATE;
> -	u32 result, state, edi, command, dummy;
> -
> -	command = (smi_sig & 0xffffff00) | (smi_cmd & 0xff);
> -
> -	pr_debug("trying to determine current setting with command %x "
> -		"at port %x\n", command, smi_port);
> -
> -	__asm__ __volatile__(
> -		"push %%ebp\n"
> -		"out %%al, (%%dx)\n"
> -		"pop %%ebp\n"
> -		: "=a" (result),
> -		  "=b" (state), "=D" (edi),
> -		  "=c" (dummy), "=d" (dummy), "=S" (dummy)
> -		: "a" (command), "b" (function), "c" (0),
> -		  "d" (smi_port), "S" (0), "D" (0)
> -	);
> -
> -	pr_debug("state is %x, result is %x\n", state, result);
> -
> -	return state & 1;
> -}
> -
> -
> -/**
>   * speedstep_set_state - set the SpeedStep state
>   * @state: new processor frequency state (SPEEDSTEP_LOW or SPEEDSTEP_HIGH)
>   *
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
