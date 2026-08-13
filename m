Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3A436728F;
	Thu, 13 Aug 2026 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609591; cv=none; b=hv0tsW8Uck4iepbYzlhTvyBqIpDvqyENHmIWFwCIlF3hympPEsKAWoY8d0Dq234rKaeKrp0QVNNngTIBcW5RxeshbOPagPCiXXZaL2S2yNltzHs9yk7J3Q5iaAVff1++Ji1DqTSxMdeFzlCOmF1eRQd8ys5T7aJOo1UhNKgsruQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609591; c=relaxed/simple;
	bh=kWQn2F9OCPrUncFjHSvCXTAD0QjH9PzY86E019n71Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j7GJPNny9CcHO09DQqyVsna5XriN02qxuLBdF56aFf9K+DGYttNSGZtIe3OiQJoNtgYpdHtTkmTa6SjKAQeGPI52NBHfBt80zArJjoZ4pur5HrZRafn91I6XBmc/vGXGahRMhAvaQvRUG5szua2lMMYqGApmt5wKqNtywslz8Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tx582Wtq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tx582Wtq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786609588; x=1818145588;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kWQn2F9OCPrUncFjHSvCXTAD0QjH9PzY86E019n71Sc=;
  b=Tx582WtqGS1IgB2Eclhz1mxxXYYsT7iBtehEJGZxd0xh9wRiCH5tNs/U
   BuqPfXSAxCVUR3sZHYuaqVWgRbNS+RYlAGBhfKP72uTxwHV44FLPrEROo
   HLUwBi1AFOgTd1eM1jOEkWdhTP9yR05i7Xf0naOxSopSacyouQPudufY3
   rGJT7wXeoH3ZAMRazYaQAF5AOTra5xIPESwSA7rMQkNT0zDDZGfxHFMnC
   M5VUGX5MAwRvfzE1YvyPV1ZrF2MKqKjC2/Pe9kBAvXkiAX1xckcYfCx9M
   ajFXRA1qdNIc4jWwOUFxUOZ+/M9OfNFcE8KQtAKJOSxZrZEH5M20aEj9G
   w==;
X-CSE-ConnectionGUID: 8RfVxuZhRNObTDyVyV6AFQ==
X-CSE-MsgGUID: YixU/TC1Qqu12gI+28a1LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="90856636"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="90856636"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:26:28 -0700
X-CSE-ConnectionGUID: SLehzlRaSSqjr68srrxOeg==
X-CSE-MsgGUID: noXYaVIkQlat8UMxbexWkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="263909005"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 13 Aug 2026 01:26:26 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 211F699; Thu, 13 Aug 2026 10:26:25 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] intel_idle: Use 2-argument strscpy()
Date: Thu, 13 Aug 2026 10:26:24 +0200
Message-ID: <20260813082624.2650581-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andy.shevchenko@gmail.com>

Use 2-argument strscpy(), which is not only shorter but also provides
an additional check that destination buffer is an array.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/idle/intel_idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 699665f24ecd..01a68f5b9020 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1904,7 +1904,7 @@ static void __init intel_idle_init_cstates_acpi_lpi(struct cpuidle_driver *drv)
 		state = &drv->states[drv->state_count++];
 
 		scnprintf(state->name, CPUIDLE_NAME_LEN, "C%d_LPI", index + 1);
-		strscpy(state->desc, lpi_state->desc, CPUIDLE_DESC_LEN);
+		strscpy(state->desc, lpi_state->desc);
 		state->exit_latency = lpi_state->wake_latency;
 		state->target_residency = lpi_state->min_residency;
 		state->flags = MWAIT2flg(lpi_state->address);
@@ -1954,7 +1954,7 @@ static void __init intel_idle_init_cstates_acpi_cst(struct cpuidle_driver *drv)
 		state = &drv->states[drv->state_count++];
 
 		snprintf(state->name, CPUIDLE_NAME_LEN, "C%d_ACPI", cstate);
-		strscpy(state->desc, cx->desc, CPUIDLE_DESC_LEN);
+		strscpy(state->desc, cx->desc);
 		state->exit_latency = cx->latency;
 		/*
 		 * For C1-type C-states use the same number for both the exit
-- 
2.50.1

