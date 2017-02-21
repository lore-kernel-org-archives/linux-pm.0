From: Javi Merino <javi.merino@kernel.org>
Subject: Re: [PATCH v2 2/3] thermal: devfreq_cooling: add new interface for
 direct power read
Date: Tue, 21 Feb 2017 13:34:25 +0000
Message-ID: <20170221133425.GB23954@ct-lt-587>
References: <20170131161147.17002-1-lukasz.luba@arm.com>
 <20170131161147.17002-3-lukasz.luba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36533 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752628AbdBUNeL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Feb 2017 08:34:11 -0500
Received: by mail-wr0-f196.google.com with SMTP id z61so14470441wrc.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Feb 2017 05:34:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170131161147.17002-3-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, edubezval@gmail.com, rui.zhang@intel.com, orjan.eide@arm.com, chris.diamand@arm.com

On Tue, Jan 31, 2017 at 04:11:46PM +0000, Lukasz Luba wrote:
> This patch introduces a new interface for device drivers connected to
> devfreq_cooling in the thermal framework: get_real_power().
> 
> Some devices have more sophisticated methods (like power counters)
> to approximate the actual power that they use.
> In the previous implementation we had a pre-calculated power
> table which was then scaled by 'utilization'
> ('busy_time' and 'total_time' taken from devfreq 'last_status').
> 
> With this new interface the driver can provide more precise data
> regarding actual power to the thermal governor every time the power
> budget is calculated. We then use this value and calculate the real
> resource utilization scaling factor.
> 
> Reviewed-by: Chris Diamand <chris.diamand@arm.com>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/devfreq_cooling.c | 78 ++++++++++++++++++++++++++++++---------
>  include/linux/devfreq_cooling.h   | 17 +++++++++
>  2 files changed, 78 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index 7d55652..cba34bd 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -27,6 +27,8 @@
>  
>  #include <trace/events/thermal.h>
>  
> +#define SCALE_ERROR_MITIGATION 100
> +
>  static DEFINE_MUTEX(devfreq_lock);
>  static DEFINE_IDR(devfreq_idr);
>  
> @@ -45,6 +47,12 @@ static DEFINE_IDR(devfreq_idr);
>   * @freq_table_size:	Size of the @freq_table and @power_table
>   * @power_ops:	Pointer to devfreq_cooling_power, used to generate the
>   *		@power_table.
> + * @res_util:	Resource utilization scaling factor for the power.
> + *		It is multiplied by 100 to minimize the error. It is used
> + *		for estimation of the power budget instead of using
> + *		'utilization' (which is	'busy_time / 'total_time').
> + *		The 'res_util' range is from 100 to (power_table[state] * 100)

I was going to say that this 100s should be SCALE_ERROR_MITIGATION but
given that we are unlikely to change SCALE_ERROR_MITIGATION, it is
probably clearer if we leave them as is.

Acked-by: Javi Merino <javi.merino@kernel.org>
