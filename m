Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE501A5B9E
	for <linux-pm@vger.kernel.org>; Sat, 11 Apr 2026 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775934200; cv=none; b=R3Q7xuZ6SK/hKXZ6AIzldVRUe/+ytXloAwKo/PoTJOcPsq5km14Cd3xWzzw7yvWVHzH5VYOpIuNtoTK1dzX9Pu/DvmD7TRYvq0D6KOObOUa7HGFLdcBXsGsxwjEeKq3qir8fSOvYzttfHkoYfiGTY8QCdx7px2/Oqeh22Nq3URs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775934200; c=relaxed/simple;
	bh=NII7TnwJKw9YmpDBsJARaImgJVJgLGoeincDCzPqxIg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GLcmbMFaN0W9mxdkY5dqzyN8rRTnHX0AQq2BHos8tBid7GY/HWuvPkAXhsHcu9xzLY5Z74GAuTwnbX6XSfHeYJjUslvvdEpBSV8zkMS9jf+/Y+9+txkwXS8XoPQ1Vl7EUcjG3a2DiROqlojDCmeba5bgtS5Z1BvWMpyvvR/V1WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0q2fPan; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0q2fPan"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f2766905fso164388b3a.3
        for <linux-pm@vger.kernel.org>; Sat, 11 Apr 2026 12:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775934198; x=1776538998; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cHQbtwOxcmIRSK/UYtPX+LYU+lWy7jhzQ3NwSZU5rqA=;
        b=J0q2fPan0m9RZGLopS0+PDrsidaVjIu4IhJypVWYLT9NyXHFd/PG0beylZzoUWmTZ/
         Zx7CUzsw2NWnTved9On7rRTuB4LyFh2d9XTLp/OY3QusE3u/bcSPD8Qq43CUJNxxoNN9
         9N3jUSmZxKGG6kYS7pUrfAUJi5dfBcZo3J//Qy4/kPpUHf4N3CpoO7w4WrNh1wFcklw0
         i5Vx52NId4IAdTS8PMhyDsVwWHxIMqU0T8joS3WGjfeg8pizy9nLywqnuUrQ3KCGHczG
         UW1ePdYxFOGviyS7CzuqHY6Z3sbY4r+Qposh4oyaxM1wuuPl79AXOVsQinkOz4rPQ0hR
         MyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775934198; x=1776538998;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHQbtwOxcmIRSK/UYtPX+LYU+lWy7jhzQ3NwSZU5rqA=;
        b=GUrAHv4J/Khv/3D59QlDRqSYC1BDL+lZymWyK/cA5b3GRGb4zkd5HPnbotGY5r99vY
         srjElL/cD56Fke91SbO2hdc+xb4omWLSbaDDN5RlrTjeAgz7d7GH2ve2+kpQS2Eghx0C
         oSyvfFgFzg2irSOW83wtGggHuyYQRn/QZq0nE5UdOlDuEM9Hx62nME/uFEGvrGC/vFca
         7JLcIMoitHUe4VrWKThox4Ks5mpWoPf6n6rzY3bc5t1DBQtdYZAJtiPYrmpWStSI//sE
         BCrh47PrvLexckA8mILx7y9UhRKkb61K3MoJls0PJZvw27WtFw5Wv1qWiraemIIpLFYf
         oKXQ==
X-Gm-Message-State: AOJu0Yxc8DGjkoI5skvZbMQ1+WQo6okxWv7kpPZFsFj3N3bD67KmYpkH
	pW+jBhDW9Tnvmg9pWIfDswf0HcI977PuO/hPW5lVEBO1PCHp+kBwLKJm
X-Gm-Gg: AeBDievRlTuqKGreYeypbVnJmfgB0KQw2Zi8th7D8FaGmQ11ss0qEk4PVDpiw2DhkKk
	MLHCE4myTeZhxlXVrxrXctaRGHFE3vyVYJ3nEHOiNsCIkl0kwlsVhTJkqAxDzjhIzHs8v6tpnFp
	OnvKkGasSecl4zPx9ImLeRImXSWrsNKMUrToINQDLm9mf3CCdjDI1IuKtfhcrypsYsutw8ZYkph
	dwXbzrbhRnL6+mOTax4u5G9I5h3mIMfvfIwRxveTjAQTwADJBpXE4iu23cesiIhyUlcvoyV5hu8
	EIKrCVblGRLKqSIxuuSPGjQ0jW+C2+I2FAs5odKIhroWwz6DHhpqMVbq2z2XgzVJXtdEICFVUda
	A6PZWE4S+uf3X1Ng0pBMdZ7PtQ5bMNmu6plv3gieHsetVkKKSB6/KPjVBYzIofWgjW+CvVxzWdR
	tQPvq9b5hqtDaZNLZwinLPNygyq5J8MCcsy2G2u/Yl4Ndz7VvGsZGGF5WxgFL1zTivXsQ6kW17W
	Sos7TZG/xi3HpM4VCJ/
X-Received: by 2002:a05:6a00:4511:b0:82c:d7c4:4c69 with SMTP id d2e1a72fcca58-82f0c25e146mr6937134b3a.3.1775934198466;
        Sat, 11 Apr 2026 12:03:18 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c338dafsm7058962b3a.17.2026.04.11.12.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 12:03:18 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Subject: [PATCH 0/2] thermal/drivers/imx: two fixes
Date: Sun, 12 Apr 2026 03:03:02 +0800
Message-Id: <20260412-imx-v1-0-cc3b45d63811@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOaa2mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0ND3czcCt0kAyMjc0vD1ETDJEsloMqCotS0zAqwKdGxtbUAiHbDg1U
 AAAA=
X-Change-ID: 20260411-imx-b022791ea1b9
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775934187; l=466;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=NII7TnwJKw9YmpDBsJARaImgJVJgLGoeincDCzPqxIg=;
 b=oOk6zMzS2U2kzS+HMpp1a5HcEb8Vdhy4v8qOt3ufeM4ZWYMHoTsGqtnpnobEicfRXOpK9Rw9s
 BWfCxPCuXf+AiGyK3+8Ttl8xIe6Pr5IcO+NKkx4+Re8Ahgs/MxZAn+n
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Felix Gu (2):
      thermal/drivers/imx: Fix thermal zone leak on probe error path
      thermal/drivers/imxl:Fix runtime PM handling on early returns

 drivers/thermal/imx_thermal.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)
---
base-commit: 66672af7a095d89f082c5327f3b15bc2f93d558e
change-id: 20260411-imx-b022791ea1b9

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

