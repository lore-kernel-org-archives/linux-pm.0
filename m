Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C865439E166;
	Tue, 24 Mar 2026 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774373035; cv=none; b=M5OT2gzcrZBy/WDvneSq8HmZgOh4h5BHNk596Ih6JL74diMjuMiqcfAdLkrHvyR+LzFzjTZg/eRWkpdkdpn4xidMOZ/sw/RbVhGNq33wy62v/pMn0wmB6pQj3+0EKoywfWhOlKj6384FDTcJQaxcGni5J+KEJx0oTae84Avk40o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774373035; c=relaxed/simple;
	bh=O1s1SeP71T9DdP4rd44EOltS9cMiz9/Virs5jGh6PH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tRWs3Ai0Jp0/E4odUeR8yB02Vy+VXsvjBzsk6q9laz9mmLfSjCv/3vzGt6dnL0on1ZDeBoqkTdEPxPEHas0EgmeFJA+2eOxKKah9et98CfFiOyhIYiCm/KyGn28z/Iv0OCFj5Kz6GRXqkcH/piXNF5t+CzTq+lGSxpn1FCQ+/fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZ+oSxHr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZ+oSxHr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774373034; x=1805909034;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O1s1SeP71T9DdP4rd44EOltS9cMiz9/Virs5jGh6PH0=;
  b=DZ+oSxHrNliXboKqGunX0JDcsdkPgYMLcQPvi7eVOn+/NTprEOwIlxek
   OXLSkCJKYDF1/60p93bFcAsXVfxYedFlWQ9UlYA6kXNFS7o9fCNRoMy9Q
   H76k/04BmrLWGUu1LrsbmBFqxxKSJU3H359RkhcD3fknDTON4lNwUgJXc
   nBbYhnMS6KHW602uOvV/5lsb/TiwV6QDuHbQ2on7K5+YzRIKkd2xigL73
   mhZKvck2zD0MDVW86QbLFKT96RAMspqbrlHxiAt5oIzQWsymn38jyx6X1
   j9pyIUNaPfLz0l0MGc3LUA1PjT+++Dp2XFUsQQcY7U38ZQ6PMtuWWoXbf
   A==;
X-CSE-ConnectionGUID: Pb0P/KGETCaMUMh8l9lFqQ==
X-CSE-MsgGUID: eZdkomu6S+uFXrCPzTNZ3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86015537"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86015537"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:23:53 -0700
X-CSE-ConnectionGUID: fIbhDCrTSGikLE8N1cZgrg==
X-CSE-MsgGUID: cr7SyxJRR+WJNQetNPMSQg==
X-ExtLoop1: 1
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa003.fm.intel.com with ESMTP; 24 Mar 2026 10:23:52 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Erin Park <erin.park@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] thermal: intel: int340x: Power Slider: Set offset only for balanced mode
Date: Tue, 24 Mar 2026 10:23:46 -0700
Message-ID: <20260324172346.3317145-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The slider offset can be set via debugfs for balanced mode. The offset
should be only applicable in balanced mode. For other modes, it should
be set 0 when writing to MMIO offset,

Fixes: 8306bcaba06d ("thermal: intel: int340x: Add module parameter to change slider offset")
Tested-by: Erin Park <erin.park@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@vger.kernel.org # v6.18+
---
 .../intel/int340x_thermal/processor_thermal_soc_slider.c  | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
index 49ff3bae7271..91f291627132 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
@@ -176,15 +176,21 @@ static inline void write_soc_slider(struct proc_thermal_device *proc_priv, u64 v
 
 static void set_soc_power_profile(struct proc_thermal_device *proc_priv, int slider)
 {
+	u8 offset;
 	u64 val;
 
 	val = read_soc_slider(proc_priv);
 	val &= ~SLIDER_MASK;
 	val |= FIELD_PREP(SLIDER_MASK, slider) | BIT(SLIDER_ENABLE_BIT);
 
+	if (slider == SOC_SLIDER_VALUE_MINIMUM || slider == SOC_SLIDER_VALUE_MAXIMUM)
+		offset = 0;
+	else
+		offset = slider_offset;
+
 	/* Set the slider offset from module params */
 	val &= ~SLIDER_OFFSET_MASK;
-	val |= FIELD_PREP(SLIDER_OFFSET_MASK, slider_offset);
+	val |= FIELD_PREP(SLIDER_OFFSET_MASK, offset);
 
 	write_soc_slider(proc_priv, val);
 }
-- 
2.52.0

