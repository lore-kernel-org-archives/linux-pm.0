From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: arm_big_little: fix frequency check when bL
 switcher is active
Date: Wed, 21 Oct 2015 15:27:25 +0530
Message-ID: <20151021095725.GA7784@ubuntu>
References: <1445421333.2916.13.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36109 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883AbbJUJ5a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2015 05:57:30 -0400
Received: by pacfv9 with SMTP id fv9so52700134pac.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2015 02:57:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1445421333.2916.13.camel@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>

On 21-10-15, 10:55, Jon Medhurst (Tixy) wrote:
> The check for correct frequency being set in bL_cpufreq_set_rate is
> broken when the big.LITTLE switcher is active, for two reasons.
> 
> 1. The 'new_rate' variable gets overwritten before the test by the
> code calculating the frequency of the old cluster.
> 
> 2. The frequency returned by bL_cpufreq_get_rate will be the virtual
> frequency, not the actual one the intended version of new_rate contains.
> 
> This means the function always returns an error causing an endless
> stream of: "cpufreq: __target_index: Failed to change cpu frequency: -5"
> 
> As the intent is to check for errors that clk_set_rate doesn't report
> lets move the check to immediately after that and directly use
> clk_get_rate, rather than the arm_big_little helpers which only confuse
> matters. Also, update the comment to be hopefully clearer about the
> purpose of the code.
> 
> Fixes: 0a95e630b49a ("cpufreq: arm_big_little: check if the frequency is set correctly")
> 
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
> 
> Changes since V1:
> - Check rate using clk_get_rate rather than disabling check when bL
>   switcher active
> 
> Sudeep, I added your Ack from the last comment on the previous patch.
> This final patch differs from what was discussed only in the commit
> message and in source comment which is hopefully more clear and is
> also satisfactory.
> 
> I've also added Michael Turquette's correct email to the CC this time,
> rather than his old Linaro address which was bouncing.
> 
>  drivers/cpufreq/arm_big_little.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
