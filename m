Received: from mail.nozomi.space (mail.nozomi.space [139.162.184.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39333A00C;
	Sun, 11 Oct 2026 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.184.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791744483; cv=none; b=vF2MV1ZuU0kZGEu+HIe1MRRhxXBmVZSj92BkIXkgOBcASI2uwSdffxv8i6rNOwmPbVxiJRlyS4ytM2B9LTb01Coix9AhvqhqMCBajBmRTmd1zWnJ/m1fe65Baij4Uk0AiER7NZUvACuiYqn+oWJT4YERH+Ov8UVNmzLzpQTbacc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791744483; c=relaxed/simple;
	bh=5oast4Pc6JtyTMzcGiT3Fk6p9TPFApMcUqvotOtvaAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puqXDWvuqTZOmdPpOH8fi0p6g2fzez0JdZQaURBTt/wpikJhqjf+fxKZ6+rMET/h/mFiuzBu3jn5OlqERBjsy5z8RvQUQVwx9nQ4pHMtWXWEpZp/DhxygTCmJxi83eYvcsNDfYMlValr7jaKBQdoi5xg0HEU9TWFafInbOgsap4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space; spf=pass smtp.mailfrom=nozomi.space; dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b=YI5GJFe0; arc=none smtp.client-ip=139.162.184.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nozomi.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b="YI5GJFe0"
From: =?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozomi.space;
	s=mail; t=1791744480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9TDMOuCORdDz/rW4tH87DC+y7wSf+XVxBuEz3/UlgI=;
	b=YI5GJFe0WDeMYMyXwMbiD7mLRwAiVcZSPhz+ohu37TL7yz/1To3MiQf4NyLKrxeHJ/XhwV
	coztSffJmDjlXgdJDA+Tcz3a+0nyh5WVW6ruCJXsay5Qp0wA+KUD7w/WG5iE6nNiRoYpA0
	AVxVAZ+3DmjaGTKFCb4IA7Ud4W/tlSdnCXdbGhoiyJMjdJ0cfgQVE50CarcBhVcSi+UOyD
	M/wBcUyG/Z7l7FnKLxcB54sTCDuzbUNhxm23hfLl8pW3AtwqZw3b03/fHkW0UHRtfVDF7M
	hqli1S5Y2Z19iM7jl+ho2GCb5kgroWfdRA9J21fLsABLUe+RzR3OrwxMYgFJAA==
To: ulfh@kernel.org,
	angelogioacchino.delregno@collabora.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
Subject: [PATCH v2 1/4] dt-bindings: power: mediatek: Add the MT8188 access controllers
Date: Sun, 11 Oct 2026 20:47:52 +0200
Message-ID: <20261011184755.2058017-2-michal@nozomi.space>
In-Reply-To: <20261011184755.2058017-1-michal@nozomi.space>
References: <20261011184755.2058017-1-michal@nozomi.space>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On MT8188 the GPU timestamp counter only counts once a register in the
MFGCFG block feeds it the SoC system timer. MFGCFG loses that setting
whenever the MFG1 power domain is turned off, so the power controller
has to restore it after powering the domain on, and needs access to
MFGCFG for that.

Describe the blocks that the MT8188 power controller accesses,
INFRACFG_AO for bus protection and MFGCFG, and extend the description
of access-controllers to cover blocks with settings to restore.

Signed-off-by: Michał Kopeć <michal@nozomi.space>
---
 .../power/mediatek,power-controller.yaml         | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index d03e4a9251635..8d96cde7c1a51 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -54,7 +54,8 @@ properties:
     description:
       A number of phandles to external blocks to set and clear the required
       bits to enable or disable bus protection, necessary to avoid any bus
-      faults while enabling or disabling a power domain.
+      faults while enabling or disabling a power domain, or to restore
+      settings that a block loses when its power domain is turned off.
       For example, this may hold phandles to INFRACFG and SMI.
     minItems: 1
     maxItems: 6
@@ -188,6 +189,19 @@ allOf:
           minItems: 2
           maxItems: 2
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt8188-power-controller
+    then:
+      properties:
+        access-controllers:
+          items:
+            - description: handle to INFRACFG_AO register block
+            - description: handle to MFGCFG register block
+
   - if:
       properties:
         compatible:
-- 
2.56.0

