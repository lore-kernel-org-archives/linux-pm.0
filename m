Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D057E34751B
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215371; cv=none; b=Kg3zmj9Pf/y1WzteQs1l7Aa+GJa78hnq4Hd08kyifI+/+IhpYVDwaKeLcafUUBCNQCou4ZQB2PanktT7VECmfaulmtEi3QrCOHkvwcxy471uY7lDse1BxmJprU2CCSR9UfXVydWjGJzFxCkpmF4N5UtyafbDObIoQWmsKwOzYyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215371; c=relaxed/simple;
	bh=my8fgL10CouZUYHlmRyxtHYU1heADLCUy8JI+PXkbVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iM1EzW+YIN1I/b/C9qVjOa+YoXb6fGnqea6BurI0bl1vCuIauBRRiFuoSNwnqXeSNus11y9CxBk7eseMHi87dEjZofZQgoDaU0fn0sQEYgB1Pny0oeNFsunQoLoLtrZTVgG+fGaF4LuyGAioqKJavrSplWsnDVuIOjyS9mZiZlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LmzW/1mf; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LmzW/1mf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788215369; x=1819751369;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=my8fgL10CouZUYHlmRyxtHYU1heADLCUy8JI+PXkbVc=;
  b=LmzW/1mfnE46neFKDZHaSUQfyoqD9JpijJif3MuZIfkNOYuaMVyg/XgD
   TIxhVoZ/cRJzoVLifDARIGpJbu+Vttpn9aKA10+FKS8ix8Yop7uBZ+ReC
   OVEweFY04n5B1o9c+MY5nP5ObGUQ/NOQBmG/rDypzjXi5Zac+qh16xzLL
   njsOufSKBMdoIZ0g5068ffnh18KSa++7QzN+HCp0Ekn76l2Rlt+LA27kl
   JlEH1clqS820fOUR4pfciuS2tPGfSYzTY5uZmfLq7gN9AdcB//mM7hS00
   OMTA6CBCeWRM+LB/7NWXutQg2SgJaKWKLnz1uHikRlHIZRRCJa/PurbYz
   w==;
X-CSE-ConnectionGUID: Hdkt4q4yTo60g75GjFfKxg==
X-CSE-MsgGUID: JK7V5cZqQZqnig1wgds1uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88484819"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="88484819"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 15:29:28 -0700
X-CSE-ConnectionGUID: vtiGHzbdRqie1RE60wxzCg==
X-CSE-MsgGUID: S2v/fJWAQuaEE+eXymw8aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="266332559"
Received: from hanvin-mobl3.amr.corp.intel.com (HELO technocore.intel.com) ([10.124.220.52])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 15:29:28 -0700
From: Todd Brandt <todd.e.brandt@linux.intel.com>
To: linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	rjw@rjwysocki.net
Cc: todd.e.brandt@linux.intel.com,
	todd.e.brandt@intel.com
Subject: [PATCH v2] PM: dpm_show_time changes to suspend/resume dmesg prints
Date: Mon, 31 Aug 2026 15:29:26 -0700
Message-Id: <20260831222926.34698-1-todd.e.brandt@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Organize the optional dpm_show_time prints to focus on the 8 possible
suspend/resume callbacks devices can use and their associated phases
when they're called in suspend:

Remove "start suspend" as it is currently a combination of "suspend" and
"suspend prepare". Replace it with "prepare suspend" as a separate print.
Add "complete resume" over the dpm_complete call. For example:

[   66.680479] PM: suspend entry (s2idle)
[   66.826646] PM: prepare suspend of devices complete after 114.081 msecs
[   67.119306] PM: suspend of devices complete after 292.639 msecs
[   67.121309] PM: late suspend of devices complete after 1.983 msecs
[   67.190184] PM: noirq suspend of devices complete after 68.309 msecs
[   81.227706] PM: noirq resume of devices complete after 49.196 msecs
[   81.230847] PM: early resume of devices complete after 2.922 msecs
[   82.444735] PM: resume of devices complete after 1213.869 msecs
[   82.447943] PM: complete resume of devices complete after 2.850 msecs
[   82.457131] PM: suspend exit

v2 change: replace error variable with NULL in dpm_complete

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 drivers/base/power/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e130da428141..7496f76bf9f8 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1329,6 +1329,7 @@ static void device_complete(struct device *dev, pm_message_t state)
 void dpm_complete(pm_message_t state)
 {
 	struct list_head list;
+	ktime_t starttime = ktime_get();
 
 	trace_suspend_resume(TPS("dpm_complete"), state.event, true);
 
@@ -1358,6 +1359,7 @@ void dpm_complete(pm_message_t state)
 	thermal_pm_complete();
 	/* Allow device probing and trigger re-probing of deferred devices */
 	device_unblock_probing();
+	dpm_show_time(starttime, state, NULL, "complete");
 	trace_suspend_resume(TPS("dpm_complete"), state.event, false);
 }
 
@@ -2352,6 +2354,7 @@ int dpm_suspend_start(pm_message_t state)
 	int error;
 
 	error = dpm_prepare(state);
+	dpm_show_time(starttime, state, error, "prepare");
 	if (error)
 		dpm_save_failed_step(SUSPEND_PREPARE);
 	else {
@@ -2359,7 +2362,6 @@ int dpm_suspend_start(pm_message_t state)
 		error = dpm_suspend(state);
 	}
 
-	dpm_show_time(starttime, state, error, "start");
 	return error;
 }
 EXPORT_SYMBOL_GPL(dpm_suspend_start);
-- 
2.34.1

