Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB65B344052;
	Tue, 22 Sep 2026 01:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039942; cv=none; b=QW3aZTq7WRIdsuwLqBQ0sZvws9sPs5A2wYOtbkMIWzUbKXUIaJBl8Z/8oFmyb5s5dflboBOlYsN383PCHmcm8+e9ENWAhgcFNxa87xD0c8XqJllJdVeU2cJTEnhSCZ5p73jbs+MGZ4We5CrOw3My+TQSzAtHa1rF84GelolYr+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039942; c=relaxed/simple;
	bh=2p+Gq7ah2QKJmZfE/XuzuuJW3qj0Kbm2NKfdOURDWwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B8Iqg2vWQXH/OkHg8BJYJzFwRKYqjL0sPL90UKY/SjxhbKkblsLUEvCO3o+DnmJUcMxhBmebGEiSAG9NBOFWYCsiuq5+DseUYCtYnyUm47WPSr9ZpX5VZSCrzc4e/RQr6O6qYBe1Xd3xRRKl0WOKCcuVAqS9ihec5LKcPz80YTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSpNDMsA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSpNDMsA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21749C2BCF6;
	Tue, 22 Sep 2026 01:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790039942;
	bh=2p+Gq7ah2QKJmZfE/XuzuuJW3qj0Kbm2NKfdOURDWwY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=mSpNDMsAwoeLy4iZblAVKUcS+prFNqiuW3LJPLM9YGlUzhoLPuikjAUvr0W+ATmyO
	 cNDdW0B8x/msLWgGjrj17JeMJfhGB5NvuIrchCzteBVxVwZJizWCG7jLrsuyExIL5G
	 3Tzz7zBI4z8HZ6opdzCoXZF3c4UzRegBtBh5BbQFc4DEYWqlUDy74T+jkqfiMz1sp6
	 0jbH6xBNNG+2T0GK6gziYj7Z3Q79mDa92aHrITGeGsZ57kPTDyykSk1VsUDphlBWr7
	 NW8QXkHVW9NoltZLZgPLR833Iw0xijaMtgFRqQge9crJrqEKkfNBQ0NN8kkVRbq4Up
	 zkQHkLrCZ9zbQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7CEC982FB;
	Tue, 22 Sep 2026 01:19:02 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:19:01 -0400
Subject: [PATCH] cpufreq: scmi: publish perf_ops with release semantics
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-scmi-cpufreq-v1-1-934da6400a26@vt.edu>
X-B4-Tracking: v=1; b=H4sIAITXsWoC/yXMwQ6CMBAE0F8he3ZNqSjqrxgP7bqVmlBhV4gJ4
 d9t8fgmM7OAskRWuFYLCM9R4ztl1LsKqHPpyRgf2WCNPZmLrbH3qNRHpGEKwiOS84H9sTkb20J
 eDcIhfrfH2/1vnfyL6VNuSsM7ZfTiEnUl2ji3+wMKNbCuP0ocyMyTAAAA
X-Change-ID: 20260921-mb-scmi-cpufreq-cabfeb548027
To: Sudeep Holla <sudeep.holla@kernel.org>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790039941; l=3406;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=kGiX3bmrLMhZziNSbG0jyDiENr+zWQckZ25mLKshmo0=;
 b=nym2ybqGNPJA//+pWRCqx70dzBAwF7qdlvhnG6trOfnI+wgWRXp5XleSQEOp4Fyg3M06r8Flg
 GNU600DOkyEDXCpirkcdR4Q0AsdbZ4/frGUT1IqYypo92FpuzU1iT7U
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

scmi_cpufreq_probe() stores the SCMI performance protocol ops pointer to
the file-scope perf_ops with a plain store and then registers the
cpufreq driver. The callbacks read perf_ops with plain loads, starting
with scmi_cpufreq_init() on whichever CPU brings up a policy.

Keep the pointer in a local, publish it with smp_store_release() and
read it with smp_load_acquire() in scmi_cpufreq_init(), the first
callback invoked for a policy.

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 drivers/cpufreq/scmi-cpufreq.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 4edb4f7a8..c394f63cc 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -197,6 +197,8 @@ static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned long event,
 
 static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 {
+	/* Pairs with the smp_store_release() in scmi_cpufreq_probe(). */
+	const struct scmi_perf_proto_ops *ops = smp_load_acquire(&perf_ops);
 	int ret, nr_opp, domain;
 	unsigned int latency;
 	struct device *cpu_dev;
@@ -252,7 +254,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	  */
 	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
 	if (nr_opp <= 0) {
-		ret = perf_ops->device_opps_add(ph, cpu_dev, domain);
+		ret = ops->device_opps_add(ph, cpu_dev, domain);
 		if (ret) {
 			dev_warn(cpu_dev, "failed to add opps to the device\n");
 			goto out_free_cpumask;
@@ -293,14 +295,14 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	/* SCMI allows DVFS request for any domain from any CPU */
 	policy->dvfs_possible_from_any_cpu = true;
 
-	latency = perf_ops->transition_latency_get(ph, domain);
+	latency = ops->transition_latency_get(ph, domain);
 	if (!latency)
 		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	policy->cpuinfo.transition_latency = latency;
 
 	policy->fast_switch_possible =
-		perf_ops->fast_switch_possible(ph, domain);
+		ops->fast_switch_possible(ph, domain);
 
 	policy->transition_delay_us =
 		scmi_get_rate_limit(domain, policy->fast_switch_possible);
@@ -443,6 +445,7 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
 	int ret;
 	struct device *dev = &sdev->dev;
 	const struct scmi_handle *handle;
+	const struct scmi_perf_proto_ops *ops;
 
 	handle = sdev->handle;
 
@@ -451,9 +454,15 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
 
 	scmi_cpufreq_driver.driver_data = sdev;
 
-	perf_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
-	if (IS_ERR(perf_ops))
-		return PTR_ERR(perf_ops);
+	ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
+	if (IS_ERR(ops))
+		return PTR_ERR(ops);
+	/*
+	 * The cpufreq callbacks read perf_ops after cpufreq_register_driver()
+	 * below. Publish it with release semantics so that ph and the ops are
+	 * visible together.
+	 */
+	smp_store_release(&perf_ops, ops);
 
 #ifdef CONFIG_COMMON_CLK
 	/* dummy clock provider as needed by OPP if clocks property is used */

---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260921-mb-scmi-cpufreq-cabfeb548027

Best regards,
--  
Jaidev Shastri <jaidevshastri@vt.edu>


