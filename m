From: Priit Laes <plaes@plaes.org>
Subject: [PATCH 03/14] regulator: core: enable power when setting up constraints
Date: Mon, 26 Nov 2018 17:27:44 +0200
Message-ID: <1e2f8f5a5eeebd40431675675569012cb8e17473.1543245984.git-series.plaes@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Priit Laes <plaes@plaes.org>, Olliver Schinagl <oliver@schinagl.nl>
List-Id: linux-pm@vger.kernel.org

From: Olliver Schinagl <oliver@schinagl.nl>

When a regulator is marked as always on, it is enabled early on, when
checking and setting up constraints. It makes the assumption that the
bootloader properly initialized the regulator, and just in case enables
the regulator anyway.

Some constraints however currently get missed, such as the soft-start
and ramp-delay. This causes the regulator to be enabled, without the
soft-start and ramp-delay being applied, which in turn can cause
high-currents or other start-up problems.

By moving the always-enabled constraints later in the constraints check,
we can at least ensure all constraints for the regulator are followed.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/regulator/core.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2c66b52..6e14610 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1158,17 +1158,6 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		}
 	}
 
-	/* If the constraints say the regulator should be on at this point
-	 * and we have control then make sure it is enabled.
-	 */
-	if (rdev->constraints->always_on || rdev->constraints->boot_on) {
-		ret = _regulator_do_enable(rdev);
-		if (ret < 0 && ret != -EINVAL) {
-			rdev_err(rdev, "failed to enable\n");
-			return ret;
-		}
-	}
-
 	if ((rdev->constraints->ramp_delay || rdev->constraints->ramp_disable)
 		&& ops->set_ramp_delay) {
 		ret = ops->set_ramp_delay(rdev, rdev->constraints->ramp_delay);
@@ -1214,6 +1203,17 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		}
 	}
 
+	/* If the constraints say the regulator should be on at this point
+	 * and we have control then make sure it is enabled.
+	 */
+	if (rdev->constraints->always_on || rdev->constraints->boot_on) {
+		ret = _regulator_do_enable(rdev);
+		if (ret < 0 && ret != -EINVAL) {
+			rdev_err(rdev, "failed to enable\n");
+			return ret;
+		}
+	}
+
 	print_constraints(rdev);
 	return 0;
 }
-- 
git-series 0.9.1
