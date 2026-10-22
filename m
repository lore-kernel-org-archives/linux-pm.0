Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662119;
	b=iv1kXOJqijshqyZL5PBtWtnlqEjUnC3JGdBH8K2TVVzhv56wdymYnbRls7Lq3HxgKwG5
	 TfBUh3zvB+yxOpTLObIASstF3pmUaL/Izr/lhimatb+xu1NQioocLhqsyDqDMEg+MjuBA
	 Qz1Aoa0CONauS6Hmmn6SWs1s2M5otxxv2ZBDkJ3bv7oKnpcheEIVtd4N0T67tbQNEPvSB
	 bA9yOQClzBl61Lb2EWKQ0vfiJ5eiKwDaFgGO392i3GW6cJzYYv0KdcdmREGTW5nPl0oWK
	 MFJcLSpBfxVhybZ71A9yni306gA7NHqCgN6As7JcrsnGN3GKQa7WTzJgNgpWqIYhOzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=3coeDBrZk8u/krbuiegVJJLUnKMcE1BvLH+6X7PiidU=;
	b=NZhBbEqJmBRK0Is1tjgBp5X+JSXvXvmc81IEZ2wKeSZqTriXxgXyfspS1dEPQy9fEQYt
	 57AJZWXHj9SDwNb3308ZlLVCuzBTSGUkqs/XOUyqAokIsrCFViSdLM76SZpAdkjpWjiE6
	 ouEd1PvBRcsjVFSGpyxDR/SXesHNk/+sjjBzG3yxc0FnQ7z+24DBXdjR0PUWuBJTojtEL
	 QNt3W5y3nEVN1dkQXEQxwdaKK8Hb1pn+33of4c5MpSkcxMG5GNETTDWEji77Hk/L3Thv4
	 khht7v1yiUqP5DMzW+sKykTu5YV+o6OPzwjSeK571Ie9G3ngEww/V0uh7PAZ+56CFUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LIJPXttu;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807A860A2616
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 09:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 807A860A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LIJPXttu
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e977109392so10076925ad.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 02:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792662118; x=1793266918; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3coeDBrZk8u/krbuiegVJJLUnKMcE1BvLH+6X7PiidU=;
        b=LIJPXttuRUF3aI6VA/GbBvwU/mjQ6tXV3YypQwF+4GRv43301OmIvWAXHrJhFZjeFq
         Vad00cxPu09jBuojeK00Yd8iprJpKIyvwgZLjHrGgqDIxdWFs0Hence8H7TTlUpSX5Oe
         4gWrGNreVcrl56t6kWRkHrgPI3wjH2evjhvDPGfucj48lHepJS39H816/MwkrhPipp8T
         nvAk9NYjyy6CsTD+c0dj0OFIPTRLOXOHmnnmZVPbaSynfhi66ky8kk0inu6PH3mYspIC
         hTF08O9LNCE5EZYsbSPEWGqOVdKGOo+LxlQPaPMBhw4rZ9eqZHIIn2hjmDTZe6Svs0tl
         /1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792662118; x=1793266918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3coeDBrZk8u/krbuiegVJJLUnKMcE1BvLH+6X7PiidU=;
        b=pa35nAtsSp50SaACCjrEDhfC7PTSqC4njyH51+nnBQJWSc4N3dMV9AJK42TWd8+oU2
         WPhDQfwVrhNwWK71jMzd4H7g7t+ojgorIUN+gl1HULXP5E7fqmmeTkGt09R6NxvP+7rz
         GzEzED2SBly9KB/Y8U4vTXMBIDpKPoBF+WOv8ecBSUfYoliwhC9LILfT9gHUtVZ/9oLN
         S4hi3NOCTd4jGv/+1Ptfs1cvK/8peJEtUAL/eB4XsDDugfhW7haLEQZY0QaVEpnijl9N
         Y6bcsPvAcvQ9ddC1cbphlHRIrqya8TTrKExivgLx0Iky+jl9peQEvBw/jqQreisZQAUT
         sX6Q==
X-Forwarded-Encrypted: i=1; AKwUvBz9IHSYHdmFED2W/rVF8uC3Pwa5fvQVq6qAzzXyxauQlgffgimDZ+Rr++sEZ8KNNJqZm1M8Aj9thw==@vger.kernel.org
X-Gm-Message-State: AFq9FYL/w6GKGTvfxbLDVvvJIa+RW2O0hUJtZvxdcKnxEMTMxighLMSt
	9I/mn87xm61Gqirh6kVkrNFEiNKRw5G2C1RPubhRVvgpx9qgJAE4ZpAN
X-Gm-Gg: AYBFou0sSlMUdzbDXFCgYH7DwItcCcOsUmDAdV2m3gZqIvWYEVV64Z3egzF0AggoSGZ
	UpaHBCc1EhledPDEn8YMPvpbI0sQoDf7oWAMwluKF9VdxNIklsVJi9av0fSaGYNpa+Lsg4T8cAO
	6ZiqMWAKaGkSU7syDvxlJlSJXU+AMM3tbdkdOMS078DkheasaCNn2KCDBS+DSfLB2s9LM+b9mjF
	6qjdHCgwmF92RIU/TeosQim4RDbnIgcwnV1MDcPjIWV3O4AfDnnG5OwqwL2uwIX9bFFVssgRaz9
	TCWxZP+jIzgThO8FweqakcN0yn/06Ee/5D0NXMzGFpsdw2ucC/IQDcsiEqCv84jzw+UT9j4c5y9
	tVI8KNZzNzJjSoJKsG7bbiMX0Ux7S6NH5lSQp2K56izHUphMtsRmmuiMxSyZ7/bFKyztZ6AFdXi
	iMrnhxAtnk5fuhe3FmV67hfh/pC6hko0GZB1GtTwR6mfcVkHoPR0CuMLXrYNQ1clt+zdIRxxZwg
	3eJH1IEicsRLmeDIkJbGJisb5C8bHFQx0TIfLDc9/FGv6YT
X-Received: by 2002:a17:902:f683:b0:2e9:5c55:c46a with SMTP id d9443c01a7336-2ea4396c346mr37258705ad.7.1792662117740;
        Thu, 22 Oct 2026 02:41:57 -0700 (PDT)
Received: from [127.0.0.2] ([2404:c0:701f:d27a:ab05:82e0:7670:1951])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4356c1sm21483075ad.38.2026.10.22.02.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:41:57 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Thu, 22 Oct 2026 09:41:12 +0000
Subject: [PATCH v3 3/4] arm64: dts: qcom: msm8917: Use a shallower cluster
 state to fix unresponsive idle
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
Message-Id: <20261022-psci-fix-v3-3-9ce2133c5659@gmail.com>
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
 linux-arm-msm@vger.kernel.org, Reza Kurniawan <imkyufie@gmail.com>
X-Mailer: b4 0.15.2

MSM8917 is a single cluster SoC, so powering down the cluster means
powering down the whole system. This causes two problems:

1. The system becomes unresponsive, even to common interrupts. Waking it
   requires an interrupt from the MPM (MSM Power Manager) or scheduling
   the MPM to wake the system later. Linux currently has no way of doing
   the latter, so the cluster may never resume operation.

2. Entering power collapse blanks the screen. When the state is entered
   and exited repeatedly, this shows up as visible flicker.

Even if MPM scheduling were implemented, the second problem would remain
and it wouldn't fix the system being unresponsive at idle.

Replace the idle state with PSCI mode 4 (dubbed GDHS downstream), which
is less aggressive and can wake up from conventional interrupt sources.

Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8917.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8917.dtsi b/arch/arm64/boot/dts/qcom/msm8917.dtsi
index a2907f8a63..06f7e7f57c 100644
--- a/arch/arm64/boot/dts/qcom/msm8917.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8917.dtsi
@@ -112,10 +112,10 @@ core3 {
 		domain-idle-states {
 			cluster_sleep_0: cluster-sleep-0 {
 				compatible = "domain-idle-state";
-				arm,psci-suspend-param = <0x41000053>;
-				entry-latency-us = <700>;
-				exit-latency-us = <1000>;
-				min-residency-us = <6500>;
+				arm,psci-suspend-param = <0x41000043>;
+				entry-latency-us = <240>;
+				exit-latency-us = <280>;
+				min-residency-us = <806>;
 			};
 		};
 

-- 
2.56.0

