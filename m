Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA1D2C0309;
	Tue, 29 Apr 2025 23:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970759; cv=none; b=WWvFtz9hSLBPEl6Yfrqw/6r0gk4cSPCk3q45BkxjLf0WeU096Y6PXh9uC+MhzIon5YFI6G/KWpRsz5Y6JnTTZcFpVHe+8CWFIQaSDnqaT4LqdU3KClxEpgcuOAACRWFUnOXO9VFPNqDzFUUmO490TMjOCepEVYLNSAcuS3qXIh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970759; c=relaxed/simple;
	bh=ZBU19+R8ahuqjD6YirJAGVkDozUU72i3G9/SSQz/lDk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WFYqPepANLzoq5ujEY/bh21I2cmcpT3CYC9x16fuhbbaVwGNGoU6dxoBQM5PTTa/ybemC8ZcDRgEeOoFBDmorp26icsXjRHPlYUjXivf5Z5lB6z3+7GbKVb9pMNOyEyQAB7Job9EphQV1xdh411NyqIOH7JR+nUctN3P/IGGiQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZMmUZtM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZMmUZtM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090D8C4CEE3;
	Tue, 29 Apr 2025 23:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970758;
	bh=ZBU19+R8ahuqjD6YirJAGVkDozUU72i3G9/SSQz/lDk=;
	h=From:To:Cc:Subject:Date:From;
	b=HZMmUZtM3e3GRTrCzKkg8igPiRZt+5MRyUDJLX460pWTZlNosOphCGBRTGr+Tsq4y
	 38t2L5ODhme7Y3guW8WNBPuokhD3HxZL4Hq+FxdIzuOo0/TCv/wKUum8ZxUb8dpAy2
	 MRBsorrC4gKO38/9xK3QIczW0vDgDqwncxd0BRMJfFXCNmMJFmLVSig8Bmmlbl3+nk
	 zET0311guzNeUBgoepTrolNGB6vfqfU+klfoRpjO+j1jWYSJoN71F4qduEc3tzK0U0
	 RZlRmNlWg3OOfg3SWCWVNtu+fqhGTXivwN/Za5iuwzX2T2zbOIEysVzhQX8Og2BgXs
	 2lZgqIkynEkvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pengyu Luo <mitltlatltl@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/21] cpufreq: Add SM8650 to cpufreq-dt-platdev blocklist
Date: Tue, 29 Apr 2025 19:52:13 -0400
Message-Id: <20250429235233.537828-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.88
Content-Transfer-Encoding: 8bit

From: Pengyu Luo <mitltlatltl@gmail.com>

[ Upstream commit fc5414a4774e14e51a93499a6adfdc45f2de82e0 ]

SM8650 have already been supported by qcom-cpufreq-hw driver, but
never been added to cpufreq-dt-platdev. This makes noise

[    0.388525] cpufreq-dt cpufreq-dt: failed register driver: -17
[    0.388537] cpufreq-dt cpufreq-dt: probe with driver cpufreq-dt failed with error -17

So adding it to the cpufreq-dt-platdev driver's blocklist to fix it.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 09becf14653b5..c58c1defd7458 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -165,6 +165,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sm8350", },
 	{ .compatible = "qcom,sm8450", },
 	{ .compatible = "qcom,sm8550", },
+	{ .compatible = "qcom,sm8650", },
 
 	{ .compatible = "st,stih407", },
 	{ .compatible = "st,stih410", },
-- 
2.39.5

