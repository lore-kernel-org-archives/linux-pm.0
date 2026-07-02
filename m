Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF878492538
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985737; cv=none; b=tpEQENqU+mLxkz15zTkLFRq8D/IZXSUSoBZ5oRaM0iIHkkom3Xm/kI5j9V0MoGF6gW7QxMVyvX7pGMwF0/mJy73ZrgVduf0r8h8ms2NcvuuZyuPwibpQL0NyPxl7HSTVN66ZnP45fucB8ZUxXwo7kb97DzOPYdi7iVJaabE9at4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985737; c=relaxed/simple;
	bh=pkCjxUxbYUpW9jv+c4F6tj4b65UeVhjHS7fRXUcH0zM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bFlcWjejRgFSDzNc0so5hNfr1HxW2Ow6LhaO1I3ESVUYJpvwHlZyslaKkcHjdhZINUyC/uknd6F0yCWDyvaU0jr5Hk19u+APWcHWHzvBwS7HLca1IBs2bdFE5nDVR5sBaveuN2LRqiaqvBqs+xDcKCwYFmjuYJWiQb5KugYJOvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrLPXw+2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrLPXw+2"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso8882645e9.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 02:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782985734; x=1783590534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uM2wzMtkmq9BHHKzQp0hMw4qox0NY1UcxIuI00AEiXA=;
        b=FrLPXw+2iA4eLaYfYyI3CQdqSLdRH0RUsNzQzm9pSVsgmnYXeJtQaomYowdXaG031m
         WrY8KO7mJMK6Oa2jhOMyUW0TzhfuMFk3k6g4VLqreLLkRYv50RmUai4/l6cNllURta20
         6y5j2VCerujl54acjG0IWGD8JnwRCd6bkiEa8TCPeeSdOpmvujVjJ/otYHYu0WU8rLfX
         bIrgD139sTgyfYN/JqDzyKVKAGslZrGpPk92x3YiQzV16wTn18RtE8AMLhdpKVKbjzeE
         Mg6B+gL9OcjT1FpAAqwCNggM1x/AAtPTmV9T8jN6NHMj1Ya06AWTZstURXoPcJnZxYKs
         RWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985734; x=1783590534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uM2wzMtkmq9BHHKzQp0hMw4qox0NY1UcxIuI00AEiXA=;
        b=EM1IPg+jujR73157/5I3I94UsG3DtWEIU3ZxWd+Ts70ilF4FJwDeGEZR/fuHoM6R2z
         6rz0hOXVpXI9JrnvToC1LQ4T8l5F+A8jbwt05y1K/pGCBCrCvmeMc3043ITht5uTqCji
         7FFZcVZG5T6It3gCs+ftys+3GVuVE21XVxTFY5k83BLmXgBMOH7vgqKrteuN6CJjb9/Q
         6sGwZa5n7QqzCOhSxDOxCiqzQE8W9jszdYk9WBKNXT7SH1ljrLlQpxIZybS62uLVXwdO
         x4gWNA4R1lftsd5888hDAWQrhYBgldBUd89vS96/ozPy5QZohYiZtJ2UnuBYlXHX6GSL
         RCrQ==
X-Forwarded-Encrypted: i=1; AFNElJ9m4GAfpkIX3IEy7k5XWQpo1bSS1vxT5YntHKQxxDPpbjLa7yyYkS+VIthcp2LDIOgNmxW8R+qEEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEQgF7FERAInEa8iAul/tDrOVkego1AQMHdwzdhVzXu9peVuQ2
	JfAmu5Yecf6BY6B3tv6MYF9jPaybLE0gq+I6PLJqIMkCMB92noAAd3yb
X-Gm-Gg: AfdE7cnqt/mQIBDAdKxgid0Jop6YJlir4TK3PmYUXTFCkfVE6HedmJvKSfDwUxdal1T
	UISpPiWu2N5gDtJKo/MFFEKUej83cEindB1idJTZ4ddbxYJaph96DFcl9r5K7t13HIvn4G5IKuR
	uYfsvJ6b2zHdx5UC3igN3AK6Jf37o2Mj7iyBCohSMR+0HsYfO3fRZkq+wtw7s7BZAmBdXLB0rKf
	riL7gCcca/x1iQU6+LtLoiHx+mKrtkpWbVu8Zn7GNS6v6IHylpBQo55Q1C8D3kpO9t2hTkcsu3h
	ERxiR5rUS3yLjdka7v2YZ7SjRZ2XDlsElDMB6JY2uZyN+PsZU4RgUeZjC7GCaiLsCnfH32R43T+
	fD2mdJfrinQRijk3x4KYHthjQ6Dp0+xUDEhdXUOKsiz2mBcPQnbkxwxbD83RgMxe4H4Dzujrij7
	OfroQjHWkHSk7UaDBbE7PVPlZCYa/2wIVmgW3V3JaEJcHBguVmrTgKJuF0YCxQ6Tt/W3+H+y/sG
	2mL7Q==
X-Received: by 2002:a05:600c:8117:b0:490:688b:f9f8 with SMTP id 5b1f17b1804b1-493c2b99aafmr72214935e9.27.1782985734293;
        Thu, 02 Jul 2026 02:48:54 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-52-250-217.retail.telecomitalia.it. [79.52.250.217])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-477dbe617b1sm7381364f8f.16.2026.07.02.02.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:48:53 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v6 0/7] thermal/drivers: airoha: Add support for AN7583
Date: Thu,  2 Jul 2026 11:48:28 +0200
Message-ID: <20260702094846.17325-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series implement all the required changes to
support Airoha AN7583 Thermal Sensor.

The SoC dropped the Monitor subsystem and only provide
temperature reading. Some generalization was required
to at least save the common code with also the help of
reg field API.

Changes v6:
- Add review tag to DT patch
- Add review tag to fix patch
- Rebase on top of linux-next
Changes v5:
- Fix alpabetical order in Documentation patch
- Address suggested change by AI Bot
Changes v4:
- Rebase on top of linux-next
Changes v3:
- Property use chip-scu for thermal sensor
Changes v2:
- Update DT schema patch to implement dedicated schema

Christian Marangi (7):
  thermal/drivers: airoha: fix copy paste error on clamp_t low temp
  thermal/drivers: airoha: fix copy paste error for sen internal
  thermal/drivers: airoha: Convert to regmap API
  thermal/drivers: airoha: Generalize probe function
  thermal/drivers: airoha: Generalize get_thermal_ADC and set_mux
    function
  dt-bindings: arm: airoha: Add the chip-scu node for AN7583 SoC
  thermal/drivers: airoha: Add support for AN7583 Thermal Sensor

 .../bindings/arm/airoha,en7581-chip-scu.yaml  |  14 +
 drivers/thermal/airoha_thermal.c              | 380 +++++++++++++++---
 2 files changed, 327 insertions(+), 67 deletions(-)

-- 
2.53.0

