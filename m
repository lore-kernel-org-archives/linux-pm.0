Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225333A1A3F
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152587; cv=none; b=PhlIH7Q1siXcg8Msu0ZhOxsp3ylxft31jcMUCVBVsWWU6oTwtyjNODkK8C5uCVIrIgxTML8GSuy+Gtl3PQNfCr9XzQWnKmTjbWSGBJpOUOgsX5ZurooHP7/IdAseKi5WTe9zEuYxjptp6l/U5yxhbeHV+yci2axuAbsEomRRWLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152587; c=relaxed/simple;
	bh=XwAXLj7R6L4ZmGX4LSl5M4vOSJfe8AXLcp8QXR1X9dI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bk6obL7W+1HzgNV4dzqHSdIpRGujuwOsItOhE92vRo8sN2faVmp3fTJBdogDs0/+e67gG5PQ6sOXBzV32/i3SKy+x1+Fpwfw3lSyxjfk1m5n2ZHtDvga5t36XofjqRLC2Vm+XkJhpLq2lwI9zBn4wYMAl/rRc57PZ2PNLgVFL/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SnSyiQ/j; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SnSyiQ/j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787152583; x=1818688583;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XwAXLj7R6L4ZmGX4LSl5M4vOSJfe8AXLcp8QXR1X9dI=;
  b=SnSyiQ/j3ywAB4irdk881nq4s9L1Asl41hRrU4178y4QQiqUe83F+cRY
   jCZaaHC9jK90XCLCe6mC05yHGYwnrRk0EhHSyU3QMDZ/WCzfiarZnFvGM
   nlfkQBU5XGFw5nmrBHIz2drmj3qLidvOBAnkkWLRa+Dg+gv8EIQ4ACRCh
   dRAB5t/diXoyKHiUoFE4r2Ox+APzALoRk4Igc5HP2Tibw2Z8PU9QEjwRR
   6p3o0oVHfMyaNMva5+DqcjvttkJo8qNQd/BQ7P/UMehZVL0uN0/F+OI1H
   s453f/jivuVRqf/+EoBp2hpis5KyGS9/LXvIWv24RvQkGY+Rdl7v3zh6j
   A==;
X-CSE-ConnectionGUID: apByFhjATeKbtQexdbrOwg==
X-CSE-MsgGUID: AKTNcVdlTvi7r5XeoNUHcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="110457858"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="110457858"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 08:16:21 -0700
X-CSE-ConnectionGUID: jkaGTjwJSB6qj0rd+ZGfFA==
X-CSE-MsgGUID: bwUY2hLRRmWimYdcH1/UiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="267538905"
Received: from rodrigoa-mobl1.amr.corp.intel.com (HELO technocore.intel.com) ([10.124.221.17])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 08:16:20 -0700
From: Todd Brandt <todd.e.brandt@linux.intel.com>
To: linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	rjw@rjwysocki.net
Cc: todd.e.brandt@linux.intel.com,
	todd.e.brandt@intel.com
Subject: [PATCH] PM: dpm_show_time changes to suspend/resume dmesg prints
Date: Wed, 19 Aug 2026 08:16:18 -0700
Message-Id: <20260819151618.1218221-1-todd.e.brandt@linux.intel.com>
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

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 drivers/base/power/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 184dc4b3b938..2597ef0e89e3 100644
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
+	dpm_show_time(starttime, state, error, "complete");
 	trace_suspend_resume(TPS("dpm_complete"), state.event, false);
 }
 
@@ -2351,6 +2353,7 @@ int dpm_suspend_start(pm_message_t state)
 	int error;
 
 	error = dpm_prepare(state);
+	dpm_show_time(starttime, state, error, "prepare");
 	if (error)
 		dpm_save_failed_step(SUSPEND_PREPARE);
 	else {
@@ -2358,7 +2361,6 @@ int dpm_suspend_start(pm_message_t state)
 		error = dpm_suspend(state);
 	}
 
-	dpm_show_time(starttime, state, error, "start");
 	return error;
 }
 EXPORT_SYMBOL_GPL(dpm_suspend_start);
-- 
2.34.1

