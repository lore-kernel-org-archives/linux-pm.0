From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH 1/2] cpufreq: imx6q: remove unused code
Date: Mon, 26 Nov 2018 02:59:45 +0000
Message-ID: <1543200853-10029-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pm@vger.kernel.org

In voltage scale down path, the return value is NOT
used at all, remove them to simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufre=
q.c
index d8c3595..8cb9683 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -177,22 +177,16 @@ static int imx6q_set_target(struct cpufreq_policy *po=
licy, unsigned int index)
 	/* scaling down?  scale voltage after frequency */
 	if (new_freq < old_freq) {
 		ret =3D regulator_set_voltage_tol(arm_reg, volt, 0);
-		if (ret) {
+		if (ret)
 			dev_warn(cpu_dev,
 				 "failed to scale vddarm down: %d\n", ret);
-			ret =3D 0;
-		}
 		ret =3D regulator_set_voltage_tol(soc_reg, imx6_soc_volt[index], 0);
-		if (ret) {
+		if (ret)
 			dev_warn(cpu_dev, "failed to scale vddsoc down: %d\n", ret);
-			ret =3D 0;
-		}
 		if (!IS_ERR(pu_reg)) {
 			ret =3D regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
-			if (ret) {
+			if (ret)
 				dev_warn(cpu_dev, "failed to scale vddpu down: %d\n", ret);
-				ret =3D 0;
-			}
 		}
 	}
=20
--=20
2.7.4
