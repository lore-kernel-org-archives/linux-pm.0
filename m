Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279488;
	b=AcGDA4rrWifFmuYnfEqXsZs7yLMhLnQx8Ot5RYfiXAl69kL4j6VX1QGyjP1F0qPgcYFg
	 lzRS/QbijrMa/8cg8o9zo/x2ACxarQ+LcxvHv59qbtzColrg2tvhOQFNQciVPcprxSek7
	 6W0jzBKEY31h4Y+aBtiYAaAjQ+zcOg8xVYEyRQUmwXLgV1Qs7kE3vP+T6C8deqIO1aOsF
	 LRgB5MXYgQ29ocd4LMinwfneznZLPsUApfKJ84pGhqmwXjJXYD+ePgewXzEvoyZFAOptY
	 t7YOxocQ8XKXkv+vOUBXle5WKd22S1HVspHlwSvsdMFIX1PL++Xv4Uicv7DkWv6uCfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279488;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=NkyoRqoBmfBgCM55UmNfodUHU+sKzojvgE1fX4kVPRw=;
	b=oND5mysebfusWbOUaI6GPyHJvgmTp2uwylC55RVcTp7IfQzCjWOfBlm2LxtI1paSR5vr
	 /kvcVHB7hmqX0wilQqmTEN7YX42C9UDqZkQWyYIy2Vl2Mo82HmeIqXnPh32DsAtVaxBkc
	 qxpYAKgkYrZJc2tE8PHhdCA0WJS35Qfcp6USmypalFbye4iZxWleUIFiGAPZYoTIoDTDw
	 whF/PYXjz+Y0Tj8xu3mtTrBUInVrnYrGI7r2Hmw7wAdfr8FzbC6g27Ys9eklOONY7vhl7
	 yBHv7zAy5KfUNG848JFiLxIAWi3mbDw45NYr0esK3OfDAVrU3/jXnI3B0z4NIdyM6Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EE3606A31A;
	Thu, 29 Oct 2026 13:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A60A1F031E7;
	Thu, 29 Oct 2026 13:11:24 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Biju Das <biju.das.au@gmail.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/9] can: rcar_canfd: Add Runtime PM support
Date: Thu, 29 Oct 2026 14:11:03 +0100
Message-ID: <011735aa3a7568229db473a7ff92681176338db0.1793278754.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793278754.git.geert+renesas@glider.be>
References: <cover.1793278754.git.geert+renesas@glider.be>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On R-Car X5H, the CAN-FD module is part of a power domain.  This means
Runtime PM must be used to make sure the domain is powered when needed.
The CAN-FD module is part of a Clock Domain on all supported SoCs.
Hence remove explicit management of the functional clock, as this is
handled automatically by Runtime PM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/can/rcar/rcar_canfd.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 4d805df5ff9e8933..74d9ffd2790587b9 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -37,6 +37,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/types.h>
 
@@ -2004,9 +2005,9 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
 	int err;
 
 	/* Enable peripheral clock for register access */
-	err = clk_prepare_enable(gpriv->clkp);
+	err = pm_runtime_resume_and_get(dev);
 	if (err) {
-		dev_err(dev, "failed to enable peripheral clock: %pe\n",
+		dev_err(dev, "pm_runtime_resume_and_get() failed: %pe\n",
 			ERR_PTR(err));
 		return err;
 	}
@@ -2016,7 +2017,7 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
 	if (err) {
 		dev_err(dev,
 			"failed to enable RAM clock, error %d\n", err);
-		goto fail_clk;
+		goto fail_rpm;
 	}
 
 	err = reset_control_reset(gpriv->rstc1);
@@ -2074,8 +2075,8 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
 	reset_control_assert(gpriv->rstc1);
 fail_ram_clk:
 	clk_disable_unprepare(gpriv->clk_ram);
-fail_clk:
-	clk_disable_unprepare(gpriv->clkp);
+fail_rpm:
+	pm_runtime_put(dev);
 	return err;
 }
 
@@ -2093,7 +2094,7 @@ static void rcar_canfd_global_deinit(struct rcar_canfd_global *gpriv, bool full)
 	reset_control_assert(gpriv->rstc2);
 	reset_control_assert(gpriv->rstc1);
 	clk_disable_unprepare(gpriv->clk_ram);
-	clk_disable_unprepare(gpriv->clkp);
+	pm_runtime_put(&gpriv->pdev->dev);
 }
 
 static int rcar_canfd_probe(struct platform_device *pdev)
@@ -2254,6 +2255,10 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		}
 	}
 
+	err = devm_pm_runtime_enable(dev);
+	if (err)
+		goto fail_dev;
+
 	err = rcar_canfd_global_init(gpriv);
 	if (err)
 		goto fail_mode;
-- 
2.43.0

