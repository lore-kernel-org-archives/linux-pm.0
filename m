Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929787;
	b=WHUyYPcM2QkAGrmNKBUlP+tEdOQJREKds4PJiwRZk5J0C4CCelrmjlVdsLpMX+AQMCbT
	 SToWAGN7dIs7x5kZAgBkYR16ctqiJCrTmj7cSLh48W4SOTr2EVOIsTU8z5KxIDDzTJbFp
	 IH7PKRnWqxmFh/xV6pP0hdvW3+LvF8nNZBx68fq+uOpCT5eEZRjyIbAvsRMUhHw84qvvx
	 k3uj+cuzA2/t1DVUS2Y3CakLyBBn0QNbtZ4eGXdShWlcIxyxFF93X+sBKj7aTdaAmk8/q
	 6ZXj6Vk8V7QkxQiwM/w8lthZJleJOvB9DBeMLHydj8VjZM4PySnrq5J6gzxPnguLgqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929787;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=cX67gbdL4NBsD5wtRJWX6tn9AKHnP0oEs6J7fK8AyQY=;
	b=lBX1+gsuyHdTLJIgiyrFIH94T4hGVn/NwTbNt7pwlfIPNYJnslxs2Ed7gVkE/Lh3xCPc
	 XZWj8fZGPxd4Ce50Od01DizfdSUuDxLZ+7MWqg9C1yrpskoNFXoTJnuBjeN+mUnKb18w6
	 DHWliy2XTlpFqkR2o7l0cd6jA/3ECa792PDydBxaPgP9cB+guct1xvt9p2b3hj1kHTua1
	 Zafdx1TZTP7jFhkuT5IG58CnTvK34qXrh3XrU0n5VboE38hKDIZ2sCfSQ8jY4KSyws1G8
	 Gww9uk02FzW8FytUFzZ6GIE0X6WpYZhNPF4qwylddyvgYWrVvE6A08cXVFfiNWB04TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=fPCfQDtr;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96B2606A32F;
	Tue, 17 Nov 2026 15:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C96B2606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=fPCfQDtr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794929785;
	bh=61Fo0ozwlH84CtqoAxbyruxX47URe4+YsJnin3PAG9s=;
	h=From:Subject:Date:To:Cc:From;
	b=fPCfQDtrdB0agfCwUmJjDdNKwT6/CzxzeWm5M4lNj2y3Am6Q8+aNyw1aHAwIKReBl
	 cZnp34wZ/zrGkAyJT1l7zc6ej9MXAkkXj+M1tsOu1mDZ3mBE1FCFIBkY9fNumyvhyy
	 8KMluYRd6sMSZXqLgpm+ZJ3LXf/Xb4PWM3PFRP8D62xc2733AWY7YzKe2IBa2q9JBx
	 vQB9N+hRmhlkDZw3KFsxi3pEtsmq72CFeArVQePiGaEAPpm0wO3/ud6INAKh6PltvD
	 kISltPFyqY5Hr7vQdXegq/d+2Fnz+zBlwNijntipoGrChyzrak6Xxvo0IZ0BBL6/0M
	 XsMUUUDNA+GPw==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DD19A17E07EC;
	Tue, 17 Nov 2026 16:36:24 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 9A05448002C; Tue, 17 Nov 2026 16:36:24 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v3 0/9] PM / devfreq: rockchip-dfi: cleanups and RK3576
 support
Date: Tue, 17 Nov 2026 16:35:36 +0100
Message-Id: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-0-32ff1546b0e4@collabora.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ7CIBCF4as0s3YSoRWqVzEuEKZ2rKGEKcak6
 d3Fuvze4v0rCGUmgUuzQqY3C8+xoj004EcXH4QcqkEftVFKWcyzn/zICcPAmKf21PfoX+RiSYI
 uhn2zBqWkNOcFbWe1DaYLVp+hvqZMA3/24vX2t5T7k/zyy8C2fQGcNpj/kwAAAA==
X-Change-ID: 20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-74727d64d729
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1766;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=61Fo0ozwlH84CtqoAxbyruxX47URe4+YsJnin3PAG9s=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr8dHi5SGuV2oIuG76xxKpt6UfqWP0ROY/dQ
 VkYP71vRcLB04kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq/HR4AAoJENju1/PI
 O/qaufwP/0tzRaTjLhD4IJszDA+0rNgtCdQ9ZeWCdXjOFF8ITsYQYTRbHBo55RdYbGkIweo9aKR
 a47NVem1y8jQ149xBZha4ayOXvC8i3yAguaPm1Bp0HaY4w1453Pd99Puz2OJ60ycb3VlU4hKUOf
 msyL6Hgc9pBraqlVX3OwpN31jmVUVreN4MUXe0EUlikZBQ1Q4ZRn//ww6wFce3jAGLcL4nmPzA6
 mkqRLlp3Cv6ZY6CCCUJ68H45s+6OtjzzvvIw4CJWG00ibpVab3ZsXReEnYQA4WyJS6KsQ+Z23Rl
 v1GAN0XDdVV8wQlb/GAvit6Yd/8QEwXVCmETkPOQFg5Mlm1kscFUx5ZzGa5F/AWM/X8gHrNPmal
 5u8jx371Sr7s8RFDuATUrjTpnNc/E6YiDnao3RVJ3+TaBgQV9GyI0nPefszqgybPgQif9UF+ZlF
 zAvPZQ1mutbCIm7BRehX8NgdVxWvCKgXZ3t8nXfvTytFCuca6xdWj43LQF74g5OhgQZHxk4G5jd
 16uPLoQuUoyeIZNSLYO/YhFDMGBp/gpy1DwQ5wLvgTyRq+Jbev4qXNFvSglKNjAJzQKLoVa+p9T
 TMesJcev0QgekVV1v+6zqtDhPSa2BTbB1RdqBdCVcyat4URxRMRkXOhz3cnhFs8GBhJXlCLLQPR
 4KXsriFuNlK1nQJ/3AX8uDQ==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

This is a combination of the DFI driver patches from the following two
series to ease applying to devfreq tree. It is based on devfreq-next
and there are no other dependencies.

 * https://lore.kernel.org/linux-rockchip/20260921-rockchip-dfi-cleanup-v2-0-43ff34ac8599@collabora.com/
 * https://lore.kernel.org/linux-rockchip/20260921-b4-rockchip-dfi-rk3576-support-v2-0-04f847016321@collabora.com/

Changes since PATCHv2:
 * split out DFI driver patches from both series and merge them into a
   new one; clock controller and DT patches will be send separately.
 * rebase to devfreq-next
 * collecting Reviewed-by / Acked-by

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Nicolas Frattaroli (6):
      dt-bindings: devfreq: event: rockchip,dfi: add clocks to rk3588
      dt-bindings: devfreq: event: rockchip,dfi: add rk3576
      PM / devfreq: rockchip-dfi: move to per-variant const structs
      PM / devfreq: rockchip-dfi: add NO_INTERRUPT perf capability
      PM / devfreq: rockchip-dfi: use bulk clock APIs
      PM / devfreq: rockchip-dfi: make RK3588 use its clocks

Sebastian Reichel (3):
      PM / devfreq: rockchip-dfi: move register offsets to variant struct
      PM / devfreq: rockchip-dfi: prepare support for v4 DDRMON
      PM / devfreq: rockchip-dfi: add RK3576 support

 .../bindings/devfreq/event/rockchip,dfi.yaml       | 107 +++++++-
 drivers/devfreq/event/rockchip-dfi.c               | 289 +++++++++++++++------
 2 files changed, 304 insertions(+), 92 deletions(-)
---
base-commit: f9316c13d6f621af4f6f4a6089d3c989ffe899e6
change-id: 20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-74727d64d729

Best regards,
--  
Sebastian Reichel <sebastian.reichel@collabora.com>

