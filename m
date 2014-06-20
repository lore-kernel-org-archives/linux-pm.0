From: dirk.brandewie@gmail.com
Subject: [PATCH 0/3] intel_pstate bug fixes
Date: Fri, 20 Jun 2014 07:27:57 -0700
Message-ID: <1403274480-10593-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34129 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbaFTO2K (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Jun 2014 10:28:10 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, dirk.brandewie@gmail.com, stable@vger.kernel.org, Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

Bug fixes for intel_pstate based on v3.16-rc1.

Patch 1 fixes a regression reported at https://bugzilla.kernel.org/show_bug.cgi?id=77951

Patch 2-3 two issues reported in https://bugzilla.kernel.org/show_bug.cgi?id=64251

Dirk Brandewie (3):
  intel_pstate: Fix setting VID
  intel_pstate: don't touch turbo bit if turbo disabled or unavailable.
  intel_pstate: Update documentation of {max,min}_perf_pct sysfs files

 Documentation/cpu-freq/intel-pstate.txt |  7 +++++--
 drivers/cpufreq/intel_pstate.c          | 32 +++++++++++++++++++++-----------
 2 files changed, 26 insertions(+), 13 deletions(-)

-- 
1.9.0

