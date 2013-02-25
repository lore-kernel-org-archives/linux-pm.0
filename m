From: =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>
Subject: [PATCH v2] cpufreq: highbank: do not initialize array with a loop
Date: Mon, 25 Feb 2013 08:07:45 -0300
Message-ID: <1361790465-21760-1-git-send-email-emilio@elopez.com.ar>
References: <1361725277-5125-1-git-send-email-emilio@elopez.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361725277-5125-1-git-send-email-emilio@elopez.com.ar>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh.kumar@linaro.org, rjw@sisk.pl, shawn.guo@linaro.org, mark.langsdorf@calxeda.com
Cc: linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>
List-Id: linux-pm@vger.kernel.org

As uninitialized array members will be initialized to zero, we can
avoid using a for loop by setting a value to it.

Signed-off-by: Emilio L=C3=B3pez <emilio@elopez.com.ar>
---

Note that I don't own any device using this driver, it has only been co=
mpile
tested, but it shouldn't cause any issues.

Changes v1 -> v2:
  * Move freq / 1000000 to the array definition as suggested by Viresh =
Kumar

 drivers/cpufreq/highbank-cpufreq.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/cpufreq/highbank-cpufreq.c b/drivers/cpufreq/highb=
ank-cpufreq.c
index 66e3a71..b61b5a3 100644
--- a/drivers/cpufreq/highbank-cpufreq.c
+++ b/drivers/cpufreq/highbank-cpufreq.c
@@ -28,13 +28,7 @@
=20
 static int hb_voltage_change(unsigned int freq)
 {
-	int i;
-	u32 msg[HB_CPUFREQ_IPC_LEN];
-
-	msg[0] =3D HB_CPUFREQ_CHANGE_NOTE;
-	msg[1] =3D freq / 1000000;
-	for (i =3D 2; i < HB_CPUFREQ_IPC_LEN; i++)
-		msg[i] =3D 0;
+	u32 msg[HB_CPUFREQ_IPC_LEN] =3D {HB_CPUFREQ_CHANGE_NOTE, freq / 10000=
00};
=20
 	return pl320_ipc_transmit(msg);
 }
--=20
1.8.2.rc0
