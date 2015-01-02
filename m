From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 00/17] cpufreq: trivial cleanups
Date: Fri,  2 Jan 2015 12:34:21 +0530
Message-ID: <cover.1420181916.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:63744 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbbABHEz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 02:04:55 -0500
Received: by mail-pd0-f181.google.com with SMTP id v10so23271541pde.12
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 23:04:54 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael et al

Along with the big changes I have for cpufreq core simplification, I also
accumulated these trivial cleanups. In order to not confuse the much dedicated
series on solving the real problems, I am sending these separately.

These are independent of the stats cleanups sent earlier and so it doesn't
matter which one you apply first.

Pushed here:
git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/core/trivial-cleanups

@Prarit/Saravana: It would be helpful if you guys can go through this as well :)

Viresh Kumar (17):
  cpufreq: remove dangling comment
  cpufreq: remove extra parenthesis
  cpufreq: don't need line break in show_scaling_cur_freq()
  cpufreq: merge 'if' blocks in __cpufreq_remove_dev_prepare()
  cpufreq: s/__find_governor/find_governor
  cpufreq: No need to check for has_target()
  cpufreq: pass policy to cpufreq_out_of_sync
  cpufreq: pass policy to __cpufreq_get()
  cpufreq: update driver->flags only if we are registering driver
  cpufreq: get rid of CONFIG_{HOTPLUG_CPU|SMP} mess
  cpufreq: get rid of 'tpolicy' from __cpufreq_add_dev()
  cpufreq: use light-weight cpufreq_cpu_get_raw() in __cpufreq_add_dev
  cpufreq: limit the scope of l_p_j variables
  cpufreq: check cpufreq_policy_list instead of getting policies for all
    CPUs
  cpufreq: don't check if cpu > nr_cpu_ids
  cpufreq: remove check for cpufreq_disabled() from
    cpufreq_cpu_{get|put}()
  cpufreq: move some initialization stuff to cpufreq_policy_alloc()

 drivers/cpufreq/cpufreq.c | 129 ++++++++++++++--------------------------------
 1 file changed, 40 insertions(+), 89 deletions(-)

-- 
2.2.0

