Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EE04A6CFE;
	Thu, 24 Sep 2026 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265665; cv=none; b=YG97wuc3ypU35vWV8+iTt+XlT+FFI5Ia9t3W7a5ziaasi3dfWCoxypCCxA2ZCgIanNQLiNWvbO3QXT8jIA6Q1sMYz0qEC8g7aUDnihOG1NE+paz8dxk7L7hGxjFj0mSu4lmvMM8iVGjSyW7GwyrctHD2rDY9hGdcD7i0Ow7Pe9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265665; c=relaxed/simple;
	bh=Bo2UGHOYNYLWF9uIzmRC0ZazwugY4B830c/mPkLPNZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9AmQxdH1O+RPxRkBMnmItXDkksHU8dPAd1+Qbuybfjgi9qqcZCIr/YqxoCyWUAD8pFyGxfyl/62Yoi8QZUFZWUZlQRp/hf3eG07jDcvZm+LbgYzTKmr353yiuBYkrJ45CAAtnW6FTX1mqsKuQwJkiZLTANmKrhpeZVGbZJT9Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgNVmBjm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgNVmBjm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292391F00893;
	Thu, 24 Sep 2026 16:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790265663;
	bh=LK4pmZuRDKEBTXXexxgFUW4f2mz0iU8rh4lCyzxrJVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EgNVmBjmvusupVvrrpoqlf4g9GmEf99gYZclehKG69Q0l//nphw7eDfCi2b0ILgHW
	 9nxioZdk++JKV/NRZeDmG3FYdO7MXog9FKXxX310lS3n9eosuTYTdDs1GxubQjR5IP
	 6kGL649rwdh59IdyyCnC3jisd34b7LCAKeLT7Tn7SsY3I5qhLAiA7K2pH6z2e261hU
	 9vKKIMmeYvpDF3EM3H8qig9/gXvGJYAvomsmJEFW+uHlT0KD25q21kC3rMCQiVAQ6f
	 L9FA6Qb+Hc0zZlpUh67dquybwuUTj61z/9LfUe0qh5YgKdzxx8d1ZvBAoI2W72fUJe
	 XOwv4KDvQ7Mnw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: =?UTF-8?q?Rafael=20J=20=2E=20Wysocki=20=E2=8F=8E?= <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	x86@kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 3/3] cpufreq/amd-pstate: Get Highest Freq for a CPU
Date: Thu, 24 Sep 2026 11:00:52 -0500
Message-ID: <20260924160052.2858456-4-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924160052.2858456-1-superm1@kernel.org>
References: <20260924160052.2858456-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

If the highest frequency is known for a CPU, use this instead of
trying to calculate by linear interpolation.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 496e0342c1c90..2a0cbfe21a67d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1102,8 +1102,10 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
 
-	/* max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf */
-	max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
+	/* try to look up from BIOS/quirk first, fall back to (nominal_freq * highest_perf)/nominal_perf */
+	max_freq = amd_get_max_frequency(cpudata->cpu) * 1000;
+	if (!max_freq)
+		max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
 	WRITE_ONCE(cpudata->max_freq, max_freq);
 
 	lowest_nonlinear_freq = perf_to_freq(perf, nominal_freq, perf.lowest_nonlinear_perf);
-- 
2.53.0

