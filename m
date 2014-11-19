From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] thermal: sti: Ignore suspend/resume functions when !PM
Date: Wed, 19 Nov 2014 13:48:59 +0000
Message-ID: <1416404939-365-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com, edubezval@gmail.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Prevents build warning:

st_thermal.c:278:12:
    warning: =E2=80=98st_thermal_suspend=E2=80=99 defined but not used =
[-Wunused-function]
st_thermal.c:286:12:
    warning: =E2=80=98st_thermal_resume=E2=80=99 defined but not used [=
-Wunused-function]

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/thermal/st/st_thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_th=
ermal.c
index 90163b3..9841488 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -275,6 +275,7 @@ int st_thermal_unregister(struct platform_device *p=
dev)
 }
 EXPORT_SYMBOL_GPL(st_thermal_unregister);
=20
+#ifdef CONFIG_PM
 static int st_thermal_suspend(struct device *dev)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
@@ -305,6 +306,8 @@ static int st_thermal_resume(struct device *dev)
=20
 	return 0;
 }
+#endif
+
 SIMPLE_DEV_PM_OPS(st_thermal_pm_ops, st_thermal_suspend, st_thermal_re=
sume);
 EXPORT_SYMBOL_GPL(st_thermal_pm_ops);
=20
--=20
1.9.1
