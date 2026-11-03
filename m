Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745949;
	b=Ek709tY6IYlPMt1rMBt+IoKAUfle7eu+D3e2c8NUk2VvV+n06RksfG0x8WsDf8SR499C
	 TPrLKgYcfG8PlFTGUaj5u8juBrxS7pRRzBGJb45WGJ7G835ij9/qaxNq7FvXNcx7AXq8b
	 vsVj0gGOAipI7CSqyl1EqCBQQhjO80PKbkcT6bHbZhdcvnvEFGbpXEXUUtO3AeCA5P4Hh
	 CaMSaWMYZQj9yrS9AbaAt9VTioGp5NxNw/hWUYhsp5BOEbWYJFjR25K0UrB3nNPKJ7hDZ
	 GMEp5pvTTn2hXLcPvQJBe1tDutQzK1g7kcl8DmynFxlC6r+0hO1t3eClP1xjEirLa8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745949;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ShVogAlnwemR+eSmdy++bj3DisqjTOdJ/lCnAjRwWDE=;
	b=Feh2NiYptU7/PrN8Eih8vAo5MltUVpgHieuHw5PjYFOi64XLiG5Wi5RtL9cuO2MCt23W
	 WRDLkSly42v2u5CPlaNEU852w97uCPRrKW8d/9FH3rVFvBMgtb67U9XWZa4zKYVK1OtVl
	 nJRy8bzXuA5bnhYQD/agLOMcNd9L9eifSl3BxnbW+KJmiBRsizfIgVFgdCHTMgxPL324/
	 fQggX+qMaEtoHF4DPK7CgBgL3dCnf7AFNGwHxV/EYgl9e3Hrw9e/H09piiohnZUVvYf4V
	 hJzcs6/Syt3te/Sk3fMEBWDRcUEG3yyM2GcqBDOkRZXjCMgd/8UQmK8BzOv1ZezkyxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cn4BhSAY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAD1606A326;
	Tue,  3 Nov 2026 22:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cn4BhSAY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8931F000C1;
	Tue,  3 Nov 2026 22:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793745949;
	bh=ShVogAlnwemR+eSmdy++bj3DisqjTOdJ/lCnAjRwWDE=;
	h=From:To:Cc:Subject:Date;
	b=cn4BhSAYBgR66HgNYoQCHTtzE1q5pV40RutOaAlvgfC8dAClClxqPfecHc6Vf3TLa
	 vvDe63Pp9qYvgtfP6wTxlTaA0dlJBt0XgHaaCa19wDrUQHZSs5DkUPFsUfsRRYOCRo
	 2JEgisHiQkVPPyYVk/ZpmHuBCxarh39mNuOEm//nBNZDOPtC7k620Y+g31C2xm/0K2
	 g5lMjU0HrAZ0TGgPNQ30rm6mtFpRJr6XfnXxOBJxyrLLGmoQRTMZFFYzoKURsXvLh4
	 euxiuyCSTrE3WLFwrOOgR1yhg/CD8OlNiwcXOCo05h98lktgmOqTa3a/QvGOLM/6SN
	 g1dX6UqwekksA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: opp: Allow 'clock-latency' with dynamically populated OPPs
Date: Tue,  3 Nov 2026 16:45:38 -0600
Message-ID: <20261103224538.877008-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
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

Tegra210 builds its CPU OPP table at runtime from fuse-derived process
and speedo values and built-in CVB coefficients. Its CPU node therefore
has clock-latency without a static operating-points property. The OPP
core still reads that latency when initializing the table.

Fixes: 80728bfa8c79 ("dt-bindings: arm/cpus: Add missing properties")
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/opp/opp-v1.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v1.yaml b/Documentation/devicetree/bindings/opp/opp-v1.yaml
index 61c080e50859..3dca8f7f146d 100644
--- a/Documentation/devicetree/bindings/opp/opp-v1.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v1.yaml
@@ -24,7 +24,8 @@ properties:
   clock-latency:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-      The latency in nanoseconds for clock changes. Use OPP tables for new
+      The latency in nanoseconds for clock changes. This also applies when
+      operating points are populated dynamically. Use OPP tables for new
       designs instead.
 
   voltage-tolerance:
@@ -41,7 +42,6 @@ properties:
         - description: Voltage for OPP in uV
 
 dependencies:
-  clock-latency: [ operating-points ]
   voltage-tolerance: [ operating-points ]
 
 additionalProperties: true
-- 
2.53.0

