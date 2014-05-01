From: josh@joshtriplett.org
Subject: Re: [PATCH] tools/power turbostat: Drop temperature checks
Date: Thu, 1 May 2014 09:27:46 -0700
Message-ID: <20140501162746.GA21881@cloud>
References: <20140501114019.1a63728e@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51772 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbaEAQ1v (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 May 2014 12:27:51 -0400
Content-Disposition: inline
In-Reply-To: <20140501114019.1a63728e@endymion.delvare>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Len Brown <len.brown@intel.com>

On Thu, May 01, 2014 at 11:40:19AM +0200, Jean Delvare wrote:
> The Intel 64 and IA-32 Architectures Software Developer's Manual says
> that TjMax is stored in bits 23:16 of MSR_TEMPERATURE TARGET (0x1a2).
> That's 8 bits, not 7, so it must be masked with 0xFF rather than 0x7F.
> 
> The manual has no mention of which values should be considered valid,
> which kind of implies that they all are. Arbitrarily discarding values
> outside a specific range is wrong. The upper range check had to be
> fixed recently (commit 144b44b1) and the lower range check is just as
> wrong. See bug #75071:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=75071
> 
> There are many Xeon processor series with TjMax of 70, 71 or 80
> degrees Celsius, way below the arbitrary 85 degrees Celsius limit.
> There may be other (past or future) models with even lower limits.
> 
> So drop this arbitrary check. The only value that would be clearly
> invalid is 0. Everything else should be accepted.
> 
> After these changes, turbostat is aligned with what the coretemp
> driver does.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Josh Triplett <josh@joshtriplett.org>

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

>  tools/power/x86/turbostat/turbostat.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-3.15-rc3.orig/tools/power/x86/turbostat/turbostat.c	2014-04-14 09:42:33.140152144 +0200
> +++ linux-3.15-rc3/tools/power/x86/turbostat/turbostat.c	2014-05-01 11:22:54.635123682 +0200
> @@ -1971,13 +1971,13 @@ int set_temperature_target(struct thread
>  	if (get_msr(0, MSR_IA32_TEMPERATURE_TARGET, &msr))
>  		goto guess;
>  
> -	target_c_local = (msr >> 16) & 0x7F;
> +	target_c_local = (msr >> 16) & 0xFF;
>  
>  	if (verbose)
>  		fprintf(stderr, "cpu%d: MSR_IA32_TEMPERATURE_TARGET: 0x%08llx (%d C)\n",
>  			cpu, msr, target_c_local);
>  
> -	if (target_c_local < 85 || target_c_local > 127)
> +	if (!target_c_local)
>  		goto guess;
>  
>  	tcc_activation_temp = target_c_local;
> 
> 
> -- 
> Jean Delvare
> SUSE L3 Support
