From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH 0/7] cpufreq: intel_pstate: Debugfs file addition and cleanups
Date: Mon, 09 Jun 2014 23:59:57 +0300
Message-ID: <5396204D.7040708@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:55373 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753837AbaFIVAB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jun 2014 17:00:01 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi all,

Below some work on intel_pstate driver.
Mostly a cleanup (patches 1/7, 5/7, 6/7, 7/7), some code simplification
(patch 4/7) and the addition of stats file in debugfs that presents
driver's statistics (patch 3/7).

Please note that patch 3/7 depends on 2/7 (which also simplifies calculation
if tracing is on).


Thanks!

Stratos Karafotis (7):
  cpufreq: intel_pstate: Remove duplicate CPU ID check
  cpufreq: intel_pstate: Avoid duplicate call of
    intel_pstate_get_scaled_busy
  cpufreq: intel_pstate: Add debugfs file stats
  cpufreq: intel_pstate: Simplify code in
    intel_pstate_adjust_busy_pstate
  cpufreq: intel_pstate: Remove redundant includes
  cpufreq: intel_pstate: Trivial code cleanup
  cpufreq: intel_pstate: Make intel_pstate_kobject local

 drivers/cpufreq/intel_pstate.c | 237 +++++++++++++++++++++++------------------
 1 file changed, 135 insertions(+), 102 deletions(-)

-- 
1.9.3
