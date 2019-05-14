From: "kernelci.org bot" <bot@kernelci.org>
Subject: next/master boot bisection: next-20190514 on rk3288-veyron-jaq
Date: Tue, 14 May 2019 09:06:35 -0700 (PDT)
Message-ID: <5cdae78b.1c69fb81.a32a9.870f@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com, mgalka@collabora.com, broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com, enric.balletbo@collabora.com, Elaine Zhang <zhangqing@rock-chips.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

next/master boot bisection: next-20190514 on rk3288-veyron-jaq

Summary:
  Start:      0a13f187b16a Add linux-next specific files for 20190514
  Details:    https://kernelci.org/boot/id/5cda7f2259b514876d7a3628
  Plain log:  https://storage.kernelci.org//next/master/next-20190514/arm/m=
ulti_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy/gcc-8/lab-collabora/bo=
ot-rk3288-veyron-jaq.txt
  HTML log:   https://storage.kernelci.org//next/master/next-20190514/arm/m=
ulti_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy/gcc-8/lab-collabora/bo=
ot-rk3288-veyron-jaq.html
  Result:     691d4947face thermal: rockchip: fix up the tsadc pinctrl sett=
ing error

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       next
  URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git
  Branch:     master
  Target:     rk3288-veyron-jaq
  CPU arch:   arm
  Lab:        lab-collabora
  Compiler:   gcc-8
  Config:     multi_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 691d4947faceb8bd841900049e07c81c95ca4b0d
Author: Elaine Zhang <zhangqing@rock-chips.com>
Date:   Tue Apr 30 18:09:44 2019 +0800

    thermal: rockchip: fix up the tsadc pinctrl setting error
    =

    Explicitly use the pinctrl to set/unset the right mode
    instead of relying on the pinctrl init mode.
    And it requires setting the tshut polarity before select pinctrl.
    =

    When the temperature sensor mode is set to 0, it will automatically
    reset the board via the Clock-Reset-Unit (CRU) if the over temperature
    threshold is reached. However, when the pinctrl initializes, it does a
    transition to "otp_out" which may lead the SoC restart all the time.
    =

    "otp_out" IO may be connected to the RESET circuit on the hardware.
    If the IO is in the wrong state, it will trigger RESET.
    (similar to the effect of pressing the RESET button)
    which will cause the soc to restart all the time.
    =

    Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
    Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
    Signed-off-by: Eduardo Valentin <edubezval@gmail.com>

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_=
thermal.c
index 9c7643d62ed7..6dc7fc516abf 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -172,6 +172,9 @@ struct rockchip_thermal_data {
 	int tshut_temp;
 	enum tshut_mode tshut_mode;
 	enum tshut_polarity tshut_polarity;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *gpio_state;
+	struct pinctrl_state *otp_state;
 };
 =

 /**
@@ -1242,6 +1245,8 @@ static int rockchip_thermal_probe(struct platform_dev=
ice *pdev)
 		return error;
 	}
 =

+	thermal->chip->control(thermal->regs, false);
+
 	error =3D clk_prepare_enable(thermal->clk);
 	if (error) {
 		dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
@@ -1267,6 +1272,30 @@ static int rockchip_thermal_probe(struct platform_de=
vice *pdev)
 	thermal->chip->initialize(thermal->grf, thermal->regs,
 				  thermal->tshut_polarity);
 =

+	if (thermal->tshut_mode =3D=3D TSHUT_MODE_GPIO) {
+		thermal->pinctrl =3D devm_pinctrl_get(&pdev->dev);
+		if (IS_ERR(thermal->pinctrl)) {
+			dev_err(&pdev->dev, "failed to find thermal pinctrl\n");
+			return PTR_ERR(thermal->pinctrl);
+		}
+
+		thermal->gpio_state =3D pinctrl_lookup_state(thermal->pinctrl,
+							   "gpio");
+		if (IS_ERR_OR_NULL(thermal->gpio_state)) {
+			dev_err(&pdev->dev, "failed to find thermal gpio state\n");
+			return -EINVAL;
+		}
+
+		thermal->otp_state =3D pinctrl_lookup_state(thermal->pinctrl,
+							  "otpout");
+		if (IS_ERR_OR_NULL(thermal->otp_state)) {
+			dev_err(&pdev->dev, "failed to find thermal otpout state\n");
+			return -EINVAL;
+		}
+
+		pinctrl_select_state(thermal->pinctrl, thermal->otp_state);
+	}
+
 	for (i =3D 0; i < thermal->chip->chn_num; i++) {
 		error =3D rockchip_thermal_register_sensor(pdev, thermal,
 						&thermal->sensors[i],
@@ -1337,8 +1366,8 @@ static int __maybe_unused rockchip_thermal_suspend(st=
ruct device *dev)
 =

 	clk_disable(thermal->pclk);
 	clk_disable(thermal->clk);
-
-	pinctrl_pm_select_sleep_state(dev);
+	if (thermal->tshut_mode =3D=3D TSHUT_MODE_GPIO)
+		pinctrl_select_state(thermal->pinctrl, thermal->gpio_state);
 =

 	return 0;
 }
@@ -1383,7 +1412,8 @@ static int __maybe_unused rockchip_thermal_resume(str=
uct device *dev)
 	for (i =3D 0; i < thermal->chip->chn_num; i++)
 		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
 =

-	pinctrl_pm_select_default_state(dev);
+	if (thermal->tshut_mode =3D=3D TSHUT_MODE_GPIO)
+		pinctrl_select_state(thermal->pinctrl, thermal->otp_state);
 =

 	return 0;
 }
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [63863ee8e2f6f6ae47be3dff4af2f2806f5ca2dd] Merge tag 'gcc-plugins-v=
5.2-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect good 63863ee8e2f6f6ae47be3dff4af2f2806f5ca2dd
# bad: [0a13f187b16a77bec4e3b929f9785b57358d74e0] Add linux-next specific f=
iles for 20190514
git bisect bad 0a13f187b16a77bec4e3b929f9785b57358d74e0
# good: [886c48ba76f6106efe5af1a2c78c8d03a28f507d] Merge remote-tracking br=
anch 'printk/for-next'
git bisect good 886c48ba76f6106efe5af1a2c78c8d03a28f507d
# bad: [f95f816ab5b76ea666aa7424354177a86c82c898] Merge remote-tracking bra=
nch 'battery/for-next'
git bisect bad f95f816ab5b76ea666aa7424354177a86c82c898
# good: [6c81e0d749706abb038417396ec5f1e737022321] Merge remote-tracking br=
anch 'thermal/next'
git bisect good 6c81e0d749706abb038417396ec5f1e737022321
# bad: [0e0b9cb7796a0f9056ac58d10e087467ca1b97b3] Merge remote-tracking bra=
nch 'input/next'
git bisect bad 0e0b9cb7796a0f9056ac58d10e087467ca1b97b3
# bad: [97aa7cbeb4bc9081105cb518157323341c976ccd] Merge remote-tracking bra=
nch 'drm/drm-next'
git bisect bad 97aa7cbeb4bc9081105cb518157323341c976ccd
# bad: [fb27a6c55da7475509589a5fc4799c058679c5a7] dt-bindings: rockchip-the=
rmal: Support the PX30 SoC compatible
git bisect bad fb27a6c55da7475509589a5fc4799c058679c5a7
# good: [686539daac9f5ed996a9f26de2d2dece3b75a2c0] drivers: thermal: tsens:=
 Add new operation to check if a sensor is enabled
git bisect good 686539daac9f5ed996a9f26de2d2dece3b75a2c0
# good: [f094d4eb07bce4b722427d99783d56a0364093d7] thermal: qoriq: Remove u=
nnecessary DT node is NULL check
git bisect good f094d4eb07bce4b722427d99783d56a0364093d7
# good: [e0e2c0d5895ac818a5c2cae1a745e7ad2e2acada] thermal/drivers/cpu_cool=
ing: Remove pointless test in power2state()
git bisect good e0e2c0d5895ac818a5c2cae1a745e7ad2e2acada
# good: [01c8d0e44e4cb7bbd50748d249904b2bb35f235d] thermal/drivers/cpu_cool=
ing: Remove pointless field
git bisect good 01c8d0e44e4cb7bbd50748d249904b2bb35f235d
# good: [f88f39be23c6cd65674e6d39ae268c7341960d96] thermal: broadcom: Remov=
e ACPI support
git bisect good f88f39be23c6cd65674e6d39ae268c7341960d96
# bad: [691d4947faceb8bd841900049e07c81c95ca4b0d] thermal: rockchip: fix up=
 the tsadc pinctrl setting error
git bisect bad 691d4947faceb8bd841900049e07c81c95ca4b0d
# first bad commit: [691d4947faceb8bd841900049e07c81c95ca4b0d] thermal: roc=
kchip: fix up the tsadc pinctrl setting error
---------------------------------------------------------------------------=
----
