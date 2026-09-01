Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E5742E43F
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 07:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788246550; cv=none; b=DdCdg7LXUgiyRjymelWRF8Q9l39vYa8jfOaQobQNTQBYQ2BiPJN9gX6r0FPhON2vaG+DOoAZQeX/4PUTaRtSzx2JFObUR6XDxK0XmUTPe86+c5vDs7Ws2KNhqK/t/rbt4PEjgGoJzP6flSjFZmA9Ilhqhlal92NjXh5NSHoQ0L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788246550; c=relaxed/simple;
	bh=gKbqr+JbhugVzrK4haKucfxH1GbAmaJ/63Ra+8PimmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oi5I8hTfGrZBdAKOMOIr/Lr2xtKH2jPNZz7M8YSjfeUpTHMiHGWD+QyBwgEXsLtPPrIXHkiSERjEfSnqzpNl9SD0V6EfGqywcZY17Rw0zZM7PQ8Yfaq+UE+bjxtjSMQnTi8OdTrmYK0nEQAfA2tLqYJaloq5zXe+re94g/JGXPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9nqMGA0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9nqMGA0"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d8f265cbe6so4930415ad.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 00:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788246544; x=1788851344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rRyq9W1nPrd5M7AXluKRAa4K58WRzpGWnzgIJ9MVQJI=;
        b=l9nqMGA0syd7cxZu5ifSTnER9+yTPLhD5t21Ie8FoJFLqEQrO+32e67LBLxdfFubKg
         aY8fdbQ+H6bgrEVlIr0Oghrl9hglNM5i6dF4a/74FS/+1ZRKosOYnuAA30l1kPDKBYS+
         V6OzPLAVhbxNiQ3dPjYXIy9ud94U3zlyamSHKP35MiSJUsksJYY3lWCBiSIcNFpJnsQ5
         fM8uizghJgHHCS/PvM+xTTXQzJ2ZUR0MAnBe9q7/GJSR60RDXAZDXWPW0e/t5yzoeIP4
         f9qJNv/ZOq6aGZxB8z0n4djO3iYnYcY7ZSnsEd6vB4ol6/4h+bQ9rmwu1uttUY5qP5ao
         E5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788246544; x=1788851344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rRyq9W1nPrd5M7AXluKRAa4K58WRzpGWnzgIJ9MVQJI=;
        b=swZ4/35q7h4tRD7QDcgm5J4b7QT2UcDLg899F0EMIj5DJbrGkzD2I7WncT1uw0A6tZ
         1vLCacNGtU630igZCq7Fq+ZNK8kiC/3Gw0uTdpRplz38zoFSOh+4kpeO7t3tq+rKFM5W
         0qIQfW7jU8dEL6Pc9fUv+XKi+w8k33c5P57KQy8EmI7h9IAR3KoFW/7d5nC7/8fnX7bx
         vWsbv1Yfl55JZTwb9XOsAfBMrBtjjTRbW6BMlqp5fxMFAsuizpVnqUBdZQrkfO+3d5g7
         NQhPunmqNfr40+x4klrJF+EWOl8r4GO3Dv6puiAVAmC/YbqWett42MqK7t8ZQwRxiLGm
         fVXA==
X-Forwarded-Encrypted: i=1; AKwUvBzFYC9kk97swhs+/9lJnh6JN3V+DJXrBwEH1eGStX/wOIX7eByyUEiLWHk5XURQt3mn3tRh2wNcLQ==@vger.kernel.org
X-Gm-Message-State: AFuF++n1rJzQgJIOUCOLOsaSzwtP12hxEKzR2X5bh34lv/+xMlRMnOEf
	1iTmKeFmS0BW6vODy8l+jbK70kg4xQIxRelQg9bd64IL7BMpok1qvSS2
X-Gm-Gg: AYBFou0jVFl3NguJgKj5mavufx/2xwPidaVE8bVoWtLbnPDmgLNqsq2YNvd2u5/0Ryv
	aAqFXyssAwgiq4P76CEqy0JZNlS63ZvQ5q6n7YArisi/qbdNDrvo026etnuR/Zhv09UlyMHhiKN
	NTAqgHJk20RXxjT3vjDhI/EZP2v61v9tEJEDOgQw6JOG2ACzl/+9OvhLwzq1i+byEHL3CY3Nodt
	V/7J53qdHC7BQDVkZj+Jk1SZEX47/nYlwP+xjk9Y/AIw6bYpLBxgJeswpjYrmmy/FjiKRy2T4r0
	toP/6eLZySB5lC15QcmEVRJzDJoLTIpfCnj5cMSo3Y/wu1gpMX8uNaeKL7aynCnvibtEsGlaFLX
	Di/hUHi9aglbrUTaxMAwPuQnovmEUD9Eteki4hKFsO7vPsipu4v68PRB2z9SzfFxBKdkNcVi82k
	rc8A3KmvVnF3SGayYeXa83UjJu/Aj4ZeEwY09GIyqSRcv7d68vToh4OHW1CtjTbbflZIjTPQ1zf
	xM2X6V3IEzh7Q==
X-Received: by 2002:a17:903:3803:b0:2c8:2808:3ec9 with SMTP id d9443c01a7336-2d74df0328amr524510515ad.12.1788246542738;
        Tue, 01 Sep 2026 00:09:02 -0700 (PDT)
Received: from localhost.localdomain ([157.51.207.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32bdfd03e71sm18274680eec.1.2026.09.01.00.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:09:01 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: andersson@kernel.org,
	sboyd@kernel.org,
	bmasney+clk@redhat.com,
	jbrunet+clk@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org,
	ulfh@kernel.org
Cc: radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	taniya.das@oss.qualcomm.com,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v8 09/12] dt-bindings: firmware: qcom,scm: Document SM7250 SCM
Date: Tue,  1 Sep 2026 07:07:14 +0000
Message-ID: <20260901070717.20513-10-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901070717.20513-1-sreeshankar0910@gmail.com>
References: <20260901070717.20513-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the SCM compatible for Qualcomm SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 037d4ad8f..0cbdb3b2f 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -74,6 +74,7 @@ properties:
           - qcom,scm-sm6350
           - qcom,scm-sm6375
           - qcom,scm-sm7150
+          - qcom,scm-sm7250
           - qcom,scm-sm8150
           - qcom,scm-sm8250
           - qcom,scm-sm8350
-- 
2.43.0

