Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC96B2EAD15;
	Thu,  8 Oct 2026 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480291; cv=none; b=iHMlREFieEiqc8Y+A2rNWpwS1oFn6GUd+jbKYp3JOu6KBQfyPphinwW3JxK3HCzWQfN/nH+Tqv5cR6rEUX67mUuF9UO4DXfYJWzesNgJu/bFPuFNM07CgVpFce0cGtf3lkppxL2V5muIrLL+7LEoJhu1s3ZPOsa0HSk2yXD+AZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480291; c=relaxed/simple;
	bh=sbonmr3aZnBHQ3E8zoq/kEHvP5Nux40zeibBVc9bnnc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kBHCISXGifQMWamTKn9J3Po/XarniN6zA+n7hiSA8jeuH9hZMMYR7u8pqr3IR7sNBEhhIAOAAX5cIjcUUCrFmytYhF0KGzUQ0B/dFf2N65ERhm/UWSXPREiseR50tm9rK9L1ToWtUauRs+2Br9C2UG7GISmRJUOgM/7eMB1ROkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fc87d0ffb700.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADH0D7Y0cdqSRwPCg--.12352S2;
	Fri, 09 Oct 2026 01:24:40 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	Saravana Kannan <saravanak@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: qcom-cpufreq-hw: fix device node refcount leak in phandle parsing
Date: Fri,  9 Oct 2026 01:24:42 +0800
Message-Id: <20261008172442.2725544-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADH0D7Y0cdqSRwPCg--.12352S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4kJr1DWw48CrW3Ar18Krg_yoW8Xr18pa
	y5urZ0vF95JFsFk348Aa18W3WYkanFyrWUGryxC3sIyFn3J3W3X3y0kFy0kF95KrykAFyj
	yrs0v3WxWFWDJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWU
	twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07bnL0OUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwEOA2rHpl1pJgAAsS

of_parse_phandle_with_args() transfers a reference to the provider node
in out_args->np, which the caller is responsible for releasing with
of_node_put().  Neither qcom_get_related_cpus() nor
qcom_cpufreq_hw_cpu_init() ever puts args.np: they only put cpu_np, which
is a different node obtained from of_cpu_device_node_get().  The
reference is therefore leaked on every successful call, and
qcom_get_related_cpus() leaks one per present CPU.

Release args.np after the parsed index has been read in both call sites.

Fixes: 2849dd8bc72b ("cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver")
Assisted-by: DeepSeek-V4.1-Flash
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 874ff3fb9d97..060a460716f7 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -322,6 +322,8 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
 
 		if (index == args.args[0])
 			cpumask_set_cpu(cpu, m);
+
+		of_node_put(args.np);
 	}
 }
 
@@ -554,6 +556,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		return ret;
 
 	index = args.args[0];
+	of_node_put(args.np);
 	data = &qcom_cpufreq.data[index];
 
 	/* HW should be in enabled state to proceed */
-- 
2.25.1

