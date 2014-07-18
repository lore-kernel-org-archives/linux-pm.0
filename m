From: dirk.brandewie@gmail.com
Subject: [PATCH 00/11] intel_pstate updates
Date: Fri, 18 Jul 2014 08:37:16 -0700
Message-ID: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34155 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422773AbaGRPhj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jul 2014 11:37:39 -0400
Received: by mail-pd0-f175.google.com with SMTP id r10so3725205pdi.6
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2014 08:37:38 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

These patches have been in the development branch used by Stratos,
Doug and myself for a long time.  I had hoped to batch them up with
other functional changes that are under development but those changes
are still under active discussion and there is no reason to hold these
changes up.

Based on v3.16-rc5 commit 1795cd9b3a91d4b5473c97f491d63892442212ab

Stratos Karafotis (11):
  cpufreq: intel_pstate: Make intel_pstate_kobject and debugfs_parent
    locals
  cpufreq: intel_pstate: Remove unnecessary type casting in div_s64()
    call
  cpufreq: intel_pstate: Add missing blank lines after declarations
  cpufreq: intel_pstate: Fit code in a single line where possible
  cpufreq: intel_pstate: Cleanup parentheses
  cpufreq: intel_pstate: Remove unnecessary intermediate variable
    sample_time
  cpufreq: intel_pstate: Align multiple lines to open parenthesis
  cpufreq: intel_pstate: Disable interrupts during MSRs reading
  cpufreq: intel_pstate: Simplify P state adjustment logic.
  cpufreq: intel_pstate: Remove core_pct rounding
  cpufreq: intel_pstate: Keep values in aperf/mperf in full precision

 drivers/cpufreq/intel_pstate.c | 131 +++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 78 deletions(-)

-- 
1.9.3

