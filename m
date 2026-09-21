Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F468518125;
	Mon, 21 Sep 2026 23:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033232; cv=none; b=NwtXF53aILmzm0coJtr1ifXzlc2X7yOZyShQ0OOn6FPkBpIVjBmfjOh/kfGnHk4cDJdBjKvFG3HnHgV3wqyWYAaqCsYy9WnSGRvDlnUkT81ksJkDUfbUVn5otF76nz7pxOCC+ANqRSoJdXgfdIZQPoFoJmQVfNIE0xohjuRS0c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033232; c=relaxed/simple;
	bh=VvUq72tDxBIzxt7SgVTXcJUmDA2eBGvYAecQ8pMJWwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BqvEyrf37HDYkSgpH1rQoVKi+0ueRxh782VpQzUQwUF+O6c1uJNRs8PwZtw6Nvtj6nKpQc6AuXWCK6Qw728Cg09KAnagsLfoKafDKOt/U+rZZ+52frh73mIHBxV/N533e106tE/CKZoTWSEsHwSHqmE+HcJ3fdvZJGfTPtEXMlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtS1PaiN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtS1PaiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CDF1F000FF;
	Mon, 21 Sep 2026 23:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790033216;
	bh=IUe+Dpx+RFTCFSmdw+LyaohJ6/6qox8ai3T1sHvA7rY=;
	h=From:To:Cc:Subject:Date;
	b=KtS1PaiN5FLyH0RiiXvjRUPbH7M8MxDi0jo47WVdL/ZAQdXJcDU/zvdPR1AoDwH90
	 iF6GsSAPgNEu2cWCVxNCXk1QhD6iXStNNSmdhO0jxjoolQ29rW7uWH+pPbCE8+XjIq
	 zhmxbAfiZWpdhk3fY4QPassFq11YzgEH7ardEqLOngwDNFS5yxQhutXsEXBEcWpEHS
	 lJsJp2XRSMTXm9OXOcllsWPQxLHj36dlnjfzh7aG8StFdW52oVAtWL5HJXZED0BiIA
	 JtNcipyMzV9T3caBoX4Qk4p3Qv0wNYEA/LSRfxlzeFouCN0JZnvEi+cRGgnvNJv6y3
	 HnE4qDDidg00Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: mfd: Add MT6397 sound DAI cells
Date: Mon, 21 Sep 2026 18:26:48 -0500
Message-ID: <20260921232649.3132592-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the one sound DAI cell provided by MT6397 PMIC nodes.

Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 3cbc0dc12c31..e2caa049a60b 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -57,6 +57,9 @@ properties:
   "#interrupt-cells":
     const: 2
 
+  "#sound-dai-cells":
+    const: 1
+
   rtc:
     type: object
     $ref: /schemas/rtc/rtc.yaml#
-- 
2.53.0

