Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5696D3FA5D5;
	Mon, 11 May 2026 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507781; cv=none; b=Su7ZebjKFQ1nbCf9quhaGtGD5M4icMAF6X2q+DdUM0rNvEeXxX1gztBMd3qH38af9P2VNYU6B0A1pxGqxgrAfl5Wg6cgXz5MIAGALl2nTt1mkfAwvo8YI/Xn3/6PWlgXSqUYlVSLiLdMtXDLSfouJez9+ywtX30vf2W0RxQlKiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507781; c=relaxed/simple;
	bh=2stKrZL0m6TGow+ubPdhu8rMoV1nxwMQia6YWFiQkiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uh/wu+elcXLMmLTlDWgw6zVpYB0BYEGVewahxEZskQo92ZQvgZ7fjsSabe6NHr2okZGKzmEUfxbVJxaGS/xBZpLUPsD1ipqTz75J0vwC0N45m7r/i1XEd5ajUyP0ohow7YDCQuJj6UbPmadLcoG3nAlYfXrRWjP7u/dzJuYlOCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YILQS0DG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YILQS0DG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD2EA26AC;
	Mon, 11 May 2026 06:56:12 -0700 (PDT)
Received: from e135073.arm.com (unknown [10.57.34.159])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 026323F85F;
	Mon, 11 May 2026 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778507778; bh=2stKrZL0m6TGow+ubPdhu8rMoV1nxwMQia6YWFiQkiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YILQS0DG/iqJh5Rzdlc7zFhQJIFMa9Ha5C27FYOPnEfTIZ8qFR7HPgFuB8HohAEw1
	 IDX28+y9JcM+U7DrdfNr59UUg1acVzjAqttk+A8Axzp7DobGgtvX0XeG2e0z+btoSP
	 iXLTbPvNOgY0JwiGlAb0Vofd5xHs9uveQYSsdI88=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 4/4] cpufreq: Use policy->min/max init as QoS request
Date: Mon, 11 May 2026 15:55:31 +0200
Message-ID: <20260511135538.522653-5-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511135538.522653-1-pierre.gondois@arm.com>
References: <20260511135538.522653-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consider policy->min/max being set in the driver .init()
callback as a QoS request. Impacted driver are:
- gx-suspmod.c (min)
- cppc-cpufreq.c (min)
- longrun.c (min/max)

Update the documentation accordingly.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 Documentation/cpu-freq/cpu-drivers.rst | 10 ++++++++--
 drivers/cpufreq/cpufreq.c              | 12 ++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/cpu-freq/cpu-drivers.rst b/Documentation/cpu-freq/cpu-drivers.rst
index c5635ac3de547..ab4f3c0f3a89b 100644
--- a/Documentation/cpu-freq/cpu-drivers.rst
+++ b/Documentation/cpu-freq/cpu-drivers.rst
@@ -114,8 +114,14 @@ Then, the driver must fill in the following values:
 |policy->cur			    | The current operating frequency of   |
 |				    | this CPU (if appropriate)		   |
 +-----------------------------------+--------------------------------------+
-|policy->min,			    |					   |
-|policy->max,			    |					   |
+|policy->min			    | If set by the driver in ->init(),    |
+|				    | used as initial minimum frequency	   |
+|				    | QoS request.			   |
++-----------------------------------+--------------------------------------+
+|policy->max			    | If set by the driver in ->init(),    |
+|				    | used as initial maximum frequency	   |
+|				    | QoS request.			   |
++-----------------------------------+--------------------------------------+
 |policy->policy and, if necessary,  |					   |
 |policy->governor		    | must contain the "default policy" for|
 |				    | this CPU. A few moments later,       |
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 9e2d9d3fc5351..9a005367ed87b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1399,8 +1399,16 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 
 static int cpufreq_policy_init_qos(struct cpufreq_policy *policy)
 {
+	unsigned int min_freq, max_freq;
 	int ret;
 
+	/* Use policy->min/max set by the driver as QoS requests. */
+	min_freq = max(FREQ_QOS_MIN_DEFAULT_VALUE, policy->min);
+	if (policy->max)
+		max_freq = min(FREQ_QOS_MAX_DEFAULT_VALUE, policy->max);
+	else
+		max_freq = FREQ_QOS_MAX_DEFAULT_VALUE;
+
 	/*
 	 * If the driver didn't set policy->min/max, set them as
 	 * they are used to clamp frequency requests.
@@ -1418,12 +1426,12 @@ static int cpufreq_policy_init_qos(struct cpufreq_policy *policy)
 	}
 
 	ret = freq_qos_add_request(&policy->constraints, &policy->min_freq_req,
-				   FREQ_QOS_MIN, FREQ_QOS_MIN_DEFAULT_VALUE);
+				   FREQ_QOS_MIN, min_freq);
 	if (ret < 0)
 		return ret;
 
 	ret = freq_qos_add_request(&policy->constraints, &policy->max_freq_req,
-				   FREQ_QOS_MAX, FREQ_QOS_MAX_DEFAULT_VALUE);
+				   FREQ_QOS_MAX, max_freq);
 	if (ret < 0)
 		return ret;
 
-- 
2.43.0

