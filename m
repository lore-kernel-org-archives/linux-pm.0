Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEA9382296;
	Fri, 12 Jun 2026 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301203; cv=none; b=qOlV0IJQkK1E8BxVZXznYBod8BW8iSrmS1kTsrH/ZVN/XllG5ms3jDc2UFq9mxm3inSO8cDBENbTXDSdqFq+ySQOqJeRTgqFPsn7ZetJgcFvjY8zOEmxByoK+yGVWuT+HtRbXp2GCvUJ6uYkTEgsQW5+ycfwO4uTUR877wZQQLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301203; c=relaxed/simple;
	bh=7a0uRssRXIBSebRonMs1myUkDLDCVX8flRsTdK7xGmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4tj0nVDg6i4HGzExo7lwkGVtsq5L9vfKwB/xR5prPsFaMUPTMYjzfcumJ6+BKimmQVfOQZ3COKy/wz25TPiqfKq1QolyVw6nhBS04I5H1pvN933FimyACUMjmcAOPqy/CPyGPevrrnzYZPIOXpdjb05qQMWsk/2/CSmIaNlero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkllISHE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkllISHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52B01F000E9;
	Fri, 12 Jun 2026 21:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781301202;
	bh=XgD5IFq2vTCmbOmMLpA5EhUbQZ2qlubcaShXz6t+eXY=;
	h=From:To:Cc:Subject:Date;
	b=EkllISHEHOtq2exHvAgM43tUTI6IMSOpEaKgYECFUbmcwwF+ADaFP0hCd27mg+YAo
	 yKEFZhUjvHU1N5bkUvu+Z187yyTcJ9H3wliJkbnAZ3rIGWmioxkcHVtGPtxtyo3fts
	 r2GVDXZGLaIgTjm8HZE0s275WPsL+J6FBe9BrIpmaHb/P9qmlRmc9cSAAsRP+Z7JVv
	 4HQlUac9PE6j1daO5lNSYMvqaIHxukzgFuxBbuqcKHr0YOX9CBG064yy8bnj89inP+
	 ocQTBeo/EC05FbCuwjSNpXWlbGlMbrYtc6HmPRRwYW50B9iPhqZgqNbE4XwEl8SLUR
	 ZkNHYB1aOY+CQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Sebastian Reichel <sre@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: power: maxim,max17042: Fix temp types to signed
Date: Fri, 12 Jun 2026 16:53:15 -0500
Message-ID: <20260612215315.1889039-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The max17042 binding described "maxim,cold-temp" and
"maxim,over-heat-temp" as unsigned values, but in-tree DTS examples
use negative temperatures such as a cold threshold below zero degrees.

Document the temperature properties as signed int32 values so the
schema matches existing DTS data and the driver can use signed helpers.

Assisted-by: Codex:gpt-5-5
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/power/supply/maxim,max17042.yaml      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
index 242b33f2bcba..8687009b4057 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -44,13 +44,13 @@ properties:
       Defining this property enables current-sense functionality.
 
   maxim,cold-temp:
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/int32
     description:
       Temperature threshold to report battery as cold (in tenths of degree Celsius).
       Default is not to report cold events.
 
   maxim,over-heat-temp:
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/int32
     description:
       Temperature threshold to report battery as over heated (in tenths of degree Celsius).
       Default is not to report over heating events.
-- 
2.53.0

