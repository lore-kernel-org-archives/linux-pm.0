Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184436;
	b=iAmPR+WB59mLKR1jhVHyP2nt6W2p5bORw+KCGsS1jQox2v4fRoOPSMqjhe/DHNJoOvCX
	 Moi3MxFhu7grU4cFu8RN6CfXVcAZ/B1fVF2qIlJPSccr+FcqyxYTCvSdqy36UbcC0txIQ
	 E+rBhThrKJOG2afNOSAb6w4xSgPU7EBT8roZvjViBDiMrW+mcehvDI/7rFG327Q+E0fe5
	 B64d9+Lz+BwLIouRkQjLy+CLS6Db1nIboVegIBtQCOIfiGiTlOALeVIi3j7KEuT1zkeub
	 JSNkOxyIuRzhA1Zc3ZEtiI8spj8qeheThuG+a4BNhNsCKsLKT0x2jBF9XzymvRId1sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=b3VvGqgW7w89m51V5OtlQCJq1vHDswwHimQMB9pEHTM=;
	b=t0PdXVaWr83GOjYN3gS+zd5t8qQcRlqN2CTp7mzm4ipdicAUk3MzhwZUn5F6OKwmLBV7
	 ceKjZO4O8WSoUZr/Tm9fENQ4p7dRRTW3CpLRmmKdQ+r53ov/LcsDaq4xGWM2XPQe76izR
	 Zg6QMyI4JFYP3giLU+vDNqeKKxQh9KdGhp5bKy3doQwor/eSqIF4TuLTcixf8BChNGVAQ
	 mdzqsrTUXh/bCag5Of7iJOAFzk1rVk1ds8PZpGZxvl3zq02+rrYYS2m8UsZJ7xExnkPfo
	 uBvx3Uj11cnmSWJIvDufzAsqFgxcI2JEMnXgRWtgiE/lkx34OXbgHJm1xCm2UFhVysQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EjJzEiWq;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C80606D809
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 00:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7C80606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EjJzEiWq
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-490a0e72588so164367f8f.3
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 16:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184434; x=1794789234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b3VvGqgW7w89m51V5OtlQCJq1vHDswwHimQMB9pEHTM=;
        b=EjJzEiWqX7bP8p2RpKx0A8Mw4VIgcyhMxrNGNGYks9jT5K7ErZactzYCM9t6cwd4kq
         HaawBIqhzJIoLY4VKt7M7axDUH3ltzAQECL2DA4uwdXfdrRmzhjFbqCwUEKRsgMmA3OT
         yUx4/q4gfrM7qxWKUVkUiMy+1fv7O8bhhnA2B0BUCSLouXNRGcMKyshx7XYeRBPj5cMQ
         wqd9SPL1tAWpz/KhUuAGxUxS4NdfwwA1C8dkrWO405Sx1TUg/iTb9/AsEtLF0Uiqhn/2
         2FoNSTstnuusd6jY9eQoW6qa0bQaccSOIzfX/PXknfF9DEqb996bbOcC6TQtKxYLJM+a
         m8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184434; x=1794789234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b3VvGqgW7w89m51V5OtlQCJq1vHDswwHimQMB9pEHTM=;
        b=f7XDbC9Vc1MxrBHeav5jd+ImzFR6nn8yq/7fFUQY0u/kqH/Ty37ubfNI81Tf/bJXQo
         rrmSRXn45xFu7fNhgwloN8HsS2d52hkJZwMcKC3fcfQ9grDfO0aK2UDb3Xr+vJ9m2cFp
         LSfDkPRPQ6LtuRU7KL05F7fmqKNyvaoSdO6NeEVSCU4OpTWHvOtLBPhsmOms6G0Mv2qd
         ATGGkOMasrHhYac/kWFJi6NCKSCw4o3SDdXvh16HonQgLi6t5FZuDnSI40cZ0SptrM+9
         V6gSMui6gR0W1TTK3Wd15AiwVLyjQt0lpJW6Xfuq8NJWtgEt79GtTu1NWN4gqdSWbjZC
         9gUg==
X-Forwarded-Encrypted: i=1; AL+hErHeNcwJKdKQwgOYgQ7HKBdZQy5YoFZ7tRoKeVerVucafHVkz8ugMF73Ja+ML8pNf0rryadF3THIAA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/lZYMmKcufJe4RuidXvfjxNMO+6VSK500Iy/8AcxZiMAhNS6KN
	893DMyJDayKY7bK9ZujYbGxFunY6vPVKwBxGAxvsvfl0BBrNnzHhF5FL
X-Gm-Gg: AYBFou1Sw0pX4ZzpxgahzQ+7ID/WrL13cdUfMQWhqmF4CMq2MHhwmF9n8xmZ57tSs8d
	+nxVWLQsRS4iHTdY5udv40Jc089xlFxkm+eF3QlsJ0XNqL2JF2kIZyjB1dUciOismES/VfD8LYt
	Vw2VIidZdOa3DAtexzbgClNQXqxUbi6Qzn36WnwQbZOsQrCzjqffbNshTxj0q7m97VotO4CDgJE
	xqOS9YVnMSXPSWzyMOHIH/RWZu51WJpqUP0sK0rXt9xIM4egPDHP8RO3yXnNPgvcOC5hpSoD2Hy
	HPizLA0+EMbo39pfaRpX1kbvYGcrYNfjvPxSvNo5hqGD+l3wtKiXXzbhsYvT7NUl9mAVAdmVsLl
	jIK7WH5k+FQ9c9tGJVmEA1aSP0taIpP9xpzRaSTrW/oxT8nesDwbNO0QDQWe8dJs/koydOh3wBZ
	dFn7Tt91PPxIERv5chp+ZcHQyJntZrnWu4SBeG+G5afZaOvPnEFWCk+9JmJ18jANQfUIHzYa8Gl
	+pDjC+3ISMacJ09TXg3bOIcRlMlVQVGWiku2St+0d7L6i85pECYRt3y4Sdsd0Xt7XAU1vIgTJyM
	Y4Wvq612A5hDXcdDKaqxjF3ioC1DJn0o7THZUphnqA==
X-Received: by 2002:a05:6000:186c:b0:493:2eb8:e7fb with SMTP id ffacd0b85a97d-495856e15f7mr5379354f8f.41.1794184434351;
        Sun, 08 Nov 2026 16:33:54 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:33:53 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:18 +0000
Subject: [PATCH 06/17] dt-bindings: arm-smmu: Add Halliday SMMU
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
Message-Id: <20261109-halliday-dts-v1-6-289114ab8197@gmail.com>
References: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com>
In-Reply-To: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Lee Jones <lee@kernel.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wesley Cheng <wesley.cheng@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
 Bean Huo <beanhuo@micron.com>, Stanley Jhu <stanleyjhu@google.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Georgi Djakov <djakov@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=1112;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=ePrzoruUVeLDRq3OCS+DiCl1d/Uk3kZuK6w1BATsFKY=;
 b=pH81WehGSEFzi7T7LS+ShwXYAfu5lsev7imaA1JaeNifItRSFvMkK3a/y3Fr2K8IwuXgQfeAv
 1F1xnpR5tNxDdiiDmSxt0TVIqWh9HxtwfbMTz8uhxpsozlK3LlCAs7D
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the SMMU-500 on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 6748351c7812..925afa8cca8d 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -37,6 +37,7 @@ properties:
           - enum:
               - qcom,eliza-smmu-500
               - qcom,glymur-smmu-500
+              - qcom,halliday-smmu-500
               - qcom,hawi-smmu-500
               - qcom,ipq9650-smmu-500
               - qcom,kaanapali-smmu-500
@@ -629,6 +630,7 @@ allOf:
             - enum:
                 - qcom,eliza-smmu-500
                 - qcom,glymur-smmu-500
+                - qcom,halliday-smmu-500
                 - qcom,hawi-smmu-500
                 - qcom,ipq9650-smmu-500
                 - qcom,kaanapali-smmu-500

-- 
2.55.0

