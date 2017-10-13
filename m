From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: speedstep-lib: mark expected switch fall-through
Date: Fri, 13 Oct 2017 09:19:55 +0530
Message-ID: <20171013034955.GC31427@vireshk-i7>
References: <20171012224103.GA18340@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:48359 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753575AbdJMDt6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2017 23:49:58 -0400
Received: by mail-pf0-f174.google.com with SMTP id b79so8022384pfk.5
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2017 20:49:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20171012224103.GA18340@embeddedor.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12-10-17, 17:41, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/cpufreq/speedstep-lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
> index ccab452..8085ec9 100644
> --- a/drivers/cpufreq/speedstep-lib.c
> +++ b/drivers/cpufreq/speedstep-lib.c
> @@ -367,7 +367,7 @@ unsigned int speedstep_detect_processor(void)
>  			} else
>  				return SPEEDSTEP_CPU_PIII_C;
>  		}
> -
> +		/* fall through */
>  	default:
>  		return 0;
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
