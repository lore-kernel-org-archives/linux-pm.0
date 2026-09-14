Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C86442B1F;
	Mon, 14 Sep 2026 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386925; cv=none; b=GNqXdnV0u04suHNt0HgVhEAHAs91kTsBoRE1Nr7eWQfC6ip//DFr2pX0qkO1ExomVgTzTdFxoY6DD1Gbgf66zjrYEyew1r2w+CE66dfkiybjbh6BVHEHLF9mukB0ZEDZCd847WyZzDfNizLcDA8MsVfYnVKGdXp9J9UgIKkqPto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386925; c=relaxed/simple;
	bh=bd2erxaUpOuj4O2dCwxLFOLtKTcJh011b5a37qTuqqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QLa0c17RyA0FM1L10mzzQEWdLk5KmY4dZeFoH25ey9n5TlIJlqkntRzqe7pskOSUeQ1uM6ul9/SuwjcU3BUxdkYJHh27w+vcI9WKPbgS6H2+o/Y8XGqrgYIGADHMeBeG4U4Ij6fXONqPP03M+5GoraGuQWKLPbAn7MhBrw5ZFKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKsLJnyE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKsLJnyE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551A81F00893;
	Mon, 14 Sep 2026 11:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789386923;
	bh=WQ4cDOZR480ZYl76QHpocLMJtx2lG9QDHXMvTEiDm5s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eKsLJnyE3l8ruOMEgp/QQ7pAAQnw3MqMI8R8sJtkZC+ebUCM1WHljWC6LHMn56cWu
	 ZNyLpssuhdF3Rev5lLeqGYwrvRrb9ELtBFHKpaThYRXQjMfJHNEuAJHNg7RgMQkn4i
	 ndAa5/vkAuS4dz+YqrK8JJVdIT0AtdOeVTzztC7yi0ZzAPH9f3rLoWTGm2YOETxv6D
	 T7SxIg9bhaYMy/3dFuNOZtrVB4yFuRylqCFIUiYTb8MnIw5JVUDCDQftybKZK7YROi
	 arqx5JXIyZ2fnYgWMXqCkGC9JMMmIJG7gSejwfngYUgAhB6j5ihMS/r1vSdVYjnxUA
	 JGKCxRjHlDdmg==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 13:54:39 +0200
Subject: [PATCH v2 11/20] dt-bindings: timer: arm,twd-timer: Allow power
 domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ux500-power-domains-v7-1-v2-11-9d0c17e1f816@kernel.org>
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

Allow TWD timer nodes to reference their power domain.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/devicetree/bindings/timer/arm,twd-timer.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/arm,twd-timer.yaml b/Documentation/devicetree/bindings/timer/arm,twd-timer.yaml
index eb1127352c7b..716d5f2d4eac 100644
--- a/Documentation/devicetree/bindings/timer/arm,twd-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,twd-timer.yaml
@@ -33,6 +33,9 @@ properties:
   clocks:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
   always-on:
     description:
       If present, the timer is powered through an always-on power domain,

-- 
2.55.0

