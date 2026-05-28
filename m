Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014FB3E51C4
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968187; cv=none; b=kkB0yB4G0nWykAr5fIJgztJyNgc3p8mL/inlmyhbd3lWpVWqK7KQ0HlLSDN92r91M1ecigVjikcGMORzQeX+TRiUaLgfe2AHaXONb0CYHose2MKsYVlVB+uanAYBseC3/KPyz8bQg5eIKqJCkQaqurBYvzwwB/GrsvtzEUhpSZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968187; c=relaxed/simple;
	bh=xJKlJC7dGl0wGAvaj+do2NaPXo539auehvyu06PLQZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SOwZOi9/QipFg0yg7dS0g8OpIeoqcFecze9CSLgIgDK2eu+/iYio8gTgM8E6exkFcCPXuShE9f02qQUXmUBpaOrwR6Bv/Ll8g7D0ddfZse9EGfEmnNP5nHDLrgCLi+hY+Zl0abcduqbvb0+ClwS71ZL1zXAoVMp/LtPN6H0NcO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X6WaRSKR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X6WaRSKR"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48fde648a71so84392965e9.0
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 04:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779968182; x=1780572982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BekxfQF8PLQVYHupI67TdA6JhqhQbbku1rpfflIBCq0=;
        b=X6WaRSKRsbGXDV8YF7KPF4mNShE1bdhYsuKSHf+d6GZZvfds8tC2lWHX3FfjtEcctH
         nTYNwDd+5atzb7ffM/+PScAT2V+0o/bJBmUrcaW7iHdTAZl+hnALWlm6zBNP35TM7XtW
         NoiZBGhISuBGUgLsiN2tdkp3LuopcMvPqWSW4PiAmelR/vzCr/gFFNYMzIjDCK1WvewB
         LVMRLFpoGDIer3sRvLohHUMiv+Mv9wYFP7WS8Zqvzx+APnBxLPdHebFQenRxSONJQREl
         yVvh+stSRD14nCfDSh0gTR9vJxx1IsBbtXHZ2u1S/4TLoM8VV3fk6xRUCrNPo++xMUSe
         ek4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779968182; x=1780572982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BekxfQF8PLQVYHupI67TdA6JhqhQbbku1rpfflIBCq0=;
        b=FAeFiJyLo9jJeoZL4SPyXkpfHM4/9THpnpvxhU5EclI1jnL6hDRZxKqGLK9Tv7qoNf
         hLmb+euiy8rupOMVoY5sX9/Ot7CNUtqSdjYox4JGB7A+4xJoJjt3JAWWmmG85NoEwpuF
         5aXo6IsW2/EeEp21EQ4KdEeEVbkVrRCzqTeFSxu1yKV8SseBMi4bmwTWcCNO4lqu41NV
         UuAnGrx5BRpxBqdkwQaWZUCriXL5XK5AlfYFnZhOVwdp03rsGumZAGIlSD3G/YSybwGd
         +vgRQwazyT7ST4nl1xGLyXsSZlQOoC1jSZmt+cHfoMQuvSsRA6cPTdfQfY8MR3wldKJY
         Y+vQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Hmeng986KtKdPsMcYDzjMcdc3avNZKDeIfi5yqkbBX9MsE2bFQge03blUYkcTa3B/ZPtCM6/lIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh4I1wyutlpARn9oH6Jtw7HQvfV+IPbDa23JIB1prE5WHiAm8M
	dzTGXd0tOziG1pSnDX3e50AwbQ0fy468y73Wfx7Q1pZwfz772HUWAzS4BGyC6yqGsbI=
X-Gm-Gg: Acq92OFOqML4iEDd9oWfHie9FEax4ZTMSiKWzRq0HPTBWq40mpaUwT6kf+oK6jGBRDW
	9Zxa2kHDR2E88Uz5d9nV1MUJfcmcfPzKLQfdWqZQiEgl2/1BUUsjVGdIyfLl4//oX5Opf7acpLI
	pViaSBigPA4iH1F8Pn2YvJGpFKwMKV7nkorSsGYyK5XuhdSsSNhe1YBWiMyBVFQsFIIJcvqksWj
	7Z9LPfBUHRM4jJDT8DszRzD7iGBDC8Bug3l3z7uunxoWvYsl5xWhMcNi1QRmTPsy3DwCk5PMs6y
	isMkO6lR4iX3YeRLryTboaTADotEpmLOcShlizHBv0hE++LYcO1mT/OxQyWaOeGiGDh9Lpkxkoe
	O4aqlGqqdf65wp4pWdIvMP5CeWxUxBKQxf+hWFn6Bnd009OeVr+3tYFwWKhWfo9e0ArIi75Z+bf
	+9lnEKpVvU2N4d82TRyMFapfZyvPyhl8QnbjhNKGOIonAH8ID+9eIPgiWUZZ0ggoGrX6cfUgzgC
	T06fc4vgHVyyGYb0w==
X-Received: by 2002:a05:600c:3ba5:b0:490:8b0b:d3b1 with SMTP id 5b1f17b1804b1-490947b0929mr17354425e9.12.1779968182422;
        Thu, 28 May 2026 04:36:22 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49092a902bfsm60385715e9.12.2026.05.28.04.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 04:36:22 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 28 May 2026 11:36:16 +0000
Subject: [PATCH v6 3/5] MAINTAINERS: Add entry for Samsung Exynos ACPM
 thermal driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-acpm-tmu-v6-3-b4d7ce57594b@linaro.org>
References: <20260528-acpm-tmu-v6-0-b4d7ce57594b@linaro.org>
In-Reply-To: <20260528-acpm-tmu-v6-0-b4d7ce57594b@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779968180; l=988;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=xJKlJC7dGl0wGAvaj+do2NaPXo539auehvyu06PLQZg=;
 b=/RrV08zJwcGs+ddtnbcR46GfaRC7OfWZyTRmTT0RYZwhRTifb8P4BFHNCQhv5h1Ki92YZBkoZ
 NPR7YdMiLPgBcKDzpqdf42dJ2N6zsZtFSV6gfm3ESwzL0rOq/+LKlIW
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add a MAINTAINERS entry for the Samsung Exynos ACPM thermal driver.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..7ea3b9d95ccd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23660,6 +23660,14 @@ F:	drivers/clk/samsung/clk-acpm.c
 F:	drivers/firmware/samsung/exynos-acpm*
 F:	include/linux/firmware/samsung/exynos-acpm-protocol.h
 
+SAMSUNG EXYNOS ACPM THERMAL DRIVER
+M:	Tudor Ambarus <tudor.ambarus@linaro.org>
+L:	linux-kernel@vger.kernel.org
+L:	linux-samsung-soc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
+F:	drivers/thermal/samsung/acpm-tmu.c
+
 SAMSUNG EXYNOS MAILBOX DRIVER
 M:	Tudor Ambarus <tudor.ambarus@linaro.org>
 L:	linux-kernel@vger.kernel.org

-- 
2.54.0.794.g4f17f83d09-goog

