From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] export suspend_resume trace event
Date: Sun, 14 Dec 2014 22:28:46 +0100
Message-ID: <4662484.obop6v7tsN@vostro.rjw.lan>
References: <20141213040646.GA22352@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55402 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750883AbaLNVHJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Dec 2014 16:07:09 -0500
In-Reply-To: <20141213040646.GA22352@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: todd.e.brandt@linux.intel.com
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, todd.e.brandt@intel.com

On Friday, December 12, 2014 08:06:46 PM Todd E Brandt wrote:
> Export the suspend_resume tracepoint so it can be used
> in loadable modules.
> 
> Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>

I'm going to queue this up for 3.20 some time after the 3.19 merge window ends.


> ----
>  kernel/trace/power-traces.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/power-traces.c b/kernel/trace/power-traces.c
> index 1c71382..eb4220a 100644
> --- a/kernel/trace/power-traces.c
> +++ b/kernel/trace/power-traces.c
> @@ -13,5 +13,6 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/power.h>
>  
> +EXPORT_TRACEPOINT_SYMBOL_GPL(suspend_resume);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(cpu_idle);
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
