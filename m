Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F7038B14C
	for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777101964; cv=none; b=Kzi4xYrVi0IWGgo6b9GCLI7tiAfYFidjCwbaLJC2EmKjhw0p+BVnhgYgLE1ks3x8jPhBvrAwVEFDVgT+ChcrRsp9HHVaoLkKSPTsU9U1jNn2DTnVy7qfTeTcKKPmWnS8lNhCRxlQ8Hcdg2Nx5NAiWDi5r5KuzSbVDTP6c3A8Q0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777101964; c=relaxed/simple;
	bh=T7h7irSBLWq/U1lRzuQYb0jvSsRiUlbJb2O/pK9DJ7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZeA8W+esOh9dxfmaE/jffbARGNwdUCCVcWgF0E8VIk+EIuvsvDHMvEv31fTmfp97ZS3B+Y/UD+vUrxrZSAwtvE4YMuWS/cy9uRO2DpXWENwmgBf9TT0pbhjiUUX2DeUCjqOUG+zhv6KwlZTU3v59gdLWLXYyzqHObfaRbIyrluA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBSYK8BV; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBSYK8BV"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38ddd8d3b7fso65858291fa.3
        for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 00:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777101959; x=1777706759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8eDBMesXv/7NfiAJfCSEhocv/ObRFG9TXrsVU0r254=;
        b=kBSYK8BV6IrGUIaabdLIm3xoRyyL1UDqU8ytRrFYpS8xs3qXJdRrCFHH0BymY5xvpl
         CO56AGAbM3rf9lxNqAkSOy0N25PkM8+zZOasdlKEXHwgdgx6v5qz1Z/BkFjPa8GWO1pR
         Mt0RFf7wXjPlcUOSHheBS7A1lyH4nKmG0AuwmUONjfp9wb5VUniA0Vqj8SYO8EsMg5/m
         5sOwqnZFTVca/URaSEAmweXJ23VC89Y/yQ1q37sCerYDyTstPofeVCaJz7/F4VP23NWO
         a/OartF7O7SraVy+83yKM4Sxq/onEkVi6FW6C0J88iMYQryEbQEBpWpLhDZbEGVe6N1+
         CAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777101959; x=1777706759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L8eDBMesXv/7NfiAJfCSEhocv/ObRFG9TXrsVU0r254=;
        b=PBbh3m5bCmJpXVWGLPlxsbyK7oKhFWCsrtjmSZjBaq6bgPi+8xcItkYZ/Kkyq5eRkf
         KnpRxHlcOl9VP8/r+d6QAMqCYWf3b4WWz91v60vNpBZKCNZmhq210UbMMszpk2nzuLds
         YHSE+o0RvolPRWZNY44bGRDqTp7NeprOJy4AWpJUxsYGPa7tHWmu5Xhixsv4h4rWuoIH
         T3E2Ad9AUZU/cHfsub9ev/546hUoWackFVQEwVpP4CqzCt2goyZwESQNp7dVewqiVstv
         xgKRQ6r3tbAKD7z4SWU+y5/iPQtl8e3NR1tikwTuDx3XX52S2D/rrHDZdpBxGarBaFU0
         GX+A==
X-Gm-Message-State: AOJu0YxSKfKXdA85SrT1ZqawQx61UoVw/6uYy3tTlsF2+RDlUjDKNHcW
	a7o315mqnWh58xVH/tSQHxR34d9oPTTCm8B69n14Yf8fulEfP7WH5CS7
X-Gm-Gg: AeBDieuvzFIFbDYnssZQqIEBsB6lklCQAUMZiEC+hsnnzu3doXDusNwzPEJ6JEt4+Oo
	RALCZwz3cAStnfVgXma6Nm5gwGwbW74ez0laPAKZSPzNtqwUT5MFUFQplAenL5qJzJic+S+Ry9o
	IBMhRioPsdyjZEnZ5GAiw95eEFdsW3aZO14HT5m93IlnYXzm7kN10qezCMu4XAIW6bV2lxUFOHk
	swGeK4NtL6QWuGg96Th0XVuOwfpUD2ufFQdCBTiWcXuUQjWpRcoUSfT6S0YKDARJ32pnC54mJ73
	P4eC41/1B6cBfECM97wvFn7nQF8Dxb89g1bn3ekIWQappzJsnOGbnhUmRBzR30zqKawc3sJuHng
	ojhMs3+FVSngVpvLRwBPw1o2pCRlwlo5tgX9DbXz+qAr8id6KIElgssiRZ7c7DhMlHYpC2ENEe3
	gPJZkBKmCnyeHatEgRTeg4oQHSl5xc/Jcu5IpElhV1xQXqnLJG2sSXwJJGtGFbNqsZEMac
X-Received: by 2002:a2e:bc26:0:b0:38c:13c8:a4b2 with SMTP id 38308e7fff4ca-38ec7ac9142mr124009801fa.17.1777101959088;
        Sat, 25 Apr 2026 00:25:59 -0700 (PDT)
Received: from abityuts-desk (176-93-242-43.bb.dnainternet.fi. [176.93.242.43])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb5f6666sm55070071fa.15.2026.04.25.00.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 00:25:57 -0700 (PDT)
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH 2/3] intel_idle: Introduce a helper for checking PC6
Date: Sat, 25 Apr 2026 10:25:31 +0300
Message-ID: <20260425072532.358365-4-dedekind1@gmail.com>
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

Introduce the skx_is_pc6_disabled() for checking if PC6 is disabled and
switch the following functions to use it:

- skx_idle_state_table_update()
- spr_idle_state_table_update()

At the same time, clean them up improving the commentary and moving it to
the function kernel-doc.

Purely a clean up, no functional changes intended.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 48 +++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 49894c6c7f20b..562f8e27256e7 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -2037,12 +2037,13 @@ static void __init sklh_idle_state_table_update(void)
 }
 
 /**
- * skx_idle_state_table_update - Adjust the Sky Lake/Cascade Lake
- * idle states table.
+ * skx_is_pc6_disabled() - Check if PC6 is disabled in BIOS.
+ *
+ * Return: %true if PC6 is disabled, %false otherwise.
  */
-static void __init skx_idle_state_table_update(void)
+static bool __init skx_is_pc6_disabled(void)
 {
-	unsigned long long msr;
+	u64 msr;
 
 	rdmsrq(MSR_PKG_CST_CONFIG_CONTROL, msr);
 
@@ -2053,35 +2054,34 @@ static void __init skx_idle_state_table_update(void)
 	 * 011b: C6 (retention)
 	 * 111b: No Package C state limits.
 	 */
-	if ((msr & SKX_PKG_CST_LIMIT_MASK) < SKX_PKG_CST_LIMIT_PC6) {
-		/*
-		 * Uses the CC6 + PC0 latency and 3 times of
-		 * latency for target_residency if the PC6
-		 * is disabled in BIOS. This is consistent
-		 * with how intel_idle driver uses _CST
-		 * to set the target_residency.
-		 */
+	return (msr & SKX_PKG_CST_LIMIT_MASK) < SKX_PKG_CST_LIMIT_PC6;
+}
+
+/**
+ * skx_idle_state_table_update - Adjust the SKX/CLX idle states table.
+ *
+ * Adjust Sky Lake or Cascade Lake Xeon idle states if PC6 is disabled in BIOS.
+ * Use the CC6 + PC0 latency and 3 times of that latency for target_residency.
+ * This is consistent with how the intel_idle driver uses _CST to set the
+ * target_residency.
+ */
+static void __init skx_idle_state_table_update(void)
+{
+	if (skx_is_pc6_disabled()) {
 		skx_cstates[2].exit_latency = 92;
 		skx_cstates[2].target_residency = 276;
 	}
 }
 
 /**
- * spr_idle_state_table_update - Adjust Sapphire Rapids idle states table.
+ * spr_idle_state_table_update - Adjust Sapphire Rapids Xeon idle states table.
+ *
+ * By default, the C6 state assumes the worst-case scenario of package C6.
+ * However, if PC6 is disabled in BIOS, update the numbers to match core C6.
  */
 static void __init spr_idle_state_table_update(void)
 {
-	unsigned long long msr;
-
-	/*
-	 * By default, the C6 state assumes the worst-case scenario of package
-	 * C6. However, if PC6 is disabled, we update the numbers to match
-	 * core C6.
-	 */
-	rdmsrq(MSR_PKG_CST_CONFIG_CONTROL, msr);
-
-	/* Limit value 2 and above allow for PC6. */
-	if ((msr & SKX_PKG_CST_LIMIT_MASK) < SKX_PKG_CST_LIMIT_PC6) {
+	if (skx_is_pc6_disabled()) {
 		spr_cstates[2].exit_latency = 190;
 		spr_cstates[2].target_residency = 600;
 	}
-- 
2.53.0

