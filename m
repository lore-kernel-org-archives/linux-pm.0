From: dirk.brandewie@gmail.com
Subject: [PATCH 0/5] updates for intel_pstate
Date: Thu,  8 May 2014 12:57:22 -0700
Message-ID: <1399579047-5792-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:38759 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755192AbaEHT5k (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 May 2014 15:57:40 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, dirk.brandewie@gmail.com, Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

Patches 1-4 are bugfixes.  Patch 4 specifically removes the wreckage
caused by C0 tracking change. 

Patch 5 Adds new CPU IDs for the Broadwell processors.

Dirk Brandewie (5):
  intel_pstate: Set turbo VID for Baytrail
  intel_pstate: remove setting P state to MAX on init
  intel_pstate: Fix fixed point rounding macro
  intel_pstate: Remove C0 tracking
  intel_pstate: Add CPU IDs for Broadwell processors

 drivers/cpufreq/intel_pstate.c | 52 +++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 31 deletions(-)

-- 
1.9.0

