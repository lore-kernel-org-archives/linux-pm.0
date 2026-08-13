Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E0F33065D;
	Thu, 13 Aug 2026 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609050; cv=none; b=Hb+ShStoB4EQ1sGoqkPOYmbolmdAMjeATOXB/jE6b+sesw/yIHGYxpAuMpq563e8a7UHrxnRXN9cb1GPYi86P3pSSQLZL8ye1Q3r0rztiZw7GnbBdbB9mGzc5eDDm55eiGAFLOfVw/2n4rgKQmqAt0vrKzIdGBc55FkaA7cj8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609050; c=relaxed/simple;
	bh=Dwga6pDeizSc48ZtmN0mAPrTY5YsIi4GErzpdiVScVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u2K4gcx4GySuyRETfW7yO3vzlmjMSKayl6Iw5L59IUEavB1lSKtkoK0Xc9V76NrjH4K3imkhTytCjAq8ZxlUMiuAnkV9f46LWpxFJAo2WByMrCTj5theVEZiu9RM98ul5G3gyuVka37FspxWm39EgWQ/rDVnTVISKb6IR/v7G7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bIuPyTnQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bIuPyTnQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786609048; x=1818145048;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dwga6pDeizSc48ZtmN0mAPrTY5YsIi4GErzpdiVScVM=;
  b=bIuPyTnQfaUD+UbryeyCTHOtZdKk/Nzjk4OYds75gZBnR1l9BYwZEwMx
   dBayH0tsH7Aa0JKTg/9FUf72OVbs8D4svt1Kv6kX/Km3saQjEVDAEKcwT
   g0dkPV2w632BkXTCmok2GpXrTOxIfxVn0QOf2nJ5LjHDOOvdMsFkiA5WH
   vyzuFHu8MFeErEivSxqvE83h/1puJ9pqMmfYOx0rTEzbJF2xk+ZM1zFur
   Sx/LpOObZ6fsuRmcZ0psSHyzcWVSan+7DPYIQVO+K1ZwkWM9RwGF1L+lL
   6z1woM+I95TjPnrzf9UQN2ygQhZQe9FSWNc9VdbXTdqt0uXoorjv1Nhw/
   w==;
X-CSE-ConnectionGUID: GiMgtUqcQ6CltfzpBc4c3g==
X-CSE-MsgGUID: /dGDT9s8TUqrQVS8XnvfVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="97524595"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="97524595"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:17:27 -0700
X-CSE-ConnectionGUID: yfpjV2UyTwaQ6turrUIBbg==
X-CSE-MsgGUID: DA7fSWqDQHu4B8AbYwOjJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="262560933"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 13 Aug 2026 01:17:26 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id E90B899; Thu, 13 Aug 2026 10:17:24 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] intel_idle: Replace min_t() with the better alternatives
Date: Thu, 13 Aug 2026 10:17:21 +0200
Message-ID: <20260813081721.2645937-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Almost always use of min_t() is wrong. Replace it with min() and min3() as all
types are int and there is no point to use typed variant of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/idle/intel_idle.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index b12b4f62752a..699665f24ecd 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1792,9 +1792,7 @@ static bool __init intel_idle_cst_usable(void)
 {
 	int cstate, limit;
 
-	limit = min_t(int, min_t(int, CPUIDLE_STATE_MAX, max_cstate + 1),
-		      acpi_state_table.count);
-
+	limit = min3(CPUIDLE_STATE_MAX, max_cstate + 1, acpi_state_table.count);
 	for (cstate = 1; cstate < limit; cstate++) {
 		struct acpi_processor_cx *cx = &acpi_state_table.states[cstate];
 
@@ -1938,7 +1936,7 @@ static void __init intel_idle_init_cstates_acpi_lpi(struct cpuidle_driver *drv)
 
 static void __init intel_idle_init_cstates_acpi_cst(struct cpuidle_driver *drv)
 {
-	int cstate, limit = min_t(int, CPUIDLE_STATE_MAX, acpi_state_table.count);
+	int cstate, limit = min(CPUIDLE_STATE_MAX, acpi_state_table.count);
 
 	/*
 	 * If limit > 0, intel_idle_cst_usable() has returned 'true', so all of
@@ -2018,7 +2016,7 @@ static bool __init intel_idle_off_by_default_lpi(unsigned int flags, u32 mwait_h
 
 static bool __init intel_idle_off_by_default_cst(unsigned int flags, u32 mwait_hint)
 {
-	int cstate, limit = min_t(int, CPUIDLE_STATE_MAX, acpi_state_table.count);
+	int cstate, limit = min(CPUIDLE_STATE_MAX, acpi_state_table.count);
 
 	/*
 	 * If limit > 0, intel_idle_cst_usable() has returned 'true', so all of
-- 
2.50.1

