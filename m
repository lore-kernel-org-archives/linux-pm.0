Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A2A374E43;
	Sat, 13 Jun 2026 22:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388435; cv=none; b=BOsA+bC0vNkB0Xzjfth0aCNkRKVNPAMMH5C3SxCURITyHMhJbmp6Ycr0hNo3iX1tUpzlDet6GuSBI3WYvSkLkRObDn9LC8DH/dG07tzzqkMhmtYKWKHccdiNS106atVY0px+g7CfjQSdstLCbw6s+j3UZvPGPNHp3ycmz55cWvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388435; c=relaxed/simple;
	bh=StcGvNzhGAmHNtmfcblncLMfexDOq04lgNGUhRQ/2cY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=enc793Qfnylv123EbX7atRjTY9NUs0pneq4m5VhDhRpCmSwt+dN427A7w9bSQLFejL3yg3KjYrvvpgJapWP7XQXeoYw+DUPZ4FormoJ6tE+V2MCxKVEKM6/OffhhykjYW3LV8ZjDsvuocutVEKaZuvPYf0uMDpk3F0bImY2WY40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=On1OPEur; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="On1OPEur"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781388434; x=1812924434;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=StcGvNzhGAmHNtmfcblncLMfexDOq04lgNGUhRQ/2cY=;
  b=On1OPEur5IvfJU0oWNOzq5bT5ktGsXoUjiUiCfp06trlMi5EYR7hn05C
   N7wJMGxCSXD9YFMP0FrrlwFqd/+B9BHTIviZJrBjB6siwmt+kDJXHA953
   cMk3NLwoD+KbGaKaGyeP7AX16yikSSR/WSFTLGSPLCPh7r5hXQhhtq2BU
   R00uT9s6HoURkJ5SU9ko1IKi4+tN6MTs+3gxVTBMrOh9RwUJXCxOp+L8i
   exb/+vYiADnueeLmUdCo0C48ybvzui9sYpshYHtqxUiimCC9bZbNJLE/C
   SdXkYbdlixOqoPO/G54Bv6ru3D95f0oFPTOwytw9QPak4OHohqUjTJPF7
   Q==;
X-CSE-ConnectionGUID: h2KhC9wvTyGRJtgMKpl4Cw==
X-CSE-MsgGUID: 7vVlCCFFRKyJ7HK2zNMSzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="82029415"
X-IronPort-AV: E=Sophos;i="6.24,203,1774335600"; 
   d="scan'208";a="82029415"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 15:07:11 -0700
X-CSE-ConnectionGUID: ienhfYh/TxauX7mKi7FgUg==
X-CSE-MsgGUID: 6KhnwWohRR++1/zOxTBnow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,203,1774335600"; 
   d="scan'208";a="252221845"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 15:07:10 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Sat, 13 Jun 2026 15:17:47 -0700
Subject: [PATCH v3 1/6] thermal: intel: Fix dangling resources on
 thermal_throttle_online() failure
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-rneri-directed-therm-intr-v3-1-3a26d1e47fc8@linux.intel.com>
References: <20260613-rneri-directed-therm-intr-v3-0-3a26d1e47fc8@linux.intel.com>
In-Reply-To: <20260613-rneri-directed-therm-intr-v3-0-3a26d1e47fc8@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: x86@kernel.org, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781389088; l=1702;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=StcGvNzhGAmHNtmfcblncLMfexDOq04lgNGUhRQ/2cY=;
 b=9GyH6V5wE4DGgny1iBTgcHCy72t7S41hOpTDFnHdhSnHSU3w9MOS5iA1hMPzI0dwmdWmhTFKQ
 llEfpTNlNYvDQIqhHTepcwoWRF4tg3Y3X7f3GIStY44hQtlMUGpvH/o
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

The function thermal_throttle_add_dev() may fail and abort a CPU hotplug
online operation. Since the failure occurs within the online callback,
thermal_throttle_online(), the CPU hotplug framework does not invoke the
corresponding offline callback. As a result, the hardware and software
resources set up during the failed operation are not torn down.

Since only thermal_throttle_add_dev() can fail, call it before setting up
the rest of the resources.

Fixes: f6656208f04e ("x86/mce/therm_throt: Optimize notifications of thermal throttle")
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes in v3:
 * None

Changes in v2:
 * Introduced this patch.
---
 drivers/thermal/intel/therm_throt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index 44fa4dd15dd1..45a8ef4a608b 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -529,8 +529,13 @@ static int thermal_throttle_online(unsigned int cpu)
 {
 	struct thermal_state *state = &per_cpu(thermal_state, cpu);
 	struct device *dev = get_cpu_device(cpu);
+	int err;
 	u32 l;
 
+	err = thermal_throttle_add_dev(dev, cpu);
+	if (err)
+		return err;
+
 	state->package_throttle.level = PACKAGE_LEVEL;
 	state->core_throttle.level = CORE_LEVEL;
 
@@ -548,7 +553,7 @@ static int thermal_throttle_online(unsigned int cpu)
 	l = apic_read(APIC_LVTTHMR);
 	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
 
-	return thermal_throttle_add_dev(dev, cpu);
+	return err;
 }
 
 static int thermal_throttle_offline(unsigned int cpu)

-- 
2.43.0

