Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF56642AFBF
	for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 04:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792297843; cv=none; b=r8schsTI8rBiO4YOustWsNqBn4LZ8vkwhgdX66MsgDhWKney9QeaxpBRSE1ajokjmgkX4uTMvhNWnYZS4ReL2OaRAir6/08a0Mv7KB+8WFXRkpanThSLQSfEfcVVrrkl7ZJplP/VEo9jXqN2JKvYM0FXJtOAGxH0kI6doWYSv/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792297843; c=relaxed/simple;
	bh=V1PrfALe+dXwVq1n5n/hITI7hGqfkZud86/hme5sr+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o1CfKTghIctc8x4XoVQR+uO3FlfCEyuJB/Wh3gEbi1V/vJFdYYwSrVtFjb019L8SFx0voHeaux4H2tPeApVIEGPeELL/5U7NqWiMoHllhbstY861NFsvT50vZhJeRpZwL+bkuHp05dCfJz6tv8jM1TmzEPfN46DJZ+ok5+ENEs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiDHFkgK; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiDHFkgK"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-398b3c37877so675745a91.0
        for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 21:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792297839; x=1792902639; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JyrovHosLdX2LQj1aC6ideMoPUaKKiI6CstREEz9Rbg=;
        b=AiDHFkgKgTtqrGV/pACAL8QeR3YGPRzDSBXywJIF6f9wfJDwzDVmmEddWI7PaShnbd
         FJfNZegkH5+dPNJ0D8nk1v3ZdwFxch0q52MQT7/hYQzyhKQq8jtd82zlF4CXxVfXvKWx
         wn/g2h7k6n3MM0gnrZfZZdFggOZ11slw9R33iORWeRbQ0My5xTBsVB5ECIduL/NyMhdy
         1Q00tCIjUUfK0Ay+r5X2L0USJGGMG8XD3vngyUm5DXHkKDsKws6P0oH64zx+5+w06cMz
         DmRGB3zUPzZZUFx2DwV8xDpbIr9dTUFzO6V6bKQfAJb7I8814WTsxNtOT2k/98ojtfz7
         zWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792297839; x=1792902639;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JyrovHosLdX2LQj1aC6ideMoPUaKKiI6CstREEz9Rbg=;
        b=CQFEDpgwH18ZK2KfUMe0Mk3WydGDuYK0IyxiQGwxDpriONbCzPzoc+Koysx9FFJgZ3
         MLrrTl2nNjkMqqnqKqXGPPzkTwSiRDSyhxtNen78bzR5AyAXM3xi4s+SLYnUrIygZxil
         6GE+7A732eMek253LFNbMR46FHluWUZF9/zzWurx3c1UCqrCcPXTvi23flFv8XtZdbfC
         Fb4rxgHkmrvSC2vzZyjHkHc5qz4fEx0p8kl8gOfaQ0HMIZwDynsMVw3iUYzeloRm4CLK
         eIlmuNotogCot1gy1xZEz8LkVy/N3WOs66qNpCt9c5SegoSgVoNnHdbv8oJHFgLYxUTF
         iVHQ==
X-Forwarded-Encrypted: i=1; AKwUvByaJpSGcw9SZDE+AY2+u64tbJyXvJrEQNnU77W9SBvXwRHJgvQF5WQATG0xHbCL2qj4JY4YoFySNQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJtct4mpA9tx7CAlmHemvvxNs1gEzUDO0Knkpe+BjmIODK1b5/a
	AU5zD2GLkgb2Gf/yQFfOqnMJV6GuB2D31Adadp1PfsavQeYjN4RUa4rY
X-Gm-Gg: AYBFou3bICRP9iQaXrj4p4epBaN9sPVKIkLDBfDhC/BLMglC38Lu9iIGMRJEFCZaQv/
	8o2XJp8uH5ZRdh5YbelPfI2bWN7JJOc2J9YjN8UKR2n6CUejWamxmLDQArGkQ10VGjLm95nntgh
	XSOuNB/1xh9KntWbxqGjFFQP/CiANi+uj1n3SFUFSK5kKQ1oWQthyKtquR3mZJylVMu4wHZlk6k
	N+aQjqZ6qcic+h8te1X1xSDDXuZ+B3FrF9MI4+K966j9oL6n7VmtVNNAfE/E9xgRrAylrocDl/x
	TTfN7pQ21xBPMnexsi1q3ZwqUs2FzoXdaRddcieShgUtGDQvW0nJEUGwAQiyC/pXg9iuhKllVyk
	sHlt6c0v9eMg6AinqK+crYk1JemfXgeZgklzoMNc1oJ5Z3y8/GfkdQ+RTtSIplV3wjOJg2KGvr0
	PDzhSik5tj7Ve2FX8lqhw1mHRswCocNq1r9Ok2kBw2AhojwDcTolPICbkAFg+N3Tw=
X-Received: by 2002:a17:90b:380b:b0:39e:59a0:46b5 with SMTP id 98e67ed59e1d1-3acef14451fmr3843389a91.24.1792297839161;
        Sat, 17 Oct 2026 21:30:39 -0700 (PDT)
Received: from [127.0.0.2] ([2404:c0:7618:4e1c:8841:a092:12c2:47d7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc9e47588sm5885369a91.1.2026.10.17.21.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 21:30:38 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Sun, 18 Oct 2026 04:29:24 +0000
Subject: [PATCH v2 4/4] arm64: dts: qcom: msm8917: Use a shallower cluster
 state to fix unresponsive idle
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-psci-fix-v2-4-35f65b59eb9a@gmail.com>
References: <20261018-psci-fix-v2-0-35f65b59eb9a@gmail.com>
In-Reply-To: <20261018-psci-fix-v2-0-35f65b59eb9a@gmail.com>
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
index f0771187d0..7730977e6e 100644
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
2.55.0

