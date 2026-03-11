Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF25B3C65E7
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219660; cv=none; b=Zhc6CP4kXgwJi58y2sogI2TUkz5sda6WghTRqau4u+VdXmQ/qziLeIbhWmq9DMhrOZ6WGuus7KTQMC0oCLUVyo24Bf1DrBhjcpjr/fIVvEueAuh+liniV/y+yVc+v3P/c1ADOR4eCHB0cn7S9J2iTvJ8ggxhxqwT3wgsDTTo3vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219660; c=relaxed/simple;
	bh=cJ+d+rOQKudOiBAOEOI1nYCIBWOeOZZ4xvBEf0Gbt/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwKsxSrIoV9FQGkU2zHwW4TDR8a0qzM7fo0cvYzLHw5Rhm7jLP5MaL8/3mnvAa+T5/UkEqTDIaqphqfhox8ViGqhuk2UQxT25undphXqLpoz1Yo5QbvpS/cuRRzkNyWusaJMtlbFabd3/7QKdW05s4GLY6FgY8vfow11/lRjp5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2E8LZ8K; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2E8LZ8K"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a1307438ddso6231957e87.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 02:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773219652; x=1773824452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXVrsdYNIT957wfoBPJi/IwRZHNLbulJouNlvCmnfp0=;
        b=O2E8LZ8KTaLoerBKVI6Ff+B7hZ4su3hjJidfmtEgHPc3vllUqSe92F0woMTY1F/hn9
         Y55RX2/FN5M2Orh0jaePYBlhYK9cTuTGENwmv7q/UO1SgU4RaK2e8HeNqx1IA5bhWIP7
         ztyuHHaaLFeZMBGmomat66aT9KXGPh0cnrzFzM314bzxn1jQEmD5FwZHJYSstWD2wlWY
         tcvqam6RNhLjxrzK0Vm/Ro83McUnnpAbEgYDgUYFFQcRnuBdJAF7ub9GSP/+hflswsPc
         yIZpp7OdIxEvOXwhYAQF4/uOkTz0Zio6ifiejVuqIXTKSaQ7+QV+Y3oP47I4cHr+XGFG
         6o1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773219652; x=1773824452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qXVrsdYNIT957wfoBPJi/IwRZHNLbulJouNlvCmnfp0=;
        b=s+QBBzdgzzAqOzHgshgSFbXY0ThfCVL4nSER2Ay59+rYTg0Ghdl1Re/R5LNusPvpbY
         niDqXCTm9TzMiD7uSzj276V+fz34gwSEYSfp5kquFNN0uE9d6tf2TgykonVrDAlVIL+h
         unJJw4v7961RdEcEq8zkVQqC3nSF/w7rd2cmzMiCPfUq1rMNljdMmolS9EsMdalsNixr
         C30m26/tDQ+mh/gE5jQcbn1I3OiqbTVF0xhK/Ja3+mhq8oH5bGuKVc67EEixd2XcOsq4
         UHuRxxsxexACQM0wb3zNP7rew/nBr6NCdoFIwDMW9j/GGxeie6nGp/9A5Oz/G6o/niGx
         RW4Q==
X-Gm-Message-State: AOJu0YzDp1Pfy5ZNdQIMXxx6ZdJ08J3RdUV+yKnXFLEVSpsAgodGcybv
	hjh7LVgu1RgCOQ/DVpTCGI2QknHCvqx+P5ATExplaUAivtCZ1c8ZoDn/
X-Gm-Gg: ATEYQzwajQnWhdTvNtUMwjsSDa45wiiLU6JaOQdDAYJ37NM4KeNphSGXCliXl3I1RCh
	ViOomTH92tBzfeeXU1kINGqTW7N+WzBMQojBR/eFIEg5ifYZb7+dKm5biCx84NSJQk21Zt/uDc0
	m4IzQnfl29eiDhZ9IfRxFjw7GR5GYl8Lwtu9kE9W1Pfbe1YU2fK20HUCwgCXb7vAlISOjIhz6Ee
	fyrIwt272gl8hKAxkgfNGBmvBiaHiVlety9azrBHCf5nJJxsjhABNLmmZornBhjITt0C9gM/7Ax
	C4lux3+3RgSydz8xnjMuGiCpp4ud80G/teLHNv+cS91yM0tbPSLp8OFbbEfmYyU/LUqIqsuapic
	GmOIv+qR+0e7lZj5467pyTlgSja6SAG3XszKwSyY3OcLm4iVAxe1dvJNwN0NvP11FYSsDZBiNQQ
	3Fz7Z/TQn83o3DBpXT5iLLhIy0Si5KBWUTcyR0yNMAr9EWdNRe4m100U1mBTxj
X-Received: by 2002:a05:651c:1584:b0:38a:254a:e026 with SMTP id 38308e7fff4ca-38a67e70a67mr5767191fa.35.1773219650977;
        Wed, 11 Mar 2026 02:00:50 -0700 (PDT)
Received: from abityuts-desk (176-93-227-108.bb.dnainternet.fi. [176.93.227.108])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e5ed41sm2645041fa.25.2026.03.11.02.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:00:49 -0700 (PDT)
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Len Brown <lenb@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>,
	Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 3/5] tools/power turbostat: fix --show/--hide for individual cpuidle counters
Date: Wed, 11 Mar 2026 11:00:33 +0200
Message-ID: <20260311090035.169539-4-dedekind1@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311090035.169539-1-dedekind1@gmail.com>
References: <20260311090035.169539-1-dedekind1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Problem: individual swidle counter names (C1, C1+, C1-, etc.) cannot be
selected via --show/--hide due to two bugs in probe_cpuidle_counts():
1. The function returns immediately when BIC_cpuidle is not enabled,
   without checking deferred_add_index.
2. The deferred name check runs against name_buf before the trailing
   newline is stripped, so is_deferred_add("C1\n") never matches "C1".

Fix:
1. Relax the early return to pass through when deferred names are
   queued.
2. Strip the trailing newline from name_buf before performing deferred
   name checks.
3. Check each suffixed variant (C1+, C1, C1-) individually so that
   e.g. "--show C1+" enables only the requested metric.

In addition, introduce a helper function to avoid repeating the
condition (readability cleanup).

Fixes: ec4acd3166d8 ("tools/power turbostat: disable "cpuidle" invocation counters, by default")
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 35 ++++++++++++++++-----------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 4d954533c71de..3487548841e1d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -11285,6 +11285,14 @@ void probe_cpuidle_residency(void)
 	}
 }
 
+static bool cpuidle_counter_wanted(char *name)
+{
+	if (is_deferred_skip(name))
+		return false;
+
+	return DO_BIC(BIC_cpuidle) || is_deferred_add(name);
+}
+
 void probe_cpuidle_counts(void)
 {
 	char path[64];
@@ -11294,7 +11302,7 @@ void probe_cpuidle_counts(void)
 	int min_state = 1024, max_state = 0;
 	char *sp;
 
-	if (!DO_BIC(BIC_cpuidle))
+	if (!DO_BIC(BIC_cpuidle) && !deferred_add_index)
 		return;
 
 	for (state = 10; state >= 0; --state) {
@@ -11309,12 +11317,6 @@ void probe_cpuidle_counts(void)
 
 		remove_underbar(name_buf);
 
-		if (!DO_BIC(BIC_cpuidle) && !is_deferred_add(name_buf))
-			continue;
-
-		if (is_deferred_skip(name_buf))
-			continue;
-
 		/* truncate "C1-HSW\n" to "C1", or truncate "C1\n" to "C1" */
 		sp = strchr(name_buf, '-');
 		if (!sp)
@@ -11329,16 +11331,19 @@ void probe_cpuidle_counts(void)
 			 * Add 'C1+' for C1, and so on. The 'below' sysfs file always contains 0 for
 			 * the last state, so do not add it.
 			 */
-
 			*sp = '+';
 			*(sp + 1) = '\0';
-			sprintf(path, "cpuidle/state%d/below", state);
-			add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
+			if (cpuidle_counter_wanted(name_buf)) {
+				sprintf(path, "cpuidle/state%d/below", state);
+				add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
+			}
 		}
 
 		*sp = '\0';
-		sprintf(path, "cpuidle/state%d/usage", state);
-		add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
+		if (cpuidle_counter_wanted(name_buf)) {
+			sprintf(path, "cpuidle/state%d/usage", state);
+			add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
+		}
 
 		/*
 		 * The 'above' sysfs file always contains 0 for the shallowest state (smallest
@@ -11347,8 +11352,10 @@ void probe_cpuidle_counts(void)
 		if (state != min_state) {
 			*sp = '-';
 			*(sp + 1) = '\0';
-			sprintf(path, "cpuidle/state%d/above", state);
-			add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
+			if (cpuidle_counter_wanted(name_buf)) {
+				sprintf(path, "cpuidle/state%d/above", state);
+				add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
+			}
 		}
 	}
 }
-- 
2.53.0

