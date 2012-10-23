From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [PATCH] cpuidle: fix warning when compile
Date: Tue, 23 Oct 2012 22:42:49 +0800
Message-ID: <20121023144249.GA24862@localhost>
References: <1351046728-10965-1-git-send-email-youquan.song@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34804 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745Ab2JWOm6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Oct 2012 10:42:58 -0400
Content-Disposition: inline
In-Reply-To: <1351046728-10965-1-git-send-email-youquan.song@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Youquan Song <youquan.song@intel.com>
Cc: yuanhan.liu@linux.intel.com, rjw@sisk.pl, Rik van Riel <riel@redhat.com>, linux-pm@vger.kernel.org, Youquan Song <youquan.song@linux.intel.com>

On Tue, Oct 23, 2012 at 10:45:28PM -0400, Youquan Song wrote:
> Fix the warning complain when compile the kernel.
> 
> drivers/cpuidle/governors/menu.c: In function 'get_typical_interval':
> drivers/cpuidle/governors/menu.c:268:2: warning: comparison of distinct pointer types lacks a cast [enabled by default]
> drivers/cpuidle/governors/menu.c:277:2: warning: comparison of distinct pointer types lacks a cast [enabled by default]
> 
> Signed-off-by: Youquan Song <youquan.song@intel.com>

Tested-by: Fengguang Wu <wfg@linux.intel.com>

> ---
>  drivers/cpuidle/governors/menu.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 26d5667..2efee27 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -248,7 +248,7 @@ static enum hrtimer_restart menu_hrtimer_notify(struct hrtimer *hrtimer)
>  static u32 get_typical_interval(struct menu_device *data)
>  {
>  	int i = 0, divisor = 0;
> -	int64_t max = 0, avg = 0, stddev = 0;
> +	uint64_t max = 0, avg = 0, stddev = 0;
>  	int64_t thresh = LLONG_MAX; /* Discard outliers above this value. */
>  	unsigned int ret = 0;
>  
> -- 
> 1.7.7.4
