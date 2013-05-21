From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] Thermal: spear: Fix compilation error
Date: Tue, 21 May 2013 14:50:41 +0530
Message-ID: <1369128041-23403-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:63789 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab3EUJeV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2013 05:34:21 -0400
Received: by mail-pa0-f52.google.com with SMTP id bg2so513942pad.25
        for <linux-pm@vger.kernel.org>; Tue, 21 May 2013 02:34:21 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, rui.zhang@intel.com, sachin.kamat@linaro.org, Vincenzo Frascino <vincenzo.frascino@st.com>, Viresh Kumar <viresh.kumar@linaro.org>

=46ixes the following compilation error introduced by commit 253e3ae170
(Thermal: spear_thermal: convert to devm_ioremap_resource).
drivers/thermal/spear_thermal.c: In function =E2=80=98spear_thermal_pro=
be=E2=80=99:
drivers/thermal/spear_thermal.c:123:46: error: =E2=80=98dev=E2=80=99 un=
declared
(first use in this function)
stdev->thermal_base =3D devm_ioremap_resource(dev, res);

While at it also remove the error message as devm_ioremap_resource()
provides its own error messages.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Vincenzo Frascino <vincenzo.frascino@st.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
Compile tested and based on linux-next (20130521).
---
 drivers/thermal/spear_thermal.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_th=
ermal.c
index fa30918..813add6 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -120,11 +120,9 @@ static int spear_thermal_probe(struct platform_dev=
ice *pdev)
=20
 	/* Enable thermal sensor */
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	stdev->thermal_base =3D devm_ioremap_resource(dev, res);
-	if (IS_ERR(stdev->thermal_base)) {
-		dev_err(&pdev->dev, "ioremap failed\n");
+	stdev->thermal_base =3D devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(stdev->thermal_base))
 		return PTR_ERR(stdev->thermal_base);
-	}
=20
 	stdev->clk =3D devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(stdev->clk)) {
--=20
1.7.9.5

