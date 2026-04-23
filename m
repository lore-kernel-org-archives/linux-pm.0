Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EF537DEA8
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957790; cv=none; b=PEFRMopppCELA/c+XP9/hnL9Rq6G1NtYB6SfeNBeq/WrjKDCi5pYXebu2orGF8iwA7BJXHlKrWaJyqLKhVhcdCTA5TW1Eh2s050e9sqHd7HPvWoOHGIvDkKCp2ElgtF99ow0zbYmRknLmqAaPH1rHTRTQlmSSz6KpAhLoXw+I+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957790; c=relaxed/simple;
	bh=FWU5VNsYMZRRVGYIioWPuaaPLaZNzDvKQUDpPiPlMQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AZS7d15ueI/Z+bKrcffLEWsF37i34DmXAffZKTDUydjcMpCEuql6SOw/lLkrLikhmbj24uVeWVojumY6cJAX21t3cri3XmCE5lhJxzB9mmsPVmRoPE6tNDh0hUHFjTA+ov3e+PiPjrXu3hdxX13LqHGC4vcWzaWK1fKJqmjsbhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GCAAZbYY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCAAZbYY"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso63180115e9.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776957785; x=1777562585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/2rw/F+vOuT6UFAdYwCBkXsXOmQ9+TggXzaKDVp2DDM=;
        b=GCAAZbYYy/w0aeRmk5QZsvV5wURYbYWtVTwOAMINonLeq5HBbGn/Av0cd+ba/u4LTM
         SN2iOemM1vnNT9JwCPtIvNL9WlrC1X4pRpJqEgZT0VAnHRq7podSz3q+QPuMHrVOSDLH
         TWEEuBPfpz/3d4HqBZ2yz2Vo6tvlOX3U81by3UcDU1jcJGjqh88gaEaetY1CAtWsQOUU
         2cN+TAJVM8/Wimal812AvM7qIoDyuQAe7/YqY4bG6Wb99um1MFIEJI6HqxrQjG2+F7dh
         6dsR0bOh95tRe2qA39DhAiheNmE/SP+0RPwHLfGMJuCUrP/jbtZz9KhmUW+5LafOkxh1
         iXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776957785; x=1777562585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/2rw/F+vOuT6UFAdYwCBkXsXOmQ9+TggXzaKDVp2DDM=;
        b=h0TyJ20bSLVHGjEwVRa1jGmpgu9Ro7Kcky3AbLQg3G0dlitGwXtZBck/wpBSJFFSYQ
         yBLCRbm7jF/fdHoHFJRD7THk9eYfrJR80N4zXn6iA32iOUfBqXVcn0u4fId+bxZi1uL3
         ryY7AoS3HzGy2be1YM4RcIdrkt+R8akH0lSAjAv5VOA9CwxiK/Uto+9ZNrKDo63P41hQ
         5x+BlfE61QTbjSxBIt7D/DruT1E8j9AfYffy6070MHjc64l+xoBZYl5bAJR9MeTh4g4E
         4iMbBpZXaG73ewtGaxKbkyW04GTq4wS4pqNhzlim7ji4NzTZe66O2Y+IswCbzVAlwQ5F
         ZzLg==
X-Forwarded-Encrypted: i=1; AFNElJ9e/nMBG7TlLbNDLi13iRKCP6i+t7GmTh5oJqykc5hp0RfGUlyXh7Wd/f1b6AXhkx30s3mSvxu9Jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvsVHa/4t9Re4WHQpW8CvQptc3hkb56PeyhNfYNQkngWKtvH+v
	th+ce2MfVdrEZjcu524U+dQn7b5yni4Flu6pqVinHp2YTxMKv8H6+M8bPLGnIb7u6Gs=
X-Gm-Gg: AeBDies9YzYJt5DEpsXBBl3j7XMcSx4dK2yigPqhwpfhc3CFBAYeP6ddsVZ9pF5zLqT
	i1oO6U3QA/H/RPKcE1yHSYMtSxTe7F0RK6iObwyDS809d3YoyZhfofHHDuv0d2VuGNFFQi3awGb
	69ninIOdmG0vBlZhokUEDzA8DP8zLTvgYQ+gPfULcT9eaLJJ4uu+gd26xYOtYtti2Xou+jc0PGu
	UsWZky4Wu2Y7R/uKrl8NxORf74cwiQlKXIVZbLk7Pd7FzIGTxXJLIWLpe/M23aML+/ttSFQOka7
	nuEUx+jAiaPoaxjLhvk0FswQELrlirDI/UVdIWx6bQ0VI+bISS/hHq/72RK4bJ3+Fpk3asiW3xY
	Ow35mHxZe5LBR90r2c6KOzTHHMaMc0r8xn4mw2d7HUUW4dov6IqjNGXyLTVp84RYA1JcT74HjIX
	56MF2NajfdXyk+YHeRQ8Y83BgDMbxXNxFUYx9hQWIJ96M+bb+mWaJ8VRX+b6K82iL7jBaendgus
	z+AlZHOgdnStZ/++Q==
X-Received: by 2002:a05:600c:4fd1:b0:488:78f2:6b0 with SMTP id 5b1f17b1804b1-488fb78ede0mr397227715e9.29.1776957785364;
        Thu, 23 Apr 2026 08:23:05 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891f98728dsm90550755e9.23.2026.04.23.08.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 08:23:05 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 23 Apr 2026 15:22:57 +0000
Subject: [PATCH v4 09/11] MAINTAINERS: Add entry for Samsung Exynos ACPM
 thermal driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-acpm-tmu-v4-9-8b59f8548634@linaro.org>
References: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
In-Reply-To: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 linux-clk@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776957778; l=988;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=FWU5VNsYMZRRVGYIioWPuaaPLaZNzDvKQUDpPiPlMQk=;
 b=oGan3n0YDDTqNrNPvT5e5tY9UzUuAumcLznabKnHsbyyIVFfufKds/6MUWf1Xq0V0ycSAXT3/
 KZjDYxlqCdNAPXdbDR3RyrFMLbqE0LrVkmWv13ndxJQsDwP/6anSJj2
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add a MAINTAINERS entry for the Samsung Exynos ACPM thermal driver.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9b7b6f9828e..759c05bd0004 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23693,6 +23693,14 @@ F:	drivers/clk/samsung/clk-acpm.c
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
2.54.0.545.g6539524ca2-goog

