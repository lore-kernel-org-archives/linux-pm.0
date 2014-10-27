From: Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v1 03/10] regulator: act8865: Use
 of_is_system_power_controller helper function
Date: Mon, 27 Oct 2014 16:26:48 +0000
Message-ID: <1414427215-14380-3-git-send-email-romain.perier@gmail.com>
References: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: heiko@sntech.de
Cc: mark.rutland@arm.com, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, lee.jones@linaro.org, robh@kernel.org, linux@arm.linux.org.uk, swarren@wwwdotorg.org, grant.likely@linaro.org, linux@roeck-us.net, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, johan@kernel.org, robh+dt@kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, lgirdwood@gmail.com, balbi@ti.com, broonie@kernel.org, galak@codeaurora.org, gnurou@gmail.com
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 drivers/regulator/act8865-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index 76301ed..435aba1 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -365,7 +365,7 @@ static int act8865_pmic_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	if (of_system_has_poweroff_source(dev->of_node)) {
+	if (of_is_system_power_controller(dev->of_node)) {
 		if (!pm_power_off) {
 			act8865_i2c_client = client;
 			act8865->off_reg = off_reg;
-- 
1.9.1
