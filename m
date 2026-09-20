Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CAE486620;
	Sun, 20 Sep 2026 22:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789944557; cv=none; b=dDwiTKYcUHIDJaAhnCIPC5zRIp1Vy4u0YpA3X3COkZwx4SE5lrIWlu/v416VyGvWM7c7Hxdt+8QLu4dmC6G+ATGgrY1ogjS9oiuMDHZtmwa1AqdUuPH4u+UGFUeGaV5h0Jp2N8NMGNU/eCT6EBFZuz2UYdL8P5EFP2h+p9eCjzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789944557; c=relaxed/simple;
	bh=2zy8E9seA8b9/eRE8pkj68D3E/tDTltdubnRquQT0y8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iKzC13Y82D7fQhF6ZlcgnCBEFZVVZomYZJKCjoF2bzsg8G6gwsj0EQhSapwLOoK5mCbIQgjt9Im01e4KqjCcfIGhmFIYqkCpNHEZo8M6/i7WizIIgkb3uomKjkPpYZFpGytQw6xX2B4wqxuEFCegOFB9m6SLRD2Kqst4qkjrNXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahTYXpCH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahTYXpCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DC91F000FF;
	Sun, 20 Sep 2026 22:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789944555;
	bh=6VNHUz/mKqYKFo+tObu04b8nZC1YCccRQBtdvelA5jw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ahTYXpCHzq9SF9NDyYq1tsKIIfy9DP0rOvz7+KkWkm6V/LPigIE9hYwfqvyda6iIw
	 t9r40tnxT2IA9OR/NhdvtquBSdWLTgGFSSoJqa8TyQ9FFZot/iuYD2wKUnPhaZwI6A
	 BqU3iHvAw9p3qjA5n8+4VFff5ua4peMer8GKdfUeUAsi5koe63Ib6sV8YjDn5BLLUp
	 8SHFnupRN//u8pobpKj3YRB7E/1WCZ1caDTm+htDsIL1c5uG26I/L97IFVLt3eitLx
	 Kb4B9uC6y3QdFPiqzrx/HOvTFEki+YPvOSHPbmcsUOTM1wuBBzc3rh/mE+Nxo9kV0t
	 AwSStqRrcd75w==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 21 Sep 2026 00:48:20 +0200
Subject: [PATCH v3 14/18] misc: sram: Enable runtime PM
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ux500-power-domains-v7-1-v3-14-9352be6b86b1@kernel.org>
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
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.3

Enable runtime PM for generic SRAM devices after probe has initialized
the SRAM mappings and partitions.

This lets SRAM devices with attached power domains be managed through
runtime PM references from their consumers.

Assisted-by: LLM
Reviewed-by: Frank Li <Frank.Li@nxp.com>
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

