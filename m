Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869419;
	b=M9Vxv7IptTX9cCSGxucQOUh8oUB1+Lm7FOvevTzrFjDFNvPmh2wKalKKvFaxNYQ1qFqy
	 lDFz6Ras5sPM49P6uurXdAlyE9vSrNbt5Ipc39ncOvVbbk4mObZZnP9q9BlF/z9LyE9Kg
	 pBI1fkyrFrYfAqEqogwPWMRUXDb+F794NKx3jAGbPoWTzWeUJVJ7eVFVRR9BMVVAHcYtS
	 4GPsftus4FDO2BmVBqblRenDTz/pvRea7dCVZK0Kv/FVvmsIbeypRlBtpK6uDJ11TN04W
	 LRjPNQudm0FrZevWbe3k0dAsJ3QW6FzzAmdx0oz9vCnZUWDobWoGEGvPjUQlDpv0u/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869419;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SRIJlDX/O5ZMoPo3UN3JleoZu65+Wq9cQdIufSNP+Ww=;
	b=X/rYu5NFxsbcBCP8/pze93QbVGM8Gz5ZFxlp3lS89oDetlIQvP9ebbqpw1b20lohsx1p
	 3jCALenHNhMwwRot+du8sY0jNojdqIg7xNi8nX/92jFMab+zJPBfdHQzheM8eDCEBxfFL
	 tjt/hsd/bL93cQpnBqS3D/hu8MGrMRZCdBnbnWq1P7SycTrmz82x3VZ7CAee9/OaEK+5X
	 gxYRD3GexdxQRTWyVFdwI2U5gs0HYrRuo1U39816gECrsheVpE2Uf0S+0hDk6hcS0dxpV
	 0PsbV7xzWu8kVgKz6V8V8K8C6ngG6V/UveAAnOxRVB/Su0VNz/XC5ECODv5QcflefKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=C2fhzKmo;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE2A606A32C;
	Thu,  5 Nov 2026 09:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EE2A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=C2fhzKmo
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 548EA1BF3;
	Thu,  5 Nov 2026 01:03:35 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.0.130.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 652923F628;
	Thu,  5 Nov 2026 01:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793869418; bh=YTFr0wMhdFostItEAJdjtI39vl0lU/osZweCF6WF1Iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C2fhzKmofRWW0e5bGWy7n5wAYbR77E0JlngMM45A7glr9HwDqRWdzDJenjRiVwGG2
	 PqOYdo+V/5cGbCRsx+sgubtD9UnFPR0NqaM3Ua+GuT9gMqWhIJoJ9SoiqjA2bOfv4c
	 9bOLf1d1Xaf4qs38CYtflVs0KIlGVGa5Jk1/qziY=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sumitg@nvidia.com,
	zhanjie9@hisilicon.com,
	superm1@kernel.org,
	zhangpengjie2@huawei.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v2 2/2] cpufreq: Serialize global boost updates
Date: Thu,  5 Nov 2026 09:03:11 +0000
Message-Id: <20261105090311.1026648-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105090311.1026648-1-christian.loehle@arm.com>
References: <20261105090311.1026648-1-christian.loehle@arm.com>
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

Serialize concurrent global boost sysfs writes with a mutex.

Fixes: 6f19efc0a1ca ("cpufreq: Add boost frequency support in core")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 23a77f5524df..d95c849f79c5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2810,6 +2810,8 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
 }
 EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
 
+static DEFINE_MUTEX(cpufreq_boost_mutex);
+
 static int cpufreq_boost_trigger_state(int state)
 {
 	struct cpufreq_policy *policy;
@@ -2817,6 +2819,8 @@ static int cpufreq_boost_trigger_state(int state)
 	bool boost_enabled;
 	int ret = -EOPNOTSUPP;
 
+	guard(mutex)(&cpufreq_boost_mutex);
+
 	/*
 	 * Don't compare 'cpufreq_driver->boost_enabled' with 'state' here to
 	 * make sure all policies are in sync with global boost flag.
-- 
2.34.1

