Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B594137B2;
	Mon, 14 Sep 2026 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386945; cv=none; b=awqYTyt6ck0F8n+fwEBk+7VGmOmieoTX24V/U93AvwNPqPjihDocIQrVBwY9KHQ+2N67qvi7AKtm2Xcm86i15uN3/9SUW/cwdiUxm+oAlrmR4qNpqBqFs25MyWZjOxmxcGp78rievKRUAkucYbpd9IAaPE8Eo4DDFQiWTGPBXVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386945; c=relaxed/simple;
	bh=uqdZBlXEg6O3wtUIgzzS0Hij3kvHGis+c53KB/J+xu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HLp78VpcMqKQygsYU+Fgbu9zFPvBFi99Pvectn7BiaO9s3kEzTvUvuEkUmnhJqtzoHIjhuUzTLTnh4UjmAGuIxGgmjMb5EPDcnkEHmYZJp4XyvFTXoPpVpb/xZWEOGGvr/kLFwYLiRF7Gzf68rIS9QcjYis/s1RCx7RxjHtQoUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1Vy7d/i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1Vy7d/i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DB21F00893;
	Mon, 14 Sep 2026 11:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789386944;
	bh=IS4gSGNy2dOMCPRfKomn+g7CCNwYcpkMhh/6pChyyuw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=A1Vy7d/iJJ+kNRspVOrEOonCAU95nW9YRFknWcmBqlZuvufeRu22EVMz2PUkAvpvU
	 goVuRes5pvTEVX6kSiSo1KmNEQCLhTm3DvbmSHTK5h+n4gsvOE/nCwuSbFtqqfdhJ0
	 pyOP7nxKrn1xcpn7I0AJ7WA4HNwSyRvIb1kz6JXQjfHOPKA7ODso+WeawY+9pjx6UA
	 3qkP0/nJ9WKAYOjc/kk5a/85D6Oin+5BA1sg197TCkUKda6d13ZJELgCwkAcIDcyxj
	 P0zd+G9cvAO1sIH5ua4H/7KagDTOscR6RdGws9jkz22oLGDxLCZgQBfNLC5Vi/F0wk
	 z/rcxFsRzf2Yg==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 13:54:44 +0200
Subject: [PATCH v2 16/20] misc: sram: Enable runtime PM
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ux500-power-domains-v7-1-v2-16-9d0c17e1f816@kernel.org>
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

Enable runtime PM for generic SRAM devices after probe has initialized
the SRAM mappings and partitions.

This lets SRAM devices with attached power domains be managed through
runtime PM references from their consumers.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/misc/sram.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index c8990e83a65a..7f19dca7b818 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/mfd/syscon.h>
@@ -425,6 +426,10 @@ static int sram_probe(struct platform_device *pdev)
 			goto err_free_partitions;
 	}
 
+	ret = devm_pm_runtime_set_active_enabled(&pdev->dev);
+	if (ret)
+		goto err_free_partitions;
+
 	if (sram->pool)
 		dev_dbg(sram->dev, "SRAM pool: %zu KiB @ 0x%p\n",
 			gen_pool_size(sram->pool) / 1024, sram->virt_base);

-- 
2.55.0

