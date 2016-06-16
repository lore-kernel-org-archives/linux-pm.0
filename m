From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 0/3] Tools/Power/Turbostat update for Denverton
Date: Thu, 16 Jun 2016 09:48:19 -0700
Message-ID: <1466095702-5537-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33694 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753899AbcFPQuW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 16 Jun 2016 12:50:22 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>

This simple series first address missing RAPL MSR handling such
that new CPUs such as Denverton can be supported. Denverton specific
bits are added later.


Jacob Pan (3):
  tools/power/turbostat: handle missing rapl msrs
  tools/power/turbostat: add denverton support
  tools/power/turbostat: add denverton rapl support

 tools/power/x86/turbostat/turbostat.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

-- 
1.9.1

