From: dirk.brandewie@gmail.com
Subject: [PATCH 0/4] intel_pstate updates
Date: Mon, 21 Oct 2013 09:20:31 -0700
Message-ID: <1382372435-29778-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33726 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab3JUQUn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2013 12:20:43 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so8315634pab.4
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2013 09:20:43 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rjw@rjwysocki.net
Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

Patches 1-2 are bugfixes

Patch 3 refactors the driver to support per-CPUID accessor functions
to enable supporting CPUs that have different methods/MSRs for
enumerating and setting the requested P state.

Patch 4 Adds support for the Baytrail-M CPU


Brennan Shacklett (1):
  cpufreq: intel_pstate: Improve accuracy by not truncating until final
    result

Dirk Brandewie (3):
  cpufreq/intel_pstate:  Correct calculation of min pstate value
  cpufreq/intel_pstate: Refactor driver to support CPUs with different
    MSR layouts
  cpufreq/intel_pstate: Add Baytrail support

 drivers/cpufreq/intel_pstate.c | 215 ++++++++++++++++++++++++++++-------------
 1 file changed, 150 insertions(+), 65 deletions(-)

-- 
1.8.3.1

