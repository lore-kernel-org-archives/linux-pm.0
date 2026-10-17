Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D13A3C198A
	for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255385; cv=none; b=sji6uSOKgDJNvY83pRRQru9g+ALSye7pGuoW8dvvy6ITTziCjaA7v1qSck6Vua4BrNcH5EYywfjZsMLBeu8u4fG63cU4iHRMI+ISu5Gbfl+cVB1GgabUxK4cTqfmN2N1x1vLHyzD9aCKZmVsPaxg0tExNiZmEes/hicm1hw1M8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255385; c=relaxed/simple;
	bh=V1PrfALe+dXwVq1n5n/hITI7hGqfkZud86/hme5sr+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NauPwegHsigiYNv1X59gYiXu9z83eFIM+++T8I53Zoxkdx/8DjS7mHopaX0zzdhHPX6he6DGb5t0lAI29nXCJbyu3YOllGlMKdflFjevQ7uWl+Dk0Vp1AzoWZfSDBH0emfj3ZBfVAD4xKh0+EU+NEE5PXQqocGWEBcI1dpiv5AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z684EGJz; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z684EGJz"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab98332238so666954a91.3
        for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 09:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255383; x=1792860183; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JyrovHosLdX2LQj1aC6ideMoPUaKKiI6CstREEz9Rbg=;
        b=Z684EGJzahvWTW/dApznEGhNzcZDNeGIMusam1DcH5X2irUvFOTfj07KS3NThy8NU8
         LfSIlw3tFdq4UjNCeWX5F72/LvzMk9XtazIwLlj1oWcZY7OH7fbcttABt4wjPr1idZUJ
         +lfUVDUW/d9u5iogF3S3RIbS8MeKAZPk/hwtWaENxM4CgqSBm4Zgh5W7tA5VyBwd7hoO
         1v9UnMGrY7QesfH4Xc/koXsmrT3r91RKZUIbS88qMekBHHmMczd8+RtQwC27G6G53zj8
         z8XPMyLWbxr/Z3uqkAHrCgy8pCezp2iklrRpdyUmqQ0c3T/WZSfNqtAti7NTTQuyVoff
         8/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255383; x=1792860183;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JyrovHosLdX2LQj1aC6ideMoPUaKKiI6CstREEz9Rbg=;
        b=WFHfFKfpRWbX38OOYsFvduiFzJdc9/sBkbBKwcK+miWxOpSaNyVJVR4dvXx3jDmsWW
         myfD4WPPSjuSWfwY3f5l4OCjZjQvGxA/J9eLpr9ig7/z5pM2Y9US6wV2z8Ut8ybJeksi
         VNzfAhg6GH0NcnYLP2fI9/qP9saJ2Yi3a2QFQsG1RLld1s+kAT1bA/W1fy7t1B8XM3b1
         GGazDXYmqyvf+sgX5X18Z+gHDFDQilKz+geCGmlATa1sLJ/FW/W1H+9SNk5/TE8EGWkC
         FC2gvlZPGtMWjJcOdJNn9E+761kwcr+lcUJw7VNfypA1gPcVTme7d2Y2DY2dgvSe+yMv
         +kWw==
X-Forwarded-Encrypted: i=1; AKwUvBxqnvF4D+Ne4rDpqNiUiFk4sWqDWb8xiwB5NRrSymG7/jfxUWEQgXI9oqCOrLD4168U2XrbzTM/eg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLLg0Cq8SRUJehclHv5j7RMiG+hbtCGyBRU3//bBQXdTkh5NQpa
	BGCSw5oLnHPPOGAD9eRby9stULI8ZDW0BK7+Ps4KZFdAP+VOUXUJB76C
X-Gm-Gg: AYBFou2AtU0sGfcxIb+ckZcd1a99dz1f2fy1YjpHFyvutWGu8yxkJ1UAJls2wlwRKQE
	+CdiK/gZ1bcxWBdwGy34kf7WJ0wLnXJCner1wq09TNnAj7nZzrU45QEidL4JVM1LOGOtFM9ejWY
	zKaRkviqsBWbhVH0C2msCBEd0tzoPN+ujTZz71ssnRoBgnJOkj5eAFBWbl47mjosVzVvRe9AA5r
	s80lADgSN7Un6bK6HCCiQcaJ6CH+nRw6WeZAE+EYDM31MJlYmvBud4rVNkRmbvbpxHL/Cx0mgPZ
	BBTi1fwAnKQdCO2IKmrF4i9DWZ3n2d4DEYZ575yNiIzrY6ErZlp6I4IMfzkO00O1oxAF5Ntkc/o
	Dt8KHB0rM4pE4cQwUFQZGaMoCwZjAIuz5Snic8U3JNFDbTihCdY3P29nCtCPB/9o71o6SR007G7
	jnm8sK/2a/jedIHpOShPKm4EP+XKkprIBNG6NvyMWhapNbqubAlPaF0QKGCPiq9A==
X-Received: by 2002:a17:90b:582d:b0:3ac:8897:7b98 with SMTP id 98e67ed59e1d1-3acef1455edmr2772023a91.32.1792255383602;
        Sat, 17 Oct 2026 09:43:03 -0700 (PDT)
Received: from [127.0.0.2] ([2404:c0:7618:4e1c:2cb7:b2e6:ffb7:d23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94798212sm13816164a91.14.2026.10.17.09.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:43:02 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Sat, 17 Oct 2026 23:41:26 +0700
Subject: [PATCH 4/4] arm64: dts: qcom: msm8917: Use a shallower cluster
 state to fix unresponsive idle
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-psci-fix-v1-4-dedae27e4a31@gmail.com>
References: <20261017-psci-fix-v1-0-dedae27e4a31@gmail.com>
In-Reply-To: <20261017-psci-fix-v1-0-dedae27e4a31@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Christian Loehle <christian.loehle@arm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
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

