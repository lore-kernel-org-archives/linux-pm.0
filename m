From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/2] regulators: Add definition of regulator_set_voltage_time() for !CONFIG_REGULATOR
Date: Tue, 27 May 2014 17:37:29 +0530
Message-ID: <1780c3205893be8567fa29ccd86674e2f32555b4.1401192160.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, edubezval@gmail.com, pavel@ucw.cz, lgirdwood@gmail.com, broonie@kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

We already have dummy implementation for most of the regulators APIs fo=
r
!CONFIG_REGULATOR case and were missing it for regulator_set_voltage_ti=
me().

=46ound this issue while compiling cpufreq-cpu0 driver without regulato=
rs support
in kernel.

drivers/cpufreq/cpufreq-cpu0.c: In function =E2=80=98cpu0_cpufreq_probe=
=E2=80=99:
drivers/cpufreq/cpufreq-cpu0.c:186:3: error: implicit declaration of fu=
nction =E2=80=98regulator_set_voltage_time=E2=80=99 [-Werror=3Dimplicit=
-function-declaration]

=46ix this by adding dummy definition for regulator_set_voltage_time().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Liam/Broonie: Please see if this can go through Rafael as 2nd patch is =
dependent
on it.

 include/linux/regulator/consumer.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulat=
or/consumer.h
index 1a4a8c1..0cfc286 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -397,6 +397,12 @@ static inline int regulator_set_voltage(struct reg=
ulator *regulator,
 	return 0;
 }
=20
+static inline int regulator_set_voltage_time(struct regulator *regulat=
or,
+					     int old_uV, int new_uV)
+{
+	return 0;
+}
+
 static inline int regulator_get_voltage(struct regulator *regulator)
 {
 	return -EINVAL;
--=20
2.0.0.rc2
