From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] new suspend_resume trace event for console resume
Date: Mon, 22 Sep 2014 16:04:09 +0200
Message-ID: <4154231.oR0n14TklK@vostro.rjw.lan>
References: <20140919210711.GA15652@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52721 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753936AbaIVNoW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Sep 2014 09:44:22 -0400
In-Reply-To: <20140919210711.GA15652@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: todd.e.brandt@linux.intel.com
Cc: linux-pm@vger.kernel.org

On Friday, September 19, 2014 02:07:12 PM Todd E Brandt wrote:
> This patch adds another suspend_resume trace event for analyze_suspend
> to capture. The resume_console call can take several hundred milliseconds
> if the printk buffer is full of debug info. The tool will now inform 
> testers of the wasted time and encourage them to disable it in
> production builds.
> 
> Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>

Queued up for 3.18, thanks!

> ----
>  kernel/power/suspend.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 18c6219..e837dd6 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -361,7 +361,9 @@ int suspend_devices_and_enter(suspend_state_t state)
>  	suspend_test_start();
>  	dpm_resume_end(PMSG_RESUME);
>  	suspend_test_finish("resume devices");
> +	trace_suspend_resume(TPS("resume_console"), state, true);
>  	resume_console();
> +	trace_suspend_resume(TPS("resume_console"), state, false);
>  
>   Close:
>  	platform_suspend_end(state);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
