From: Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v1 05/10] dt-bindings: act8865: Update documentation about
 property system-power-controller
Date: Mon, 27 Oct 2014 16:26:50 +0000
Message-ID: <1414427215-14380-5-git-send-email-romain.perier@gmail.com>
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
 Documentation/devicetree/bindings/regulator/act8865-regulator.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
index 01a5b07..45369d8 100644
--- a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
@@ -6,8 +6,8 @@ Required properties:
 - reg: I2C slave address
 
 Optional properties:
-- poweroff-source: Telling whether or not this pmic is controlling
-  the system power. See Documentation/devicetree/bindings/power/poweroff.txt .
+- system-power-controller: Telling whether or not this pmic is controlling the
+  system power. See Documentation/devicetree/bindings/power/power-controller.txt.
 
 Any standard regulator properties can be used to configure the single regulator.
 
-- 
1.9.1
