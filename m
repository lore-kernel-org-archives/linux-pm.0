Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AAB35B63B;
	Fri, 14 Aug 2026 03:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677366; cv=none; b=VFgR8zLS5K9sS2Ki+RPmj6BZUMQ6R7pTFl1+rgKx+f7je0C9ZoSgWPQmMgmYagz1+d94/RHazueD361VFOsTd/s1ZTmMC7PmzzEevxK2DNsXPHxJjTwqDHq26sBcVfARV9K3DSZOT/qNxNLBntiKozWw9y1X2VZHb8blzKCcvN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677366; c=relaxed/simple;
	bh=6uIxaTff5nTxfJ+OZOhLtHzlNdjNB2zYU+47m+1/4es=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uL3Pjzh3JDYwSX7V6ZHVPxyiCPQCwsoix5+4LT+vrXGksHgLpviAYvzefEp4/O4n9dunuq/PqctsbTOhdu4VdYOSnrTqtsd2eZoHpakjLio1IuMteuoHElMgfTdGJcRqBu1eH3Pa0ygdoVhn8ZLMbtjwySXAJbpAlWAhjm2r74g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HHDPZAmM; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHDPZAmM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786677364; x=1818213364;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6uIxaTff5nTxfJ+OZOhLtHzlNdjNB2zYU+47m+1/4es=;
  b=HHDPZAmMJF2LEoDfotfc63BBQ54a+S/SUf6rtzZ77uyEAS17VCOXgAZJ
   uNcZXjeRevWk/b+JWB+5FVEW7TQyuGzIvuNlUxHkVWmviKLeG5TnLy3IG
   PjpeeHT1ltPzIlRX/CO0N/s0+feNCy3CTwtcGZIS3wmjU8ZyQfe1RnAWo
   KIDFgf6hqYx4ghfnGTJYp8t4mwIHuwN/vNPPDfzFVPYOrJRz9yIyZ3jnH
   UHpnD3bZtytWN3AqODd5mMHxKacsMZPz3MCrm/OSuMHyoTH3Lv1l9suW+
   X7sEwTyxNHY4qYAlpUayuox2mbYrUCnNY0ik6Muw0cWWRQn3O8pd/CaIL
   Q==;
X-CSE-ConnectionGUID: LX1SzkA5TuaR4IyYxGU2/w==
X-CSE-MsgGUID: MPhvAy01QOK0tXHsz5AnMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87183940"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87183940"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 20:16:03 -0700
X-CSE-ConnectionGUID: ODWtphyHR82zNARXSMQ7iw==
X-CSE-MsgGUID: P1dvFXueQEa3zO/dKMvs0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="288901133"
Received: from liyifan1-desk.bj.intel.com ([10.238.152.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 20:16:01 -0700
From: Li Yifan <yifan2.li@intel.com>
To: rafael@kernel.org,
	rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	jianfeng.gao@intel.com,
	anand.b.jyoti@intel.com,
	lili.li@intel.com
Subject: [PATCH] powercap: intel_rapl: Sign-extend the PMU delta on counter wraparound
Date: Fri, 14 Aug 2026 11:10:08 +0800
Message-ID: <20260814031008.750911-1-yifan2.li@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Li, Yifan" <yifan2.li@intel.com>

The RAPL PMU misreports energy when the hardware energy counter
overflows and wraps back to zero.  perf event counts are defined to
increase monotonically, but a single wraparound makes the PMU event
count jump backwards by nearly the full counter range, and consumers
that take the difference of two reads in unsigned arithmetic then
underflow and report an absurd value.

On a Panther Lake system (energy unit 61.035 uJ, counter range
262144 J) the package counter wraps every ~2.9 hours at 25 W, and
turbostat prints one bogus sample per wraparound, per domain:

  PkgTmp  PkgWatt         CorWatt GFXWatt RAMWatt SysWatt
  44      24.97           16.30   3.90    1.87    2145386370.35
  43      2145240612.10   16.13   4.02    1.91    40.46

The RAPL energy counters are 32-bit wide on every register interface:
MSR, MMIO and TPMI all describe ENERGY_COUNTER with a GENMASK(31, 0)
mask.  rapl_read_data_raw() applies that mask, so event_read_counter()
returns the counter zero-extended in a u64.

rapl_event_update() then computes

	delta = new_raw_count - prev_raw_count;

without reducing the result modulo 2^32.  While the counter does not
wrap this is correct, but once the hardware counter wraps,
new_raw_count < prev_raw_count and delta becomes (true_delta - 2^32),
a large negative value.  Declaring delta as s64 only makes that value
representable; it does not correct it.  That bogus delta is scaled and
added to event->count, which is where the backwards jump comes from.

Fix it the way arch/x86/events/rapl.c has done since the RAPL PMU was
first introduced: shift both values up so that the 64-bit subtraction
reduces modulo 2^32, then shift the difference back down with an
arithmetic shift to sign-extend it.

This is correct as long as at most one wraparound happens between two
updates, which the existing overflow hrtimer already guarantees: its
period is half of the counter range at the 200 W reference used in
rapl_package_add_pmu_locked().

The problem has been present since the powercap RAPL PMU was added, but
only affected TPMI RAPL until commit 748d6ba43afd ("powercap:
intel_rapl: Enable MSR-based RAPL PMU support") routed MSR RAPL through
the same PMU, which exposed it on client platforms such as Panther Lake.

Fixes: 575024a8aa7c ("powercap: intel_rapl: Introduce APIs for PMU support")
Reported-by: Jyoti, Anand B <anand.b.jyoti@intel.com>
Signed-off-by: Li, Yifan <yifan2.li@intel.com>
Signed-off-by: Gao Jianfeng <jianfeng.gao@intel.com>
Tested-by: Jyoti, Anand B <anand.b.jyoti@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 1006d183d508..6b7d11a0abc5 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -32,6 +32,9 @@
 
 #define ENERGY_STATUS_MASK		GENMASK(31, 0)
 
+/* Width of the RAPL energy counters, see the *_ENERGY_STATUS_MASK defines */
+#define RAPL_CNTR_WIDTH			32
+
 #define POWER_UNIT_OFFSET		0x00
 #define POWER_UNIT_MASK			GENMASK(3, 0)
 
@@ -1227,6 +1230,7 @@ static u64 rapl_event_update(struct perf_event *event)
 	struct rapl_package_pmu_data *data = event_to_pmu_data(event);
 	u64 prev_raw_count, new_raw_count;
 	s64 delta, sdelta;
+	int shift = 64 - RAPL_CNTR_WIDTH;
 
 	/*
 	 * Follow the generic code to drain hwc->prev_count.
@@ -1243,8 +1247,13 @@ static u64 rapl_event_update(struct perf_event *event)
 	 * Now we have the new raw value and have updated the prev
 	 * timestamp already. We can now calculate the elapsed delta
 	 * (event-)time and add that to the generic event.
+	 *
+	 * Careful, the counter is narrower than u64 and is not
+	 * sign-extended above its physical width.  Shift both values up
+	 * so that the subtraction wraps, then shift the result back down.
 	 */
-	delta = new_raw_count - prev_raw_count;
+	delta = (new_raw_count << shift) - (prev_raw_count << shift);
+	delta >>= shift;
 
 	/*
 	 * Scale delta to smallest unit (2^-32)

base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
-- 
2.43.0

