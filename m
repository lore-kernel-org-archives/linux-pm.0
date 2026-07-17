Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCA73F58E5
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784288736; cv=none; b=l1x/iHyjMbNWJ+sl45DondFMxE3Vlcs2xqPnuZFJ8CKdSVKkD2gXjG2FLRY3VC5G8hB1iS14vIyQasmt/mNS1QE+N2bln/eTo6j0BXatjryKMifo4dAaM+8cIv8MOaDm/dWE3yH9xtj20zh3bIAoC6bxUS0dw8fB2NlUZIrXo8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784288736; c=relaxed/simple;
	bh=V9TJQeJDtwPZHRHCClVfxnDoHmjW6Asb0jblQBDGlPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=InYZ5m8bEa9vSigee2pWjZCVPYYnRBbpiOJSs0OH8xxDtSV9j7s2PgrCoFhNwkUAMAmp7K3JoRE4MST2BZ0nctx+7fc7IB3qeql3j+iyq6qMZFbls0Gk7+UxwQvALEMfzbyUfkRMOXIcOYiVczvld1m2XlysLwySHMncZt6osYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=bCEieb4T; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="bCEieb4T"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493ce08a75bso31670935e9.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 04:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1784288730; x=1784893530; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vGa2tLcXUkY6VT0pHnm1aBNIi5io7BvM2TkFj4un+js=;
        b=bCEieb4TNd7DxvzJnI2hPJqrPnFKBSTmxlhaLDMvdNLwuj3pvziApV3a+HOgo2ruIT
         f4Mbpn2a1NIY14RPOzHcMOXKtAb0/qMwfPScvNd2k2ok/L3KMLEU+5j8c//qr9+1oHi1
         /xYuaX7W2mbZeh3wMWF0vK5SUXObwL1d+rYrK+80byaC6qJjoPHV9VITGRP3AhPK1acL
         dww2yk2YZOFt2rWHJbxYUZLp7ntejSV/uUX8wHFnKNXK2irjjobMCXkVtA8k/3lUswUS
         s51uRbg4zvTTDCotD9IgB74zj01rywUlqWQ/7DGjUdrJ/VDNNzV4XrxZh18mrZWTtkGl
         wPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784288730; x=1784893530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vGa2tLcXUkY6VT0pHnm1aBNIi5io7BvM2TkFj4un+js=;
        b=P6uOKLB7mHULraEkehRuuPoTwoMQWMUza2vRvgCRBlfhyxorduaty9ydenTaa8mdNj
         Gde0uXucPgzGPyBHnXpDte8xq917LEjEST5aQdar03QK9LDqw00+aPK74W9YgjpI3U+h
         Y3QSOIbaU3SUz3/2fn5Z6rks04RV13yfu0gR5R6XzMjSuczDsCDKp9dhg5Ht6tEw+HqU
         m6s+gkgfnXIWO5brhwy1LZnCQVYoqyRbn7v5NWS9ks7voReGNJyM8bE0Otl18TNtVQSc
         CgNZsjWD9cQspjT0fqsMRS0+vcU3dj6uQK3GJgDEnXjyem4S3cdzXam7FSWrYr8Rof/P
         l+2A==
X-Forwarded-Encrypted: i=1; AHgh+Rp/BZAy27o31xyUafSz7V+2j634Kj9RdxWKIFFhOAgKkLaHJ3HyC1qfaQi14Uz3KPjkljUMOFqLRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkTUjHSy2Nn6p6EqYa1jxB+0/gjIM6pepbxqa6S3em9lBi8/eM
	Tfxn2n5Q+Tlh9eFJH2kLF/7HLYILF/1EbQLQ1VBpS7kh1CA91dCxRKPGdtRW0m+n+Tq0WmLEuXt
	m+FxgMWkoJg==
X-Gm-Gg: AfdE7cldrK/NJ9AKEk0M0OI5MTsGmIqCA3ko6eSkF+ozQYerJ0kIMLQ+AT6BQFXH1gV
	6hjMKt1ii1dx+SjNU4DVwWyCCwZfzoBbdGsVoRnIZ5BBIoBHsPOQwcQUkKb5hfnbzTPuuenol4g
	RAz4xLPGaTV6oHM/cyi9h4i7uM9YB3z3XuMiV2ayh7zerlOtINZw0Ur6/6rIo1WD9pypgA/k4Te
	WF07EvbRefoV+5uaHehn5Us1UBn2PAuS3krpmx6rWOEhVkm+HutwLP8KLc0yTZDBquWkgTuG0jK
	DY1lL3MPy2HV8CYpHOceJCwRN82Z6ldac35yx7ZxsQtltxnV5yTIRvUCsTmaesTD9/aje7OpA7h
	Ta0SBcSshfKZ3pC73ITqnJox2wttRXAca1lGixv/pT1vKm0PBvom3FP2euiNTNu2fVmhJ9yG4rz
	UkGwU7fk+5Z0w7jao=
X-Received: by 2002:a05:600d:2389:b0:492:3e66:6c84 with SMTP id 5b1f17b1804b1-4954a51619cmr19390485e9.30.1784288730519;
        Fri, 17 Jul 2026 04:45:30 -0700 (PDT)
Received: from [172.18.170.139] ([185.104.138.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495499f3f99sm41353855e9.0.2026.07.17.04.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 04:45:30 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 17 Jul 2026 13:45:03 +0200
Subject: [PATCH 2/2] arm64: dts: qcom: milos: Add CPU-to-DDR BWMON support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-milos-cpu-bwmon-v1-2-dfe0bac9898c@fairphone.com>
References: <20260717-milos-cpu-bwmon-v1-0-dfe0bac9898c@fairphone.com>
In-Reply-To: <20260717-milos-cpu-bwmon-v1-0-dfe0bac9898c@fairphone.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784288726; l=1914;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=V9TJQeJDtwPZHRHCClVfxnDoHmjW6Asb0jblQBDGlPE=;
 b=OL2/CjOp7BFCdxf5DVsrPxbhzobLRkYVetwVOKCkyVLReYS6VFAQaZFqeSlFJxip7W14I7TK/
 3OK0oBvZ086AkdvCEuw3dSNh62ivi+5coiJVx0sdULfsutHJ2NkKRDe
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add a node for the CPU-to-DDR BWMON on the Milos SoC and the
corresponding OPP table.

Currently, the table is for DDR5, the values for DDR4 are put into a
TODO comment, until the kernel can differentiate between DDR variants.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/milos.dtsi | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/milos.dtsi b/arch/arm64/boot/dts/qcom/milos.dtsi
index e91c0cf5e093..9b79e5bdfbfb 100644
--- a/arch/arm64/boot/dts/qcom/milos.dtsi
+++ b/arch/arm64/boot/dts/qcom/milos.dtsi
@@ -2940,6 +2940,55 @@ cpufreq_hw: cpufreq@17d91000 {
 			#clock-cells = <1>;
 		};
 
+		pmu@24091000 {
+			compatible = "qcom,milos-cpu-bwmon", "qcom,sc7280-llcc-bwmon";
+			reg = <0x0 0x24091000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+
+			operating-points-v2 = <&llcc_bwmon_opp_table>;
+
+			llcc_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <2086000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <2929000>;
+				};
+
+				opp-2 {
+					/* TODO: ddr4 = 3879000 */
+					opp-peak-kBps = <5931000>;
+				};
+
+				opp-3 {
+					/* TODO: ddr4 = 5163000 */
+					opp-peak-kBps = <6515000>;
+				};
+
+				opp-4 {
+					/* TODO: ddr4 = 5931000 */
+					opp-peak-kBps = <7980000>;
+				};
+
+				opp-5 {
+					/* TODO: ddr4 = 6515000 */
+					opp-peak-kBps = <10437000>;
+				};
+
+				opp-6 {
+					/* TODO: ddr4 = 7980000 */
+					opp-peak-kBps = <12191000>;
+				};
+			};
+		};
+
 		gem_noc: interconnect@24100000 {
 			compatible = "qcom,milos-gem-noc";
 			reg = <0x0 0x24100000 0x0 0xff080>;

-- 
2.55.0

