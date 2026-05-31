Received: from outbound7.mail.transip.nl (outbound7.mail.transip.nl [136.144.136.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129C3302163;
	Sun, 31 May 2026 04:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780200566; cv=none; b=ZnAhVGRslf8plKKTwzjldmBOe8Pgi1HvZlPqOn+qdjKt+ZoHhtLreqS1UJe/K/1pUIcfFrW3fgicu1azu4gvOyhM+tFO6eieIk3j6PiBUfbj5bB/xkqDAM0xbKzKYf9YRoaPr2S+qs+VkSt/jBTg8srbLADPUZzK0oTZOG4r7e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780200566; c=relaxed/simple;
	bh=jdYU3v9jcoHlWkVNU9SgZVEx2LWQRH/PAZ+65QGDegQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZa+eTvzeGHiip7qlwA/wEVKJ9z6NQ2N9JO/YxFr2HHDK6lFENInedALngqVSNNyvzATsSWy30MHdj/GyzbxaYeSy5OL5543ni5sLytzZLU1rqbrnLg8m0Zif/3nPbeojS5oL15raZqULOPWGbviA/tkEdNG1SFtcq4sQIReE8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=K4evxA9W; arc=none smtp.client-ip=136.144.136.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="K4evxA9W"
Received: from submission4.mail.transip.nl (unknown [10.103.8.155])
	by outbound7.mail.transip.nl (Postfix) with ESMTP id 4gSkB74T6qzQvv7w;
	Sun, 31 May 2026 06:09:19 +0200 (CEST)
Received: from herrie-desktop.. (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission4.mail.transip.nl (Postfix) with ESMTPA id 4gSkB66M8sz3R3nyd;
	Sun, 31 May 2026 06:09:18 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: Amit Kucheria <amitk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Satya Priya <quic_c_skakit@quicinc.com>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	van Hazendonk <github.com@herrie.org>,
	Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 1/3] dt-bindings: mfd: qcom-pm8xxx: allow temp-alarm subnode
Date: Sun, 31 May 2026 06:09:14 +0200
Message-ID: <d5f7132771d9ed1d70504eb1ef189a3c1954a887.1780197411.git.github.com@herrie.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780197411.git.github.com@herrie.org>
References: <cover.1780148149.git.github.com@herrie.org> <cover.1780197411.git.github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission4.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1780200559; h=from:subject:to:references:
 in-reply-to:date:mime-version;
 bh=lJ63rCL+Dm5XTJifQ6TD8ogzWBpe0HZNaI2plvhoceM=;
 b=K4evxA9WfoNu9jusCxliIfzDhbp4cTpLp0DJ67ZlAaor4t5D0EG3QIWeM8XV5lSb8TLHl9
 RAxjLTxmOQlqUs5AfOtE52luaApO+Yl9R/ik7caHeag9CyeziLXwdvLkBUffQY2oCEZ+xr
 twUCcMG229AxgzDp3M3f56jY0ALXOkAB9BSaBNT7Ufb9+hxOatWI7TfAorkLqT2U/qJa+h
 qAwWP4h+VNOZ/LQxWjTlInaEDneFLukVe/p1NjehGfMohPK0AMvYHQ8If31qnjA+9fsf4Q
 rapeMzRRHPP66LiJyJLhBBqUSC3sLUAPSeV0FFEaFMjBzg8jcr6WTucbhA9iZw==
X-Report-Abuse-To: abuse@transip.nl

The qcom,pm8xxx parent schema closes its child set via
`additionalProperties: false` and an explicit list of `patternProperties`.
PM8901 (and prospectively other parts in the family) exposes an
over-temperature alarm block as an SSBI sub-node; without a matching
pattern here, any board DT that instantiates `temp-alarm@<offset>`
under a PM8xxx parent fails dtbs_check.

Add the `temp-alarm@[0-9a-f]+$` pattern, referencing the new
qcom,pm8901-temp-alarm schema, so the temperature-alarm sub-node
validates as a recognised child of the PMIC.

Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
index 63e18d6a9c21..dde290569b03 100644
--- a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
@@ -68,6 +68,10 @@ patternProperties:
     type: object
     $ref: /schemas/rtc/qcom-pm8xxx-rtc.yaml#
 
+  "temp-alarm@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/thermal/qcom,pm8901-temp-alarm.yaml#
+
   "vibrator@[0-9a-f]+$":
     type: object
     $ref: /schemas/input/qcom,pm8xxx-vib.yaml#
-- 
2.43.0

