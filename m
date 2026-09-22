Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF07330328;
	Tue, 22 Sep 2026 01:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039489; cv=none; b=luaDl8s84y+Nwibyl/sP9WEvrv79UfqpLlIUzQS77JdDbcKu/UbqHkWkE5ZY0xVsLJ5UAHN96Dut0cgZ+E7w6GORX/3MAY+KTRfSCicmysrYfnCTeEAcv4jNrU24JVNxmrB1+GADC11342ws8TNP/SFw4KgZGU1Wf4T3eCwIa7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039489; c=relaxed/simple;
	bh=5X27u2hiL1u4hEaP8dHSnqHxiAhIK+0cXXIaaRdp43w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qnr5kxZZGmoSitNmrEt2Qz4UeIU8Q3T+/KKKAMs8t3tc6nlyCJ+5RRtJnbf9MsAya+AZ9BUA9z/yMSj2KN2+DcgUKF8gLx9H2DVyJe/9ddHxdisz4IX99A73SHE9rhA5ccGxjNMh8RzGQ1866dDa8ArkS4DjbQT6QNcBL/AKFKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYxqNeZa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYxqNeZa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3579FC2BCB3;
	Tue, 22 Sep 2026 01:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790039489;
	bh=5X27u2hiL1u4hEaP8dHSnqHxiAhIK+0cXXIaaRdp43w=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=lYxqNeZa9/ZuOFcXV0Y4jFd8QGzjHXa0k6dQffIZOPLdvEChlSqsees21SpcacUTE
	 CrtCdktfMxjVbAn0VhZttAsn9SOXJViqHkL7oI7kNBtYR5+wsQ6DdkMfsTe0koXwBZ
	 +9mtdjlHgwj0OiVAIhJDVGLGfSuLWo01U6jibtRJCTMSqakwNZ1gh9zq4K4JNf4OKO
	 KG7xK1N0L896S8kFgUAowy6zZ8IBNci7x8MlUoi2nEYXaNACeYcvehQJzBx29zeeLl
	 LlrqgxCMGBp5tDLGhVkrPhL8AIOlGtUfUgy6KaoSOyUWeBgtv5pPP48c20J5R2mj7u
	 ukYs4tYKDZf3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18378C982E6;
	Tue, 22 Sep 2026 01:11:29 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:11:26 -0400
Subject: [PATCH] cpufreq: qcom-hw: order driver state before registration
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-qcom-cpufreq-v1-1-b5943c3fce18@vt.edu>
X-B4-Tracking: v=1; b=H4sIAL3VsWoC/yXMwQ6CMBAE0F8he3YN1KrRXyEe2nVXakKBrRATw
 r/b4vFNZmaFxBo4wb1aQXkJKQwxozlUQJ2LL8bwzAZTm0t9Mw32HicaeqRxFuUJrZHm7MSLswJ
 5NSpL+O6P7ePvNPs306fclIZ3idGri9SVaOdyPZ5QycK2/QC1nYZZkwAAAA==
X-Change-ID: 20260921-mb-qcom-cpufreq-42f15afbfa4f
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790039488; l=1920;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=/khXpPvYG7xlCLQJOIORkk6TQr/7EtBeJQkfKyRMxTE=;
 b=0BGrPAhrCFaS38T+KMlDx9jG3b+MEp/WJCI3qdQpw3GQISguImziZ6zV8jJ3lFlr4NoMTXatR
 pC3M8znConwCgCbPXwTPaBwcJFpWDZiqRKCjILZ04zCpSzkntSgJKlN
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

qcom_cpufreq_hw_driver_probe() stores xo_rate, cpu_hw_rate,
qcom_cpufreq.soc_data and the per-domain qcom_cpufreq.data[] array with
plain stores and then calls cpufreq_register_driver(). The cpufreq core
invokes qcom_cpufreq_hw_cpu_init() for every policy, on other CPUs, and
that function reads all of them with plain loads.

Order the stores before the registration with smp_wmb() and add the
matching smp_rmb() in qcom_cpufreq_hw_cpu_init().

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 874ff3fb9..62cc1f403 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -554,6 +554,8 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		return ret;
 
 	index = args.args[0];
+	/* Pairs with the smp_wmb() before cpufreq_register_driver() in probe. */
+	smp_rmb();
 	data = &qcom_cpufreq.data[index];
 
 	/* HW should be in enabled state to proceed */
@@ -738,6 +740,13 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * qcom_cpufreq_hw_cpu_init() runs on other CPUs through the cpufreq
+	 * core once the driver is registered and reads xo_rate, cpu_hw_rate,
+	 * qcom_cpufreq.soc_data and qcom_cpufreq.data[]. Order those stores
+	 * before the registration. Pairs with the smp_rmb() in cpu_init.
+	 */
+	smp_wmb();
 	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
 	if (ret)
 		dev_err(dev, "CPUFreq HW driver failed to register\n");

---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260921-mb-qcom-cpufreq-42f15afbfa4f

Best regards,
--  
Jaidev Shastri <jaidevshastri@vt.edu>


