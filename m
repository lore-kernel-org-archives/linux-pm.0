From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: [PATCH V2 0/2] cpufreq/powernv: Set core pstate to a minimum just
 before hotplugging it out
Date: Fri, 05 Sep 2014 13:09:32 +0530
Message-ID: <20140905073812.3629.29175.stgit@preeti.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:56721 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754289AbaIEHjo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 5 Sep 2014 03:39:44 -0400
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Fri, 5 Sep 2014 03:39:43 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, dirk.j.brandewie@intel.com, shreyas@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, patrick.marlier@gmail.com, linuxppc-dev@ozlabs.org, dirk.brandewie@gmail.com, svaidy@linux.vnet.ibm.com

Today cpus go to winkle when they are offlined. Since it is the deepest
idle state that we have, it is expected to save good amount of power as compared
to online state, where cores can enter nap/fastsleep only which are
shallower idle states.
However we observed no powersavings with winkle as compared to nap/fastsleep
and traced the problem to the pstate of the core being kept at a high even
when the core is offline. This can keep the socket pstate high, thus burning
power unnecessarily. This patchset fixes this issue.

Changes in V2: Changed smp_call_function_any() to smp_call_function_single() in Patch[2/2]

---

Preeti U Murthy (2):
      cpufreq: Allow stop CPU callback to be used by all cpufreq drivers
      powernv/cpufreq: Set the pstate of the last hotplugged out cpu in policy->cpus to minimum


 drivers/cpufreq/cpufreq.c         |    2 +-
 drivers/cpufreq/powernv-cpufreq.c |    9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

--

