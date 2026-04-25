Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB85351C0B
	for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 07:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777101955; cv=none; b=YqdaCl/dPDqAlAkh1GeuFDTTa4ebXRMaGrVfepe8cxK/s3JqVtlIZfFniQuBhrS42GzkmQJjtcLvTvIDkqxQVTvWd5zj9MWrUOikj2jVOGWtMfeJ7otFCCWIcKkVehwb4ghBE1gnXpdVV4NCPv7UX69YkQPF1u57ubz55J5HJBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777101955; c=relaxed/simple;
	bh=G0NLKrEzJnKwcOcXPpg+qzhjRx103Qi8X2ZTJ+d9rEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/r49JDeRun8IBTJ2z5V7sUrrS9hzbNZXBdNkb++KfEDM0gr1C+QXlYy6vEQ2wf7U0MQ8c8url5eOa58UUGQI76AXl005OrV21ZNE75XV9GJRGzOgxhmAFZzygo57Q6IK3+IaNuiE3vM5fpoSmCyrCqTLex17NIjc7Kf7ERcY/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsuZ+a3x; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsuZ+a3x"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38e800deae4so72588371fa.0
        for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 00:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777101951; x=1777706751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgF0rcrdAzfFGU1Sy4f6d9I5qQnUP4w6juIeyC+BqG8=;
        b=lsuZ+a3x8usHI7J1GDJy+mvrXQV6iOdDX2c4ieAcUvxTw+Axg4Ieejti7d9fpM+uMx
         4Lery22BvnTKmdG4AdnUpTo8mFYBa78CZuLBzKC6nDBMNwG2UBormK5sznASZ8PnM3Es
         8Zq46OalUAlnef2J8dKmhW+MYXa70aKgk3GN4lJnodiljWJNwYLu/hExvZa4Gv5ElrQz
         px6LKyzpwyJY1ud5WU0uG3JLjQnEcwDR1uSSrNP1fs/OXsBtCxmK+IARIRsvcFJFAhqh
         lXegQ18cgU+SryE9RYRQknJPc4FQI2WLR4pm8HM2jVAUyYMNaxerRfLzhrv3ppRE5t1L
         Tm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777101951; x=1777706751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CgF0rcrdAzfFGU1Sy4f6d9I5qQnUP4w6juIeyC+BqG8=;
        b=tJwWqjHuxWn3B3sxz3rZiuTXqNhuixcOaKHV50VAbeTuWgFfu0v4hfpeNy0LrfBLGY
         szbd9oMg8EDOdR1yH7yvG91yX9PhrRgyNUO/jEnJ5CKCWVyV9ZMi5QUB/V9ornKbNpNB
         bTTFlCa8Uzy0wr8Jv2KhjX4M9gSbJzlBugdysekET4tSziEERA8eiXqhYnA+i8NsP6FJ
         mxHkibVAmx/E9wZE7OaGKm9Qn3va40/HQBlLnwbLpAy6QRElJMp7f7+PpdS6zg97AxvB
         3F5kq2QajP4eWZUbLiIru5FxjfS7tYL9Glb78Qr1e5JR0jEyy0kt9z36K/TO5u3o1++5
         k9qw==
X-Gm-Message-State: AOJu0Yw4NEMuVeW8R1KebAo1IvVOAfq7Pvj7vr4uvwKZBIPVA3klU4Ge
	gZVPFyWoqgix1Bc6e5h9e/O3EWZkbqbEi2jTWWKRgPyHSDJIGzRAKeYsWKB2tV0k
X-Gm-Gg: AeBDiet9iL7d8CwDQOXuUwCkAQtiXgx/6OCUGWf6y0hfs7sFSQQtouVTbDx4jG3SKJs
	VxfcLi6n2AZauBZ4ptD/XmEj+nMgOn+r8jARqaFurStRB+4Z8GyNZVNWtYMlxG94L/4l4zeMgv+
	TwSl+qWqX8PSNMtp6cnSNQa9bswBdtSj4QkEc+ne2e6sjiIxjObAhxD+VF63cKLcaFWwMA5VV82
	V96FHQ5+dIdPKIplZfKkhMegv+oRlvhin8kQ8xlHgjj6QH70hjORbhBPWoHZ5p9XXZ1NcU18wQG
	o+5Qk9MWSZcdxDwRyP/8vv//Vd4oYxtLAhP2JUlxbGw8pNCB0/Jtcs4vc/VDZrjGEOnTStfyiY7
	U2xva+XfbbChCYqtHEmvl3jRKAInAX5GI1nQdJJwfn9lzAfj+jEB/35R2kWpBx7wcLte0knK7zh
	7hh/CGcM7R5UozVVgyYjc3msGlQ0834ycu4W/v93aEeYQwbdbcPawXeiyRSQefDs3eqRKU
X-Received: by 2002:a05:651c:2109:b0:38f:e440:893 with SMTP id 38308e7fff4ca-38fe4400cc5mr89685771fa.5.1777101950310;
        Sat, 25 Apr 2026 00:25:50 -0700 (PDT)
Received: from abityuts-desk (176-93-242-43.bb.dnainternet.fi. [176.93.242.43])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb5f6666sm55070071fa.15.2026.04.25.00.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 00:25:49 -0700 (PDT)
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH 1/3] intel_idle: Add constants for MSR_PKG_CST_CONFIG_CONTROL
Date: Sat, 25 Apr 2026 10:25:29 +0300
Message-ID: <20260425072532.358365-2-dedekind1@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425072532.358365-1-dedekind1@gmail.com>
References: <20260425072532.358365-1-dedekind1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Add two constants for the package C-state limit fields in
MSR_PKG_CST_CONFIG_CONTROL.

The SKX_ prefix stands for "Skylake Xeon" and makes it explicit that
the mask is CPU model-specific. The same values have applied to all
Xeon platforms starting from SKX.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index f49c939d636f4..49894c6c7f20b 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -81,6 +81,11 @@ static bool ibrs_off __read_mostly;
 /* Maximum allowed C-state target residency */
 #define MAX_CMDLINE_RESIDENCY_US (100 * USEC_PER_MSEC)
 
+/* The Package C-State Limit bits in MSR_PKG_CST_CONFIG_CONTROL */
+#define SKX_PKG_CST_LIMIT_MASK GENMASK(2, 0)
+/* PC6 is enabled when Package C-State Limit >= this value */
+#define SKX_PKG_CST_LIMIT_PC6 2
+
 static char cmdline_table_str[MAX_CMDLINE_TABLE_LEN] __read_mostly;
 
 static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
@@ -2048,7 +2053,7 @@ static void __init skx_idle_state_table_update(void)
 	 * 011b: C6 (retention)
 	 * 111b: No Package C state limits.
 	 */
-	if ((msr & 0x7) < 2) {
+	if ((msr & SKX_PKG_CST_LIMIT_MASK) < SKX_PKG_CST_LIMIT_PC6) {
 		/*
 		 * Uses the CC6 + PC0 latency and 3 times of
 		 * latency for target_residency if the PC6
@@ -2076,7 +2081,7 @@ static void __init spr_idle_state_table_update(void)
 	rdmsrq(MSR_PKG_CST_CONFIG_CONTROL, msr);
 
 	/* Limit value 2 and above allow for PC6. */
-	if ((msr & 0x7) < 2) {
+	if ((msr & SKX_PKG_CST_LIMIT_MASK) < SKX_PKG_CST_LIMIT_PC6) {
 		spr_cstates[2].exit_latency = 190;
 		spr_cstates[2].target_residency = 600;
 	}
-- 
2.53.0

