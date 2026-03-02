Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA91441C0D8;
	Mon,  2 Mar 2026 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468972; cv=none; b=u/EMxcdOEaG4BeoIdLfQnI1TuiQ/j+KcmZi7NglzgHzM1V8ghIrIOhH34VPcveH4pVekzoIW9xlyDkuEYOfbqCBGuuvh4aKTqGannv8HrPaKKUb0ZXA/YZTMofXBvUdcVbM6b2FWOfzz6kXRvnAshD2Lubt9C+htyta0YoNDA2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468972; c=relaxed/simple;
	bh=nKOzMWy5NQmQ/BiC/zb6DajxLD2ayrekplORUnjvHQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ui7fCl+6OTVH3APKGTjTUe4lzv2/bHWqOKY4du1vqJ3WeJ69bknXA0nozBcK7z5BktCWF5z0PzANHotnsOwWwLcKRd+JjTkrc4sLdT8J79f7jopqaqRafrSUATAv20GdD4O7oFTaHzpH3sBut3ZcNia+lYy+JOF0CfmiC8JVMSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803E9C4AF0F;
	Mon,  2 Mar 2026 16:29:29 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ilia Lin <ilia.lin@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/7] cpufreq: qcom-nvmem: Convert to of_machine_get_match()
Date: Mon,  2 Mar 2026 17:29:08 +0100
Message-ID: <886a603a7a1de6c8cb14ee0783ee0bceea4d914a.1772468323.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772468323.git.geert+renesas@glider.be>
References: <cover.1772468323.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the of_machine_get_match() helper instead of open-coding the same
operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index b8081acba928f5a9..e6d28d162442a085 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -291,17 +291,9 @@ static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
 	ret = qcom_smem_get_soc_id(&msm_id);
 	if (ret == -ENODEV) {
 		const struct of_device_id *match;
-		struct device_node *root;
-
-		root = of_find_node_by_path("/");
-		if (!root) {
-			ret = -ENODEV;
-			goto exit;
-		}
 
 		/* Fallback to compatible match with no SMEM initialized */
-		match = of_match_node(qcom_cpufreq_ipq806x_match_list, root);
-		of_node_put(root);
+		match = of_machine_get_match(qcom_cpufreq_ipq806x_match_list);
 		if (!match) {
 			ret = -ENODEV;
 			goto exit;
@@ -647,14 +639,10 @@ MODULE_DEVICE_TABLE(of, qcom_cpufreq_match_list);
  */
 static int __init qcom_cpufreq_init(void)
 {
-	struct device_node *np __free(device_node) = of_find_node_by_path("/");
 	const struct of_device_id *match;
 	int ret;
 
-	if (!np)
-		return -ENODEV;
-
-	match = of_match_node(qcom_cpufreq_match_list, np);
+	match = of_machine_get_match(qcom_cpufreq_match_list);
 	if (!match)
 		return -ENODEV;
 
-- 
2.43.0

