Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2423DA5A9
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677734; cv=none; b=qbXbE91YPe+wazac65FiWwOr4p1CgfNpdqtUvRdfkUrQNZLPHVkpLOe6jrb7OG8j2MXUZGSGMHNnJ/kib0JIG4JCo1/nyvJ77+jMJIlh6aFPhuUke8DfsTRF9mVuhT+TXeB9OLOaRrAFpHgMb4zD3CYzNad3UnBxgFP89kY7nOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677734; c=relaxed/simple;
	bh=5ADyit8Ijsc5TQdkw96Oigh6pxYDNfJpvW/Ssz5MCwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YJK6+orUvdAMXh8WCSVx5xPUZbO6XC0re9QsxkSl1B9XJ9snCvNPp5uqkpe52sPHyp4VbdDRd2tUN31J70NJJoZbp/Gk8lSQcWiXueO1MFs1zBCScLje4MS13oLMjgzQR/bcqxr56hHsl20Hfp6DetmXwY9NQo1d6cLq/um/8uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=x1Xni6Bx; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="x1Xni6Bx"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843796e373so2287093f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 03:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790677721; x=1791282521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rGvPl8En9vQFk7BFZDJEBDExAfjn0FzJiGJJ7lWPWO8=;
        b=x1Xni6BxlRBytWFGhj6UBLouXwJ54DK+fWWeDFGYNYaeFK3vaOzn1H+LZecUvhcBue
         EZJGdleys2Y0PH9M4CwtAy1YjlLRuHYjv67tO7zeIA8nBbY4hasISsVYI8xMvN9XtHzc
         S5iXDUflTXCX1gP4eiZHVeNDFd2x3qfJGOuc+xm4lvlxnedw3k2OoHzl3MDv76/R56wQ
         pXT3uwVRONr7w9+eQ3WUHB80A0N/SW9v2LFSbbJb6C7Qei2DBbsgO5RySn6dyf+8poOB
         BEKOmMAr66Bbx5bjpfaOvYVqlqA6qXxSqrKQXl7dE1poqXosixVbTFCR4RSOe9rqeo4W
         yCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790677721; x=1791282521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rGvPl8En9vQFk7BFZDJEBDExAfjn0FzJiGJJ7lWPWO8=;
        b=QFzIYW6rcuERz8GFrRGfXmOYouj6PsfN7nXTftrsCXbVzcKkTZPhYcPBJBuUZXegpX
         lqQ7vbvb0ahr19+8aEGgpWQdsrdyz7AgqRaRVw8UTjwHhiOcHpVl+cCoLZEKDAjDg4C9
         hSmrjk9O6qwCND3IsLFhy2qCEREIVuJkA6HAHDp+NWfR7Z9hb7q0XJH2qOCfc1OQu+M2
         rNqZPqSuxzfInH4UN/5gYk0IIOD0yIeK5swlPFOud6Ud1Gk6SI974Tm8l6ZWyE/PVGto
         e4Qwsg133gFQl9A/fEFQSa0YRMwoQVPRXoULxAjtdgxs6nxeJkXjA2buoyl5l4zoBLxL
         pcQA==
X-Forwarded-Encrypted: i=1; AKwUvBwiWxeqN3DrqhuhxxEd4lnXI/7YYqPJBN9oGp81pek3NImxrCVwAc9HUiY6VOo08ImeRy4Tqv7RGg==@vger.kernel.org
X-Gm-Message-State: AFuF++kvVOa/2GBV3ikZk8uX/oKXR0zWpi84l/n5skzC9GNEKlJrqabW
	/dXMa+WlHsLYOh0p1U4U0G2yuCMy5gPMmuEbJsZNRXxkOHzMw48O9nwjyfUW/Yn/8JoJJ3wKdhm
	0E0bM
X-Gm-Gg: AYBFou1XShWyJdpKhKRPk0rJoD8TuMchK0bPWJXVflQaU/K3A872d3ZZAwbtF2pRjPa
	fDvCBCvGMoO+1Jv9TT0u4X0KTceMDDJOYQio7D5VQmP1mW7cXMUK9rRrqEpMAxAcmsBSDMFpNL7
	da+RQs1bNuNknFQSW6Y0asX6M7jdjbje4od08lMmnqbkeqobcTRzpSA9jJLB+c0y2nwKadbeQkw
	WVumucG7yigBsphvx8R3SoXBO4QlqUnAPvyWSZOQLBHXOTW6Twl0hdHPs/EOgyrshyO5r3lkKf4
	St4I9EzgBzGCD7mJyAi4YlL60+9ScLMYQ+fnst8qKByUlb73tZWj7Yfcdc4xKg3U3o7Mi6pQLyA
	xyWbXryr83WsPs8Cffc7hbRlN4d3rXoaS85yUlvXc0AUnUa7gnpys7d0o4bQi3TLM1OlLb3VtF6
	tX4AVqiFk8iZ5aE++wzE5jFpaUZQhnMaw3clAWkWO50RwpnviDKmMOB+dwrkQ7xdW+IwDlg6uLp
	DJhpWVPWGmm3O7S/w==
X-Received: by 2002:a05:600c:4fc9:b0:4a0:37d:9e21 with SMTP id 5b1f17b1804b1-4a0037da3c1mr96548565e9.29.1790677721312;
        Tue, 29 Sep 2026 03:28:41 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfb479asm66579305e9.15.2026.09.29.03.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:28:41 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 29 Sep 2026 14:28:20 +0400
Subject: [PATCH v2 3/5] power: reset: syscon-reboot-mode: enable supplies
 for the next stage
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-b4-rk3576-reboot-mode-v2-3-5a34ca72065a@flipper.net>
References: <20260929-b4-rk3576-reboot-mode-v2-0-5a34ca72065a@flipper.net>
In-Reply-To: <20260929-b4-rk3576-reboot-mode-v2-0-5a34ca72065a@flipper.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Alexey Charkov <alchark@flipper.net>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4101; i=alchark@flipper.net;
 h=from:subject:message-id; bh=5ADyit8Ijsc5TQdkw96Oigh6pxYDNfJpvW/Ssz5MCwE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTtnnRR7eaco/P+HJ1ifNh4tcP6XSrCzSVz2xfYiq+2U
 l2f4PR7QcdEFgYxLgZLMUWWud+W2E414pu1y8PjK8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ikY6xjxMDFKQBTvTGRkeGoj11uZuRb4QuXDK9NCzNw8bj+45Sxrf3X7VeNbjMsWfmM4b+3ztk
 vQSceHTN9e2i2duqkxByDpXMqCv/JGJrtmf74iA47AA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Requesting a boot mode on some SoCs such as the Rockchip RK3576 hands the
request to the boot ROM in a register that a full reset would clear, so
any reset that carries it has to leave the PMIC untouched. This means that
the regulators stay in whichever power state the running OS left them,
which may be unsuitable for the early boot code. E.g. on RK3576 the DDR
initialization blob runs on the way back and accesses registers which
Linux normally leaves powered down, resulting in an unrecoverable abort.

Get every supply named in the reboot mode node and enable it when a mode
is written, which is when a mode is being requested. The supplies are
deliberately left enabled afterwards: the system is on its way down, and
what runs next cannot turn them on.

Signed-off-by: Alexey Charkov <alchark@flipper.net>

------

Current implementation of of_regulator_bulk_get_all() never writes the
supply names, instead leaving them uninitialized, while the regulator
core uses the field in error paths to provide meaningful error messages
to the user. This has been highlighted by Sashiko on v1, and is addressed
separately in [1]

[1] https://lore.kernel.org/all/20260929-regulator-get-all-v1-1-e887c66a47f1@flipper.net/
---
 drivers/power/reset/syscon-reboot-mode.c | 41 ++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
index e0772c9f70f7..5ef882d81816 100644
--- a/drivers/power/reset/syscon-reboot-mode.c
+++ b/drivers/power/reset/syscon-reboot-mode.c
@@ -10,6 +10,8 @@
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 #include <linux/mfd/syscon.h>
 #include <linux/reboot-mode.h>
 
@@ -18,6 +20,8 @@ struct syscon_reboot_mode {
 	struct reboot_mode_driver reboot;
 	u32 offset;
 	u32 mask;
+	struct regulator_bulk_data *supplies;
+	int num_supplies;
 };
 
 static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot,
@@ -28,6 +32,20 @@ static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot,
 
 	syscon_rbm = container_of(reboot, struct syscon_reboot_mode, reboot);
 
+	/*
+	 * Whatever acts on the mode (e.g. boot ROM) runs before the operating
+	 * system, and may need supplies that the running system had powered
+	 * down. Enable them here, and deliberately leave them enabled: the
+	 * system is on its way down, and what runs next may not know how to
+	 * turn them on.
+	 */
+	if (syscon_rbm->num_supplies) {
+		ret = regulator_bulk_enable(syscon_rbm->num_supplies,
+					    syscon_rbm->supplies);
+		if (ret < 0)
+			dev_err(reboot->dev, "enabling reboot mode supplies failed\n");
+	}
+
 	ret = regmap_update_bits(syscon_rbm->map, syscon_rbm->offset,
 				 syscon_rbm->mask, magic);
 	if (ret < 0)
@@ -36,6 +54,14 @@ static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot,
 	return ret;
 }
 
+static void syscon_reboot_mode_put_supplies(void *data)
+{
+	struct syscon_reboot_mode *syscon_rbm = data;
+
+	regulator_bulk_free(syscon_rbm->num_supplies, syscon_rbm->supplies);
+	kfree(syscon_rbm->supplies);
+}
+
 static int syscon_reboot_mode_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -59,6 +85,21 @@ static int syscon_reboot_mode_probe(struct platform_device *pdev)
 
 	of_property_read_u32(pdev->dev.of_node, "mask", &syscon_rbm->mask);
 
+	ret = of_regulator_bulk_get_all(&pdev->dev, pdev->dev.of_node,
+					&syscon_rbm->supplies);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "can't get reboot mode supplies\n");
+
+	syscon_rbm->num_supplies = ret;
+	if (syscon_rbm->num_supplies) {
+		ret = devm_add_action_or_reset(&pdev->dev,
+					       syscon_reboot_mode_put_supplies,
+					       syscon_rbm);
+		if (ret)
+			return ret;
+	}
+
 	ret = devm_reboot_mode_register(&pdev->dev, &syscon_rbm->reboot);
 	if (ret)
 		dev_err(&pdev->dev, "can't register reboot mode\n");

-- 
2.55.0

