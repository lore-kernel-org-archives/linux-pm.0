Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7832648642D;
	Sun, 20 Sep 2026 22:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789944539; cv=none; b=Jrc/Dm8xrTq1ZmW0sTg5MpMza22z3wjsypuxTRloMmrEK8UqV3fiB4qi5Gh7gzL7Cx9NYnGPm/YLkAL7uV+orI1vrwOfkU/9eCPzOYXdm6F5cGnN9oMrGXyfWSLj4zxAZsbkvI2HbOGI3AQtidIdKos4+7IXtTxmtIt8yr1QDFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789944539; c=relaxed/simple;
	bh=ojSELXkz88xcB3Lf8PbHquPnB/IMxURYlF1qoM1wpA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d8adB4L+kd2yhLU09VxFDvUPiCc9f3JT2Tzq4SUHXP8PYIMhVkGa89G5Jv50I9jr9ZrD9ZzwxgZqWzx8xcfVQ1IBrXKL/n+byrH8SdEIORRkGTGB6ymwTC7DysClOMUE7ZGKhTgG2O4RCqOLmIrFU14DLJFjKMjMg908muISzS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CviMjVsT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CviMjVsT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531141F000FF;
	Sun, 20 Sep 2026 22:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789944538;
	bh=MmlbpVMmMHMs1r5j0DKbq3pvTJhWH+8jZjt/WcqFqsA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CviMjVsTmnlEwtmzTXimVkEv5OXgZjl9UGdG5CKkQjrTRwr67GZxINRQklPdrTfko
	 KbOISedK15hkr7YbctfybZKxaqWYesxdkmhzCPp0refkhyVoBWXOUQfKAXqeGLU3nK
	 Sa1BQqeCbz9Ql4zVzeJYoFlxDuywYuSFPl2rhKimH2I9PoygJJjuO/t0Wi2QSQ9eYm
	 yq5L9BkJhwZ9siijuzOeengTR41kb0jzIWu8ylT+McuZEQPAZapKMKsyh0ZDG3iw9C
	 0/d7UNDf2dxx23vbkF63RMKsFOBI70swK+8T8HBQPd/H+lNVNpHau6SXxwwAKkNszX
	 YPav3ywyXRwUg==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 21 Sep 2026 00:48:16 +0200
Subject: [PATCH v3 10/18] dt-bindings: watchdog: arm,twd-wdt: Allow power
 domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ux500-power-domains-v7-1-v3-10-9352be6b86b1@kernel.org>
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
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

Acked-by: Rob Herring (Arm) <robh@kernel.org>
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

