From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [query] cpufreq: intel_pstate: diverge of current_pstate and actual
 P state
Date: Wed, 21 May 2014 00:11:04 +0300
Message-ID: <537BC4E8.60500@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:59541 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750755AbaETVLH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 May 2014 17:11:07 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.j.brandewie@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi all,

Currently, we use the current P state to calculate the busy_scaled factor
and then the next P state.

We also read the MSR_TURBO_RATIO_LIMIT to get the turbo ratio limit as the
turbo_pstate. But, we always read bits 7:0 ("Maximum turbo ratio limit of 1
core active").

So, in processor families that have different turbo ratio limit
depending on active cores the current P state as it's considered
by the driver might be different from the actual current P state.

For example, I use an i7-3770 which reports as maximum turbo ratio limits
with 1/2/3/4 actives cores the values 39/39/38/37. So, in some cases
we will calculate as the next P state the value 39. If the active cores
at that time was 3 or 4 the actual P state will be 38 or 37.
The current_pstate variable will have the value 39 and this will lead
to wrong calculation at the next sampling interval.

Trying to find a solution to the above I couldn't find an MSR that
we could use to get the number of active cores and use the respective
turbo ratio limit.

I also thought to use the IA32_PERF_STATUS to get the current P state
and use it in the calculations, but its scope is per core and not per
thread.

Am I missing something? If the above is correct, any idea how this
could be resolved?


Thanks in advance,
Stratos

