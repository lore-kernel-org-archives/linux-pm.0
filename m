From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 2/3] regulators: Add definition of regulator_set_voltage_time() for !CONFIG_REGULATOR
Date: Mon,  2 Jun 2014 12:59:24 +0530
Message-ID: <bc48fa7971f874d77a304e86a72ff5cee6f29e7c.1401693980.git.viresh.kumar@linaro.org>
References: <788accde56086078d69d3eba0d913114315de43a.1401693980.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <788accde56086078d69d3eba0d913114315de43a.1401693980.git.viresh.kumar@linaro.org>
In-Reply-To: <788accde56086078d69d3eba0d913114315de43a.1401693980.git.viresh.kumar@linaro.org>
References: <788accde56086078d69d3eba0d913114315de43a.1401693980.git.viresh.kumar@linaro.org>
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
V1->V2: return -EINVAL instead of zero.

 include/linux/regulator/consumer.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulat=
or/consumer.h
index 28fa089..7563f8b 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -397,6 +397,12 @@ static inline int regulator_set_voltage(struct reg=
ulator *regulator,
 	return -EINVAL;
 }
=20
+static inline int regulator_set_voltage_time(struct regulator *regulat=
or,
+					     int old_uV, int new_uV)
+{
+	return -EINVAL;
+}
+
 static inline int regulator_get_voltage(struct regulator *regulator)
 {
 	return -EINVAL;
--=20
2.0.0.rc2
