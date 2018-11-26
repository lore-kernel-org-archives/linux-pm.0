From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH 2/2] cpufreq: imx6q: save one condition block for normal case
 of nvmem read
Date: Mon, 26 Nov 2018 02:59:48 +0000
Message-ID: <1543200853-10029-2-git-send-email-Anson.Huang@nxp.com>
References: <1543200853-10029-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543200853-10029-1-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pm@vger.kernel.org

Put return value checks of calling imx6ul_opp_check_speed_grading()
into one block to save one condition block for normal case.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufre=
q.c
index 8cb9683..9fedf62 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -405,9 +405,10 @@ static int imx6q_cpufreq_probe(struct platform_device =
*pdev)
 	if (of_machine_is_compatible("fsl,imx6ul") ||
 	    of_machine_is_compatible("fsl,imx6ull")) {
 		ret =3D imx6ul_opp_check_speed_grading(cpu_dev);
-		if (ret =3D=3D -EPROBE_DEFER)
-			return ret;
 		if (ret) {
+			if (ret =3D=3D -EPROBE_DEFER)
+				return ret;
+
 			dev_err(cpu_dev, "failed to read ocotp: %d\n",
 				ret);
 			return ret;
--=20
2.7.4
