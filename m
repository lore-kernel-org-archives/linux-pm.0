Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276402;
	b=FewzsL6J7cLEkg6Lyp36wZWW/T02mJlsm/SgA0KYNX3fO3RBjCD1D+y9Z+jI8vLi1SHo
	 S6xDrTU2NS5ro4jWuK0xrM6SORhuZMwc/DCLxlk7t7UCuSw1WdYHn0nv/DJCel2i/sNjK
	 oUlzNd4H4QgjKedBUmDa7NXizfkwz5Mgoun9wKj1z6w3CA7Ju4rJk2tw93glGMt7k5aqr
	 bYJUxbpgwE0gGwr486ijQssGJUr073NSNQN2hy1VNmlDLn4G5V9F7DRTZJljS5wyqXfg1
	 S0v8e40+4N3qwZv1pCAf5Hr03o+7a2ob8GCKr093IVtjeEL/WDwFBdo7mXHgZ/DU0QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276402;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PCfJijDK6zkN6m3eF4eqhYYLCTvxwQVuZI/7uH2mKuE=;
	b=AmBsfkGBhoNomFNlyI8eNOy8HgaU58aoh4kWYPHBC7D1D5t9OqTZz92U1M7OA0PLirFO
	 Ft8ROjP8ioMNDEgNTLs2yLCJZEG3Ko2xk6PU7JMQgN9AYk1yHmPyxMnq/IIWtUoBfB3S+
	 krbs1EN4JYdmtCboeOptOo0Fzk5QnoXeTacsWve8FufDpE8z85hurDp5EzDBXs8x7VlSr
	 KebQUVUOibUCcMNgiUua+Rl9q5SCFKCNVj1hxNeAP0E1/Y42ULFfI9HaaRt70MN5SWeXj
	 QON/NP8MQCByzMSg+bjyXNB4lb5EyJlE3LMecAenqCzgRVMF1FriQSgOcsk9ILRmR4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=AG+ayGbv;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B27D606A31D;
	Thu, 29 Oct 2026 12:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B27D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=AG+ayGbv
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4A2D1BB2;
	Thu, 29 Oct 2026 05:19:57 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.65.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 149753F673;
	Thu, 29 Oct 2026 05:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793276400; bh=5Qk/Zq04YGUhs16OwpX2EsAXBCqFRg+4PjxEu6YkscQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AG+ayGbvDd+iEDFPbc4cqUJo6qusPYT/wzxN+gOFrw1F+kwHjsQNo++NKPmq9B9DC
	 6qKBVGPYq9q8dvcYjPwz3U0mPWSqDQNkSgZ8B2PGqNemq9m5K4Eu5dVuM5IM7+BubH
	 ICHXh0Awqogf/09ATPRPqwbjSxVtRlXZvcLpWVGY=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 1/2] cpufreq/amd-pstate: Keep minimum requests within policy limits
Date: Thu, 29 Oct 2026 12:19:44 +0000
Message-Id: <20261029121945.854675-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029121945.854675-1-christian.loehle@arm.com>
References: <20261029121945.854675-1-christian.loehle@arm.com>
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

The minimum performance hint can exceed the policy maximum, e.g.
for schedutil when an RT task requests full CPU capacity. After
converting that hint, amd_pstate_adjust_perf() raises max_perf to
min_perf. This replaces the policy cap with the scheduler's minimum
request, and the subsequent Desired clamp uses the expanded interval.

Clamp min_perf to max_limit_perf instead of raising max_perf, to
enforce the policy's upper-bound again.

Fixes: 3f7b835fa4d0 ("cpufreq/amd-pstate: Move limit updating code")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpufreq/amd-pstate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4bedfbfc18b6..28df8507d93f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -866,8 +866,7 @@ static void amd_pstate_adjust_perf(struct cpufreq_policy *policy,
 		min_perf = perf.min_limit_perf;
 
 	max_perf = perf.max_limit_perf;
-	if (max_perf < min_perf)
-		max_perf = min_perf;
+	min_perf = min(min_perf, max_perf);
 
 	amd_pstate_update(policy, min_perf, des_perf, max_perf, true,
 			policy->governor->flags);
-- 
2.34.1

