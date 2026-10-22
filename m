Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662126;
	b=kxFnH3JOehtQpgmo/PjUfQeNQKWXcGtTbo9icTayUnFvsovL/AsHPOnPNkoo2N6dsrhD
	 ISze98h7jUdHgeV6XxwZmA6phKpTBgEV7oITZbq9MtZEnVxvW3XsWfK7TZB82YQIt5x4J
	 s41qwnEL47pW41Nu4ucW8+DYR/9VNWZ7cnBvzNpCcpnUM76ULl8FmvY5yt9iLpXr/T4/o
	 HsFElGJsuqSf4uqJJ1YkPn8eY/MU7Fu/cviyyNDZEeRjnm0pnHhCciEIyLIjE4Zn6/wZt
	 3sk2xCC6CWIKoKa4sQHnxIB22lMbZ+LIWIaJbWjxvkf5+6awIKO6eOp+u+oMvo5ls9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=2nt4hBSHpClOgv3HgtYgoEhMhOYNcFrEBCSUvXNxseY=;
	b=nhhmaDrUCCLxILSOYs2xYVoG5iYmw5WGDjWn2ZmnOBMWzOKyh0uaF5Zi3G9z3nwxSIew
	 CL6L2+92K43TCaGxfangY8q7seFT2aCT2PXfc5BGFytIkZIFlaeDKBMD0O6Tjiqq6bYfV
	 enRKhGT5Kwf7C2PylKuyxbTolXz/OqqMKiQ9dcCU2bnk8+D8a589PA8jUetVhBFuNNmsN
	 F285RhOLX5gSrfCAYewbGaijZN5k7ow8InfQJ+5BURIdJjGxG/okrYGIlKa66IhRgVncE
	 8aHXkvSpNETOMVdnxBglkhiHU7pd56BnEc0K24Q2mgTacLfuWz8jqI5pznl4qXzD/kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jXN5FGnH;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6F560A2603
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 09:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A6F560A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jXN5FGnH
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e9d7791b00so7407135ad.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 02:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792662125; x=1793266925; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2nt4hBSHpClOgv3HgtYgoEhMhOYNcFrEBCSUvXNxseY=;
        b=jXN5FGnHRwP+5OJ7cTrRlZff4KAtHfziQlUnTWwd2J3/DzoQH338aRE6AVC3TtWQWS
         4sfhzUWpvN1/untLl6zPcQtwXvrsxdWrdvTw6mYDfYze6ooDK/U5SZ1xP2IRydnaKq8/
         rvrRb5SpwO3oRrLu7b1TWN9h9qbwpLk/5P216h0QTRr5ck0lTWB0SsNUdp8FHX6AGy/1
         Q+WJAEfhDkpylmSvx58DfEd05xu0nrLLEIFpJu2JKt2RVo5zQv5fxLR//YUlgHSJbLxR
         X6YhLYWNCxb/Pf19khjJrMBq01joJ8baqg6WiDNGbtA70nJMj4mKVSFFpjb0j4amgUyd
         n+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792662125; x=1793266925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2nt4hBSHpClOgv3HgtYgoEhMhOYNcFrEBCSUvXNxseY=;
        b=TTRUS2FLdIeovX0nMKeTaMQYygl+arqzdReX0q+to90NqD1cmRIdiv7OWbd3mbX/Hm
         ozu2GImatH4GXc9+VwsVY2HH6igYBJkoHolpKM1wmV+TEhm61w5eRzoiq8Dqvt0fFgDl
         WvTJWnuUSowknexxYLvwmVa/xYEUila8WfTGT7les9jvRRN7ge9HaYK6A/Vx8cYrYjmi
         5qFc4nTwzSgcTu7hucMtFt9YkppEE4wQyevxhgqcYb9ULRIlTrGTc2OvgfUiaEJUFrmQ
         EG/KCmFMiPWNO8dO+IQBdiq2PQvSePOEEVCCYxhXT4ci9rJ7TLOZODu2dG9bx8f/6efK
         MPEQ==
X-Forwarded-Encrypted: i=1; AKwUvByunfNLpZ3kPrRkl6Ja34Sk7Uvv44OEPoudLdNRoV1IwMtegxQbOf4P/AicSH9H3cyt3RLUEnWFkw==@vger.kernel.org
X-Gm-Message-State: AFq9FYL0KobywMKo9kvRyRLqSDycaYQiXv21EDEeKjeKoQJ31m6gbE04
	VJMyOQNcDoZ33L7rSvy7BLpj0dVTRhAg4//sDUufeFxYL1V7FVlaHz4f
X-Gm-Gg: AYBFou3N0u/vfivatauEU3t/tVmd6S+S9aU1QwiLaJmJ4ou6vmPBmD0aRT7TE5oaoqr
	Am6zMvVpy4FdpcEo893WI53ig1+24aB2HpyRg5DR7PKH3XfEZLlB0pYLCXOcdKaheiNGO4On8Ka
	9qeIvX63qYGSqMNfHFyFjkdTSuSM2jrpnHB+oD7ZV4ohZA2+A9G1EOEFJnXfKU843NinWBC9FSk
	GdAV3OvvdmDM8exW22KVGh90dz6SkrcsSx5LTOgs0we99pQdJL6EyhyPjGlQZ7xxaSvh41BNa/Y
	BehLciyUlV2n8C75vGaoV0hcfkAM0XwhaGe0QRK3UvSN33XbiVUpEFkDUmZTmZK2PM7aAjZULMH
	tG79TtFsgUn8YuVoLnYbpyCQY7fOYRIFQxUyc7V0RlfhDWHI9y2IT86yKHq8pmnojT6G0tgaSnn
	8tSO9I+tJoH30PezEMQuG+VRRgIybNNyCzaT0rmNkj2qI2H7foBMTEfFkCcHPoiJmnZPBxUo58c
	lm393UhrokSGfRqEwtqsWyFOx+UBmK6H/m3U7LIaT/vxWCL
X-Received: by 2002:a17:902:e892:b0:2df:b250:ad9a with SMTP id d9443c01a7336-2ea43cc2bdcmr36258875ad.48.1792662125463;
        Thu, 22 Oct 2026 02:42:05 -0700 (PDT)
Received: from [127.0.0.2] ([2404:c0:701f:d27a:ab05:82e0:7670:1951])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4356c1sm21483075ad.38.2026.10.22.02.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:42:05 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Thu, 22 Oct 2026 09:41:13 +0000
Subject: [PATCH v3 4/4] arm64: dts: qcom: Skip suspend mode switch on
 MSM8917 and MSM8937
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-psci-fix-v3-4-9ce2133c5659@gmail.com>
References: <20261022-psci-fix-v3-0-9ce2133c5659@gmail.com>
In-Reply-To: <20261022-psci-fix-v3-0-9ce2133c5659@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Christian Loehle <christian.loehle@arm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Val Packett <val@packett.cool>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Reza Kurniawan <imkyufie@gmail.com>
X-Mailer: b4 0.15.2

The PSCI firmware on Qualcomm MSM8917 and MSM8937 reports to support
OS-initiated suspend mode but rejects call to PSCI_SET_SUSPEND_MODE with
NOT_SUPPORTED. psci_set_osi_mode() then fails with -EOPNOTSUPP and
probe of psci-cpuidle-domain is aborted:

  psci-cpuidle-domain psci: probe with driver psci-cpuidle-domain failed
  with error -95

Skip the mode switch on these platforms and continue with the topology
that was already built.

This is expected to be safe since it matches the downstream kernel
behavior, which manages the cluster power level in addition to the CPU
power level, just like Linux does when OSI is supported.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8917.dtsi | 1 +
 arch/arm64/boot/dts/qcom/msm8937.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8917.dtsi b/arch/arm64/boot/dts/qcom/msm8917.dtsi
index 06f7e7f57c..7730977e6e 100644
--- a/arch/arm64/boot/dts/qcom/msm8917.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8917.dtsi
@@ -182,6 +182,7 @@ pmu {
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+		skip-suspend-mode-switch;
 
 		cluster_pd: power-domain-cluster {
 			#power-domain-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/msm8937.dtsi b/arch/arm64/boot/dts/qcom/msm8937.dtsi
index 7de6447de4..a66a544f30 100644
--- a/arch/arm64/boot/dts/qcom/msm8937.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8937.dtsi
@@ -311,6 +311,7 @@ pmu {
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+		skip-suspend-mode-switch;
 	};
 
 	rpm: remoteproc {

-- 
2.56.0

