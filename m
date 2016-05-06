From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: governor: Fix handling of special cases in
 dbs_update()
Date: Fri, 6 May 2016 12:00:56 +0530
Message-ID: <20160506063056.GC24109@vireshk-i7>
References: <4149261.sebfWj8seH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35202 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbcEFGbA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2016 02:31:00 -0400
Received: by mail-pa0-f49.google.com with SMTP id iv1so44190617pac.2
        for <linux-pm@vger.kernel.org>; Thu, 05 May 2016 23:31:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4149261.sebfWj8seH@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chen Yu <yu.c.chen@intel.com>, Timo Valtoaho <timo.valtoaho@gmail.com>

On 06-05-16, 01:30, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> As reported in KBZ 69821:
> 
> "With CONFIG_HZ_PERIODIC=y cpu stays at the lowest frequcency 800MHz
>  even if usage goes to 100%, frequency does not scale up, the governor
>  in use is ondemand. Neither works conservative. Performance and
>  userspace governors work as expected.
> 
>  With CONFIG_NO_HZ_IDLE or CONFIG_NO_HZ_FULL cpu scales up with ondemand
>  as expected."
> 
> Analysis carried out by Chen Yu leads to the conclusion that the
> observed issue is due to idle_time in dbs_update() representing a
> negative number in which case the function will return 0 as the load
> (unless load is greater than 0 for another CPU sharing the policy),
> although that need not be the right choice.
> 
> Indeed, idle_time representing a negative number means that during
> the last sampling interval the CPU was almost 100% busy on the rough
> average, so 100 should be returned as the load in that case.
> 
> Modify the code accordingly and rearrange it to clarify the handling
> of all of the special cases in it.  While at it, also avoid returning
> zero as the load if time_elapsed is 0 (it doesn't really make sense
> to return 0 then).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=69821
> Tested-by: Chen Yu <yu.c.chen@intel.com>
> Tested-by: Timo Valtoaho <timo.valtoaho@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |   87 +++++++++++++++++++++----------------
>  1 file changed, 51 insertions(+), 36 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
