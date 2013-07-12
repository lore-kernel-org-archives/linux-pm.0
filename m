From: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Subject: Re: [PATCH] PM: avoid 'autosleep' in shutdown progress
Date: Fri, 12 Jul 2013 14:14:11 +0800
Message-ID: <1373609651.4432.122.camel@ymzhang.sh.intel.com>
References: <1373529825-20741-1-git-send-email-shuox.liu@intel.com>
Reply-To: yanmin_zhang@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:28067 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554Ab3GLGO3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 12 Jul 2013 02:14:29 -0400
In-Reply-To: <1373529825-20741-1-git-send-email-shuox.liu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: shuox.liu@intel.com
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, pavel@ucw.cz, rjw@sisk.pl, linux-pm@vger.kernel.org

On Thu, 2013-07-11 at 16:03 +0800, shuox.liu@intel.com wrote:
> From: Liu ShuoX <shuox.liu@intel.com>
> 
> In shutdown progress, system is possible to do power transition
> (such as suspend-to-ram) in parallel. It is unreasonable. So,
> fixes it by adding a system_state checking and queue try_to_suspend
> again when system status is not running.
> 
> Signed-off-by: Liu ShuoX <shuox.liu@intel.com>
> ---
>  kernel/power/autosleep.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
Without this patch, we hit an hang issue on Android.

Scenario:
Kernel starts shutdown and calls all device driver's shutdown callback.
When a driver's shutdown is called, the last wakelock is released and
suspend-to-ram starts. However, as some driver's shut down callbacks
already shut down devices and disable runtime pm, the suspend-to-ram
calls driver's suspend callback without noticing that device is already
off and causes crash.
We know the drivers should be fixed, but can we also change generic
codes a little to make it stronger?

> diff --git a/kernel/power/autosleep.c b/kernel/power/autosleep.c
> index c6422ff..9012ecf 100644
> --- a/kernel/power/autosleep.c
> +++ b/kernel/power/autosleep.c
> @@ -32,7 +32,8 @@ static void try_to_suspend(struct work_struct *work)
>  
>  	mutex_lock(&autosleep_lock);
>  
> -	if (!pm_save_wakeup_count(initial_count)) {
> +	if (!pm_save_wakeup_count(initial_count) ||
> +		system_state != SYSTEM_RUNNING) {
>  		mutex_unlock(&autosleep_lock);
>  		goto out;
>  	}


