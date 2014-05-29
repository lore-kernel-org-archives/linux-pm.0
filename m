From: dirk.brandewie@gmail.com
Subject: [PATCH 0/4] intel_pstate fixes for v3.16
Date: Thu, 29 May 2014 09:32:21 -0700
Message-ID: <1401381145-17745-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:37620 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757052AbaE2Qce (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 May 2014 12:32:34 -0400
Received: by mail-pa0-f42.google.com with SMTP id rd3so629006pab.15
        for <linux-pm@vger.kernel.org>; Thu, 29 May 2014 09:32:34 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dirk.brandewie@gmail.com, rjw@rjwysocki.net, dsmythies@telus.net, Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

Based on Rafael's linux-next branch at:
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Commit 0c932c3ecbba60bc5f9e08d579891cdbedfdd1c1

Fixes the regression where intel_pstate was being too reactive
reducing the P state caused by the C0 tracking which was added to
ensure that on an idle system intel_pstate converge on the lowest
reasonable P state.  The C0 tracking mechanism is replaced with a
mechanism that looks at sample time and scales the busy calculation
only if the sample time is *much* larger than the requested sample time.

Reference:
   https://bugzilla.kernel.org/show_bug.cgi?id=75121
   https://lkml.org/lkml/2014/5/6/597

Dirk Brandewie (3):
  intel_pstate: Remove C0 tracking
  intel_pstate: Correct rounding in busy calculation
  intel_pstate: add sample time scaling

Doug Smythies (1):
  intel_pstate: Improve initial busy calculation

 drivers/cpufreq/intel_pstate.c | 52 +++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

-- 
1.9.0

