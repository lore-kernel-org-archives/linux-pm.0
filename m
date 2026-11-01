Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559502;
	b=scWskZPkguqr6SPP1PrZZAW0gpwvHCQWir41/ycocQt1m+JdfqlH+ZqowbMGwmA4G9vi
	 zj2p6byUR0V5dJ9k9Cp2cDhaFzpwa076Gr+p2IsI5wjZ4hpIQ+9nJZmyT0TQRJGmbybMm
	 4XfSSI7B8O/cwmNL4mhV2Tmfh2R3/dzvjQJsPI9bvV3kQk17HgVRcixqvecTXjsLo5E9c
	 UzQuwroQzVEexhkiLQOuivZYvGUnuYdGdDJXLJtQIQSMnTL1o6idwF4UsVVV4xPcCeO2m
	 xmO8TH+0dYlLD5ycBGkDldk3UnjkHo4qa+MOkJF/bvhVuneR+Md73VnaVz7OGcsD99w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559502;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=x5fTb5UWBlgiWGkgOOBDAPFo8Ho3NRa1iT80XUYs+XY=;
	b=rAonsfVAALugXqwRNHhk8PP+eQSFNctlQKKRPHeziPQsmhx4jehKr+h+8LRhL037grIP
	 FViCKzWNL50XuoSi4s6XFf/E2bv14zjrPASFrO1vFI2x7eVkgRFT4CjfA4Qv4QQ1LPvd4
	 y5cmVdQqqnTo+XMx7rmO+b7tn/BNIIlKk1HR4crDjubtzxGcu+dUJiwyAoC+xmUfC66q+
	 NByL28rtXHNqWajlRgaCiL0jeM2KIcw63LeWDNBwOxdrxex3Jr7NGm5TV5g8ONRZYwXcK
	 RcP8Un3nzewYz/zX4VAAsimt+X1roHXYnwub6rXmn+hCzgDuPTjTWRYFaeLtSc3VP/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hsal.es;
	spf=pass smtp.mailfrom=hsal.es;
	dkim=pass header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=ry3hCN5V;
	arc=none smtp.remote-ip=80.241.56.171
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CDB60A2610;
	Sun,  1 Nov 2026 18:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81CDB60A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hsal.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hsal.es
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=ry3hCN5V
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jHkck1PTGzMlB2;
	Sun, 01 Nov 2026 19:58:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
	t=1793559494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x5fTb5UWBlgiWGkgOOBDAPFo8Ho3NRa1iT80XUYs+XY=;
	b=ry3hCN5VJL/ERMI1JVM+B58zISOvY4hcFtzGbXEZSkj0OqEZIRbyfcOSO2NzhTJeSiZoNW
	NhuLyXw46ky0WLkFWa4K7pmvUGH4FO1waj1LgAZ9c6cemLbLc4hbTNzlrviWAmyWj8A2+i
	C58AMZGaGXB2EA2qJ3rZgfrMa4kcc/H6Lq0OtSZnHJVvRgTrZGkrTkIZg0RipL7pX+WCxA
	5hs4USb/yhVFWXi/9JSUU1Xmk076nz6Vd64iq2Dw6yasjRvJscXAv+oyBkvANSVbkEjARq
	M8M2q72mTQWPs8qmhpCuT/msOmFBcP4cSj1hQFBb9hBAYAU5Oeewva/2lb/khA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Len Brown <lenb@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Ashton A." <me@ashtonantila.com>,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] ACPI: processor: thermal: Factor out the thermal_req update
Date: Sun,  1 Nov 2026 18:58:06 +0000
Message-ID: <20261101185807.112449-4-hugo@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101185807.112449-1-hugo@hsal.es>
References: <20261101185807.112449-1-hugo@hsal.es>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jHkck1PTGzMlB2

Split the cap computation and the thermal_req update out of
cpufreq_update_thermal_limit() into cpufreq_update_thermal_req(), which
takes the policy and the step as arguments. This prepares for
recomputing the cap on CPUFREQ_UPDATE_CPUINFO, where the notifier
passes the policy and the step is stored for each CPU

No functional change

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 drivers/acpi/processor_thermal.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index 11036f0d2b942..25c4b0ad64e36 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -88,23 +88,30 @@ static int cpufreq_get_cur_state(unsigned int cpu)
 	return reduction_step(cpu);
 }
 
-static bool cpufreq_update_thermal_limit(unsigned int cpu, struct acpi_processor *pr)
+static void cpufreq_update_thermal_req(struct cpufreq_policy *policy,
+				       struct acpi_processor *pr,
+				       unsigned int step)
 {
 	unsigned long max_freq;
 	int ret;
 
-	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
-	if (!policy)
-		return false;
-
 	max_freq = (policy->cpuinfo.max_freq *
-		(100 - reduction_step(cpu) * cpufreq_thermal_reduction_pctg)) / 100;
+		(100 - step * cpufreq_thermal_reduction_pctg)) / 100;
 
 	ret = freq_qos_update_request(&pr->thermal_req, max_freq);
 	if (ret < 0) {
 		pr_warn("Failed to update thermal freq constraint: CPU%d (%d)\n",
 			pr->id, ret);
 	}
+}
+
+static bool cpufreq_update_thermal_limit(unsigned int cpu, struct acpi_processor *pr)
+{
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
+	if (!policy)
+		return false;
+
+	cpufreq_update_thermal_req(policy, pr, reduction_step(cpu));
 
 	return true;
 }
-- 
2.56.0

