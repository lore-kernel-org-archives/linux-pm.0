From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] cpufreq: qcom-kryo: Fix section mismatch warning
Date: Wed, 19 Sep 2018 11:22:47 -0700
Message-ID: <20180919182247.1101-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilia Lin <ilia.lin@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>
List-Id: linux-pm@vger.kernel.org

WARNING: vmlinux.o(.text+0x8aa424): Section mismatch in reference from
the function qcom_cpufreq_kryo_probe() to the function
.init.text:qcom_cpufreq_kryo_get_msm_id()
The function qcom_cpufreq_kryo_probe() references
the function __init qcom_cpufreq_kryo_get_msm_id().
This is often because qcom_cpufreq_kryo_probe lacks a __init
annotation or the annotation of qcom_cpufreq_kryo_get_msm_id is wrong.

Add the '__init' annotation to qcom_cpufreq_kryo_probe so that there is
no more mismatch warning.

Fixes: 46e2856b8e18 ("cpufreq: Add Kryo CPU scaling driver")
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

Add '__init' to qcom_cpufreq_kryo_probe instead of removing it from
qcom_cpufreq_kryo_get_msm_id.

 drivers/cpufreq/qcom-cpufreq-kryo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index a1830fa25fc5..e001ef8ea7de 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -73,7 +73,7 @@ static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
 	return version;
 }
 
-static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
+static int __init qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 {
 	struct opp_table *opp_tables[NR_CPUS] = {0};
 	enum _msm8996_version msm8996_version;
-- 
2.19.0
