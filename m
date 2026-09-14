Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69C1443C1B;
	Mon, 14 Sep 2026 11:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386911; cv=none; b=mZmc7LSaVzN+WVknnB58jycS5MMedBVwpwpBOL5j5O2N2bgdB2XeGz/5nMhvaXal3ZHpaPdLmFNM3JHTU9+yqJ3GEUdrLjUUS/UKqxmFP3qe03gg5Pxx2mJQTEJtiNxNkeRw/YJ1tnGIcGwaupfwwnEb2BDPYsAFrhbzKYAPf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386911; c=relaxed/simple;
	bh=rqKn4FR6Ru9UAR1NcNIn+4xMp/X8U7ug5PKu3UOV80A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aOqX6TLqg5OOLAtgHR29S8Y33boToNmAj6Z9t2MtodbMID+LDvPz+oUwvJTlSs55FagoepfjN0izkek8hjQZWj9+8sCay/G/d73mkhzXDxuPuIuAeviyi7B1egLce0nimecIcWbqEDLwxojiuCifNtcauvvdCArPeIgCAXN2Ko0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IF+whjUK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IF+whjUK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAB41F000FF;
	Mon, 14 Sep 2026 11:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789386910;
	bh=LFRLY70uQZ3XJlD8CeduqOmhhXpnOmwFSdP42ch1Xjk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IF+whjUKRrGw9vmF3GYzSxrSJZUow6XfgXe0/6Kdq+yXDk/hQAqTybjuN2e9w0l76
	 txMImshSIy4joz7LU2LSehuLSHyHgrYUN4e0aKrE942eC3Z9smo2an92xDqUEilSjF
	 1xwm8+jj3TJkM6sh0PdjX0uADe28nTLu60+rc2zaU2uDkJg7recvAz2+izLac9pjqN
	 5qAWvOrhNRGKoTdF56fN+JxK0TbOUPCS2mKv1RAhbPCXgpU3R0Ud1bN/KH+nx5giti
	 bdu3+one6AEnVCsRxnTejFV+8l2D0trGXgER/L50r9G6sjx2YY1tOkCdKzC2IY8clm
	 atiPIzowJ4XxQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 13:54:36 +0200
Subject: [PATCH v2 08/20] dt-bindings: cache: l2c2x0: Document power domain
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ux500-power-domains-v7-1-v2-8-9d0c17e1f816@kernel.org>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

Describe the optional power domain for cache controllers.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/devicetree/bindings/cache/l2c2x0.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cache/l2c2x0.yaml b/Documentation/devicetree/bindings/cache/l2c2x0.yaml
index ee604117ffb3..4e568c2a34ef 100644
--- a/Documentation/devicetree/bindings/cache/l2c2x0.yaml
+++ b/Documentation/devicetree/bindings/cache/l2c2x0.yaml
@@ -68,6 +68,8 @@ properties:
 
   power-domains:
     maxItems: 1
+    description:
+      Power domain controlling the cache controller.
 
   arm,data-latency:
     description: Cycles of latency for Data RAM accesses. Specifies 3 cells of

-- 
2.55.0

