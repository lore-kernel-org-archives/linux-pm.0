From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] thermal/intel_powerclamp: Remove set-but-not-used
 variables
Date: Tue, 31 Jan 2017 08:22:41 -0800
Message-ID: <20170131082241.00d093fb@jacob-builder>
References: <1485773289-19844-1-git-send-email-augustocaringi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:18682 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751897AbdAaQVw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Jan 2017 11:21:52 -0500
In-Reply-To: <1485773289-19844-1-git-send-email-augustocaringi@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Augusto Mecking Caringi <augustocaringi@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com

On Mon, 30 Jan 2017 10:47:36 +0000
Augusto Mecking Caringi <augustocaringi@gmail.com> wrote:

> In poll_pkg_cstate() function, the variables jiffies_last and
> jiffies_now are set but never used.
> 
> This has been detected by building the driver with W=1:
> 
> drivers/thermal/intel_powerclamp.c: In function ‘poll_pkg_cstate’:
> drivers/thermal/intel_powerclamp.c:464:23: warning: variable
> ‘jiffies_last’ set but not used [-Wunused-but-set-variable]
> static unsigned long jiffies_last;
>                        ^
> 
Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Thanks,
> Signed-off-by: Augusto Mecking Caringi <augustocaringi@gmail.com>
> ---
>  drivers/thermal/intel_powerclamp.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/thermal/intel_powerclamp.c
> b/drivers/thermal/intel_powerclamp.c index df64692..a47103a 100644
> --- a/drivers/thermal/intel_powerclamp.c
> +++ b/drivers/thermal/intel_powerclamp.c
> @@ -461,16 +461,13 @@ static void poll_pkg_cstate(struct work_struct
> *dummy) {
>  	static u64 msr_last;
>  	static u64 tsc_last;
> -	static unsigned long jiffies_last;
>  
>  	u64 msr_now;
> -	unsigned long jiffies_now;
>  	u64 tsc_now;
>  	u64 val64;
>  
>  	msr_now = pkg_state_counter();
>  	tsc_now = rdtsc();
> -	jiffies_now = jiffies;
>  
>  	/* calculate pkg cstate vs tsc ratio */
>  	if (!msr_last || !tsc_last)
> @@ -485,7 +482,6 @@ static void poll_pkg_cstate(struct work_struct
> *dummy) 
>  	/* update record */
>  	msr_last = msr_now;
> -	jiffies_last = jiffies_now;
>  	tsc_last = tsc_now;
>  
>  	if (true == clamping)

[Jacob Pan]
