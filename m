Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D6C38836A;
	Thu, 13 Aug 2026 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642851; cv=none; b=SlKJOLWx45rr1GDtuAdvEt8u08Q5b50WmGG4NmU9rq+8PclFiU1Yey7Fnba0c2FubffQFZOgJWRHiwv7b+gKmiPpyetV+ktzhd+bkzt03X1zwes/cXR5kwnaOpyIhiJWqAD44wbBbR43vMzKs5c/makQXX8aaTvBskP63fa9ats=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642851; c=relaxed/simple;
	bh=ZGzwxVpHIZ4x1aAWQOkws59u5wdYbmch7/e9cRtuGM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f6NVLo5I/y4RLeY5pYQQNlzK9AraTcUZCjs/8g9hB3IWqN9JVDuPDKL6eFbNSkzjdiAAn1nWY1lFUCsbV2CL5YBSFqJoZvtQfCfbcoo4INao1BpVf5JfAqjUHLaELjS/jdemwfPosf/XxItTJ+nGxE/yvImm5jAHslfY0AgihMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vd4KdLes; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vd4KdLes"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB141F000E9;
	Thu, 13 Aug 2026 17:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786642849;
	bh=QfPiB1znTEQk/W06w59nK6nNn/ntLB9YTnAP35BaD5Y=;
	h=From:To:Cc:Subject:Date;
	b=Vd4KdLesM9yRRjn+q+Zme8aZ31dmcqb+Cy+BQI60m8xtAoUOt5i7EhOoUulOh0g7b
	 numqeao8d8o7HXYUj1Sys+YILApb35we0r6UapTsufdssgA15L99WX5e4IUAHyFVHJ
	 J0y/n6LSamWa0+ZapDpzVjviqef47e1KHC4J5m9QXlqapDHB78obQbAjceII2YcG06
	 0owuarnkjhyOppR/iA74tdM9K7MbN/G4gn1Ho9p6ZcVPLxa6OysM5b/LTYvS5uW5op
	 3sjNrzd0TB84uTMsDpRselazGIHgiAPbESc2wO5ScW0sJhZo990HJrTu+wCNoq2OEo
	 LDo+TJmMGc9zg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: devfreq: samsung,exynos-ppmu: Use standard regex syntax
Date: Thu, 13 Aug 2026 12:39:58 -0500
Message-ID: <20260813174037.2263884-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "{,N}" regex syntax is non-standard, but happens to be supported by
python re module. It is equivalent to "{0,N}" which is more commonly
supported. This fixes using a rust implementation of the DT schema
tools.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/devfreq/event/samsung,exynos-ppmu.yaml  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/devfreq/event/samsung,exynos-ppmu.yaml b/Documentation/devicetree/bindings/devfreq/event/samsung,exynos-ppmu.yaml
index d27dcb2fef12..a3f0cd508b3a 100644
--- a/Documentation/devicetree/bindings/devfreq/event/samsung,exynos-ppmu.yaml
+++ b/Documentation/devicetree/bindings/devfreq/event/samsung,exynos-ppmu.yaml
@@ -40,7 +40,7 @@ properties:
     type: object
 
     patternProperties:
-      '^ppmu-event[0-9]+(-[a-z0-9]+){,2}$':
+      '^ppmu-event[0-9]+(-[a-z0-9]+){0,2}$':
         type: object
         properties:
           event-name:
-- 
2.53.0

