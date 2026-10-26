Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036922;
	b=Cyqt8nmbRA64uw2IMM8OYv2vhpjjL2jGHZ4VSrPEmIXewtfFEWv2riUgRdSBOpD2VdJW
	 C+ItX45eBTqYS4DxLf55wb8jeDllIXdfjRvcj9R6VAPNTWfDrhd5Rqjf2rdI+U4QDGWQG
	 AHK6mUkxdbUP5Uzwbo8F+X1ptSSZWA2kDGxuV0QANh4WcjZUGoK+7hlluAfdJgTkTeuxk
	 OuZUyAD8rCV1FjrEDk4tpHnxbXjN5wcCc3sOJLk3FkF6VlQHbiVcacWnVohRxCjBGHhI+
	 nhxcYCfA8cEW8IKPggEYxPO3MBblcFE204mFbR68Ht8OqQ6WExIaOsvmVCAOx3+805w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6xOB+Y9B7pCNByydgjtkPnm7V5ov68gr0sv6XngJ0mM=;
	b=zpYvdakx2Zxv2x7ro4oEKKrI17RZwrCuwyYcyGqpB86RDa/+K7mKE58iSQg7xirAg1w4
	 hhpGKguerMlawovx37GXi9ukk6FmrOXPG4X/TwFaXRg2gBYDwBQi9c3Xx2NutqghlA7y8
	 VRDRl6JHiTTg/TCismvhlPdZ5R/DJUHKuVd9IcrrSSEpHYjr5dN+3k1JGpO1a4ectxruK
	 pEOmSO+51YyWm2tLk3E717+4ZmkXW8NNulMnnwIBBrZsp8j6qMnmdGJ5lREZ7/Ouo3zyJ
	 JysLZQZTpXUhCGO0ssguPa4zfib/atglUF2W/rFYBM5PQ9W8S4N13eTsSQ3Ti7HLKYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KeMkk5Vf;
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F50606A334
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 17:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60F50606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KeMkk5Vf
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4932b13c4ccso1683001fac.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793036921; x=1793641721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6xOB+Y9B7pCNByydgjtkPnm7V5ov68gr0sv6XngJ0mM=;
        b=KeMkk5VfkeUE2XnhDcqQ35p+TskFtFpqyrseQUN/k3tLkmKzuvHQnqClgbWUWWpfyr
         tkscSRucixmY/wl2qW3CIu6uooI1G6t+oceZUj9j+T9Zxnr8CwJ3g7c6mtJi8l2F1Xud
         8i12oM1UkCHcqT4c45oAlXFMURYKFcoetMDNB3rB+H0N2Az2PdcCz1MlcVI9RoHXyohb
         aFpfU5oYRqmfQAvpfLmNv/3c/Jihyq7zpyGqBbT1eZ1Uaok+VEct3wJeQedut8YSI/oS
         2q8my30L1UbnHvQGth8mgWyUIFfo9AJJm+McrVtzKQ3ni/HDbS0aREZie7+IKWUrnRcZ
         vpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793036921; x=1793641721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6xOB+Y9B7pCNByydgjtkPnm7V5ov68gr0sv6XngJ0mM=;
        b=ikiue73E5gdC9ZN+jG9XAsNOuDJvQhkVrzRJz1qTl+RBDiebL0b/R15UA4loJOlabO
         9jXRcUl92RffwemnLKvtoHbLhs2qQcpQFuFotf3RDMi6fYmMyKVllvrsb55zYkIP/aR7
         sRFThf8Y5P/xjNUcfRr1wQRqI5nhidPzb00AhfqUr5zBX59kZNE/JpG79sLqqt4KCaQG
         FX5OLj/7KSvUouDrjoUOEYoiHbiYxxnKbpfUzV58isl0S6cg2QvzGMTdDoGcOzC1kZn0
         0N6EiwwTukh8CB12p5emT22itGMnxBI8WfZUj9SdyEOdBqOC2tGMeroGS+TFevuB3UTg
         nH/g==
X-Gm-Message-State: AFq9FYInGkWbnV0SjPLTwHlRI+iw0xCqCqqpa7O792wvNv42e5fzXtcK
	X2414jJv632fIR4jLVYfpY1ws5gcjx2Gp1MT9NgSNlUfWwM5ss78Q+3dza1+k9AR
X-Gm-Gg: AYBFou3tAAIe/kPhuw1x+YDBjybC/WGPkbJxptKcnFer0piGD9x+raMetxJ3Q2bwKxU
	PMvVdqZCTl51YXvbNh7k/3hWlLHpHLlSpU7MBxbgx/mwFmgfjoj9lzGXC1gPIDF3h5o/5SX1+qY
	5SOtN9y9S6UEEuOR90A7CDGqznnY9VchAwTFnp9WYP4WH0oBlQnA7BbEqnxDQUJbbBdCDg1k23J
	PFMBUpIaI/tsa8V0evex+65jGKxn/ohoqurnlLHtV8mhIGR/HCQRU56tEWPYGQWxF+2KZRgaYmI
	QHIZNAL0Mfnfo/LlIJ/4SU3PQU0Bzh46yQBXQhAoCB7EgqRAVy5iBga1M35AnwuHNVwpP/2nuSD
	kSwO/SPvd4FBBbaIpcpuT9MroRjKcTwyWrc/MqEaGnrc2uc0BNkchy+LxZCREkGD0mUny186u0n
	i7y+LYmwnTfscGNBBdl0WHFl1z8BVaPHA83nbX2/VAwgE5Lqn6yTH1RmZOpwBe5H3NZzdx4vpyR
	7FS5SWxg+CcHqoe/lToo78lEuhMbjDlWBDpkR/6fG0dOPnYa52P+ZPd1rbhgmMSIZC8ny5QLPt8
	awdPM1OdomcNrSinWdi8Phd/dVg0KY6cr3/mfyVFdTrV3FRpOLY=
X-Received: by 2002:a05:6870:2183:b0:48f:e25f:1dcd with SMTP id 586e51a60fabf-4a83f686b7dmr4595707fac.61.1793036921182;
        Mon, 26 Oct 2026 10:48:41 -0700 (PDT)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a842e89e33sm5034753fac.1.2026.10.26.10.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 10:48:40 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	maccraft123mc@gmail.com,
	zhangqing@rock-chips.com,
	zyw@rock-chips.com,
	sre@kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lee@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>,
	Zetarancio <zetarancio@users.noreply.github.com>
Subject: [PATCH 4/5] dt-bindings: power: supply: rk817-charger: Add rockchip,gate-function-disable
Date: Mon, 26 Oct 2026 12:48:33 -0500
Message-ID: <20261026174834.1652309-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026174834.1652309-1-macroalpha82@gmail.com>
References: <20261026174834.1652309-1-macroalpha82@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add a boolean attribute for the rk817-charger to control whether or not
the system power is shutdown in battery off mode. The BSP kernel sets
this value unless a device-tree attribute is present, and this attribute
is to replicate that behavior.

Fixes: a592aa3a2a8c ("dt-bindings: mfd: Add Rockchip rk817 battery charger support")
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Suggested-by: Zetarancio <zetarancio@users.noreply.github.com>
---
 Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
index 2cb6d176a84c..4cf987fe763b 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
@@ -148,6 +148,12 @@ properties:
           Value in microamps of the sleep filter current for the charger.
           Value is used by the driver to derive the sleep sample current.
 
+      rockchip,gate-function-disable:
+        type: boolean
+        description:
+          Boolean value to prevent PMIC from turning off system voltage when
+          battery voltage is shut down.
+
     required:
       - monitored-battery
       - rockchip,resistor-sense-micro-ohms
@@ -381,6 +387,7 @@ examples:
 
             rk817_charger: charger {
                 monitored-battery = <&battery>;
+                rockchip,gate-function-disable;
                 rockchip,resistor-sense-micro-ohms = <10000>;
                 rockchip,sleep-enter-current-microamp = <300000>;
                 rockchip,sleep-filter-current-microamp = <100000>;
-- 
2.53.0

