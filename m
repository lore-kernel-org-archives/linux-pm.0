From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] timekeeping: Fix memory overwrite of sleep_time_bin array
Date: Tue, 19 Jul 2016 00:01:37 +0200
Message-ID: <1938295.fBmZlflNpk@vostro.rjw.lan>
References: <1468806139-31436-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60714 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751451AbcGRV4p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2016 17:56:45 -0400
In-Reply-To: <1468806139-31436-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On Monday, July 18, 2016 09:42:19 AM Chen Yu wrote:
> It is reported the hibernation fails at 2nd attempt, which
> hangs at hibernate() -> syscore_resume() -> i8237A_resume()
> -> claim_dma_lock(), because the lock has already been taken.
> However there is actually no other process would like to grab
> this lock on that problematic platform.
> 
> Further investigation shows that, the problem is caused by setting
> /sys/power/pm_trace to 1 before the 1st hibernation, since once
> pm_trace is enabled, the rtc becomes an unmeaningful value after resumed,
> which might bring a significant long sleep time in timekeeping_resume,
> thus in tk_debug_account_sleep_time, the delta of timespec64 might
> exceed 32bit after commit 7d489d15ce4b ("timekeeping: Convert timekeeping
> core to use timespec64s"), thus if the bit31 happened set to 1, the
> fls might return 32 and then we add 1 to sleep_time_bin[32], which
> caused a memory overwritten. As System.map shows:
> 
> ffffffff81c9d080 b sleep_time_bin
> ffffffff81c9d100 B dma_spin_lock
> 
> Thus set the dma_spin_lock.val to 1, which caused this problem.

Nice catch!

> This patch fixes this issue by extending sleep_time_bin to 64, and
> use __fls to be fit for timespec64.
> 
> Fixes: 7d489d15ce4b ("timekeeping: Convert timekeeping core to use timespec64s")
> Reported-and-tested-by: Janek Kozicki <cosurgi@gmail.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/time/timekeeping_debug.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/time/timekeeping_debug.c b/kernel/time/timekeeping_debug.c
> index f6bd652..12b07d5 100644
> --- a/kernel/time/timekeeping_debug.c
> +++ b/kernel/time/timekeeping_debug.c
> @@ -23,14 +23,14 @@
>  
>  #include "timekeeping_internal.h"
>  
> -static unsigned int sleep_time_bin[32] = {0};
> +static unsigned int sleep_time_bin[64] = {0};
>  
>  static int tk_debug_show_sleep_time(struct seq_file *s, void *data)
>  {
>  	unsigned int bin;
>  	seq_puts(s, "      time (secs)        count\n");
>  	seq_puts(s, "------------------------------\n");
> -	for (bin = 0; bin < 32; bin++) {
> +	for (bin = 0; bin < 64; bin++) {
>  		if (sleep_time_bin[bin] == 0)
>  			continue;
>  		seq_printf(s, "%10u - %-10u %4u\n",
> @@ -69,6 +69,7 @@ late_initcall(tk_debug_sleep_time_init);
>  
>  void tk_debug_account_sleep_time(struct timespec64 *t)
>  {
> -	sleep_time_bin[fls(t->tv_sec)]++;
> +	if (t->tv_sec > 0)
> +		sleep_time_bin[__fls(t->tv_sec)]++;

But you could simply validate t->tv_sec here without extending sleeo_time_bin[]
and switching over to __fls(), couldn't you?

Thanks,
Rafael

