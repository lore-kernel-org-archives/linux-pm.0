Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EC44137B2;
	Mon, 14 Sep 2026 11:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386928; cv=none; b=ghbhkQ235VrVRE3JnLqY4ojz567FaoYz0FWGgV2pCzTlizS3RgOvPua3/GZRLkTtbYzm7hcTTElw8vtucOJhx7amdnN1iLciu1xju/kxibBEVbWf3/q8cvB4S5iR4cyR932jgqVb5i/wHBcH5jwqm5ESwhdzv5H/BduvpH+pzUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386928; c=relaxed/simple;
	bh=XzWh6GKD8vsbnUlevqaIui5yO3NmIRWpP7ozUlg5PFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hLG22//CQzkmnLwu1WRdNuz3nOzWo3JAwKlklREPqCIdZl8H+9GTB9kvexu0h9fKJYe4BmD+wC2QfJFRjDCME5LB60Fujf5qzXAZITNdwaEYMVYmzDuOIK5xM6v6YEy80PsXV1KdnQoV/m+zYeM2Lac/wMBxkHO8Eza8LB68XNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtOyZpq1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtOyZpq1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EF51F00898;
	Mon, 14 Sep 2026 11:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789386927;
	bh=2ErdF9zbcnYBBoFr2LO3F6wn1clGA4i7eH2E+6c0H98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JtOyZpq1Hhaq7VNsbGL3TUBK0A+uOjC4l63XYetDbuYHNvP8X7/kNNpJIHPECccb2
	 q80v2JBQKSHyYAdFkRNMic8WHrZyHrei1R+gr/8k/97b5wNyP/wm+YRBjmj4Wm2CsS
	 HOChWONdtXCFI7gI5jY9oGkmD5Enx+sciAbc2qGxkvdLGGWrVeGhEfgwudHVZ1lYXl
	 Gu4gSGyxcZdCnMDAYwm+YqKAjYlG5JvR1LHaVnAtgz/nwkF5cYrlyVXmXQ9o18DDTF
	 vgTyziKrxt3UM2V1eCV5ySxodsqjdYKzI8/9MToUqvXaiwOKNUE7LcPzLi9k3qmZNB
	 WlOu5sG8R1ZgA==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 13:54:40 +0200
Subject: [PATCH v2 12/20] dt-bindings: watchdog: arm,twd-wdt: Allow power
 domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ux500-power-domains-v7-1-v2-12-9d0c17e1f816@kernel.org>
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

Allow TWD watchdog nodes to reference their power domain.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml b/Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml
index 9646ac72051e..5f6a9d6b9976 100644
--- a/Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml
@@ -33,6 +33,9 @@ properties:
   clocks:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg

-- 
2.55.0

