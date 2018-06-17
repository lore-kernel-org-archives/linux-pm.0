From: ilia.lin@gmail.com
Subject: [PATCH v2] cpufreq: kryo: Fix possible error code dereference
Date: Sun, 17 Jun 2018 21:58:42 +0200
Message-ID: <20180617195842.22818-1-ilia.lin@gmail.com>
References: <20180614202921.32535-1-ilia.lin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180614202921.32535-1-ilia.lin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ilia.lin@gmail.com
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Ilia Lin <ilia.lin@gmail.com>

In event of error returned by the nvmem_cell_read() non-pointer value
may be dereferenced. Fix this with error handling.
Additionally free the allocated speedbin buffer, as per the API.

Fixes: 9ce36edd1a52 (cpufreq: Add Kryo CPU scaling driver)
Signed-off-by: Ilia Lin <ilia.lin@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-kryo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index d049fe4b80c4..74b9b93d511b 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -115,6 +115,8 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 
 	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
 	nvmem_cell_put(speedbin_nvmem);
+	if (IS_ERR(speedbin))
+		return PTR_ERR(speedbin);
 
 	switch (msm8996_version) {
 	case MSM8996_V3:
@@ -127,6 +129,7 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 		BUG();
 		break;
 	}
+	kfree(speedbin);
 
 	for_each_possible_cpu(cpu) {
 		cpu_dev = get_cpu_device(cpu);
-- 
2.11.0
