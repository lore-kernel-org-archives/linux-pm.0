From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: conservative: Do not use transition
 notifications
Date: Mon, 13 Jun 2016 16:38:51 +0530
Message-ID: <20160613110851.GT27439@vireshk-i7>
References: <2899343.d3UcWvo4TA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33615 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965047AbcFMLIz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jun 2016 07:08:55 -0400
Received: by mail-pa0-f47.google.com with SMTP id b13so22589764pat.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2016 04:08:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2899343.d3UcWvo4TA@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 10-06-16, 03:00, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The conservative governor registers a transition notifier so it
> can update its internal requested_freq value if it falls out of the
> policy->min...policy->max range, but that's not the most
> straightforward way to achieve that.
> 
> To do it in a more straightforward way, first make sure that
> cs_dbs_timer() will only set frequencies between min and max.
> 
> With that, note that requested_freq will always fall between min
> and max unless either policy->min or policy->max changes and the
> governor's ->limits() callback will be invoked then.
> 
> Using this observation, add a ->limits callback pointer to
> struct dbs_governor, make cpufreq_dbs_governor_limits() invoke
> that callback if present, implement that callback in the conservative
> governor to update requested_freq if needed and drop the transition
> notifier from it, which also makes it possible to drop the
> struct cs_governor definition from there and simplify the code
> accordingly.

This code looks to me over-complicated and I am not sure if I
understand why we wanted the notifiers anyway? Why can't we replace
'dbs_info->requested_freq' with 'policy->cur' and kill the notifier
thing completely?

With requested_freq, we are trying to set the next freq to
requested_freq +- Delta, which I am not sure is the best approach
here.

What would go wrong if we will do, policy->cur +- delta instead?

The notifiers were added long back, to solve a problem which I don't
think will exist if we use policy->cur everywhere instead:

commit a8d7c3bc2396 ("[CPUFREQ] Make cpufreq_conservative handle
out-of-sync events properly")

Am I missing something?

-- 
viresh
