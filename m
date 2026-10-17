Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5BB345EDC;
	Sat, 17 Oct 2026 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792221570; cv=none; b=SO3s9FwYSJVV/QVjMjLUdirxRcG9epegKogf2lpykysg5p0PIOrshcszwaXPy41IolxsEojfR7Uw3EErWPip+xHl+mEVAskutF6LRhXotfKxEzNKJxXoH58I4yFEBOqsatJhTngOkiMcex13izwlrKKLSauSWyCzzOUryO+t8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792221570; c=relaxed/simple;
	bh=+OQbdAvCqz373G+pRPnY1Y1Tv/4k/axYwIV3WlZCiUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aThU7HhZ4HG8/OYXWr2A5IkBcWnwBdYkC4NSnrjvTXl5vWK4pxJSxZj65LXRcGCgBiJKp5k24XvLyRuzGcJYPiaRyaB1o95Oo7HN5r+CaV0vQIY6149zJKMwKG6SvtqYXMv8iwhWcxPSa007aeyOSufKa9vtwpe97OHbkEfcKQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=U2uP0MX4; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="U2uP0MX4"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j6CqK0mSzzMlHW;
	Sat, 17 Oct 2026 09:19:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792221565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oNpAoGNTgHSqn7GUE7PK9R0mFPLr37YoZgQegXEC9bQ=;
	b=U2uP0MX4eORzjZju9G8lLDckMufukkCMkVzVVo1L0ywDmQN+brKoHDoyMFk0zEq5F/qyFK
	H5ePSkeS9MI7BZpMJuTO8v1uWi9fEfecf4X+Fdyo5CvNnjEnNPRoj85YG2kAK8pmZrvGgc
	dqEYBu18eWuAipjMQg7VPIY+o+X4QJTPzSEnyU0a2zAKZh5LYTyLxEJ+iwxm4jea6ubTai
	tsbie09nFNYL+vB3YEcYnGv7vUMqlYrJkJzZYeRIo3/UlmJKavzmfmp+hKLJY1ETjYbMCw
	lVS8IHR89iArOPsYF4Ts1Y+82wg2HFKH7ePhTKlh2Xkduat5vIAFe3EMIsyxZQ==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: longrun: fix typo in kernel-doc
Date: Sat, 17 Oct 2026 09:14:34 +0200
Message-ID: <20261017071434.1250140-2-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: eda2579dba5e26fb629
X-MBO-RS-META: u5d96bo9xx37fhtp6omqn6kqhq6nkune

Fix typo to fix:

  $ ./scripts/kernel-doc -none drivers/cpufreq/longrun.c
  Warning: drivers/cpufreq/longrun.c:126 expecting prototype for longrun_verify_poliy(). Prototype was for longrun_verify_policy() instead

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 drivers/cpufreq/longrun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/longrun.c b/drivers/cpufreq/longrun.c
index 82a7bb69c..7d4146d6c 100644
--- a/drivers/cpufreq/longrun.c
+++ b/drivers/cpufreq/longrun.c
@@ -117,7 +117,7 @@ static int longrun_set_policy(struct cpufreq_policy *policy)
 
 
 /**
- * longrun_verify_poliy - verifies a new CPUFreq policy
+ * longrun_verify_policy - verifies a new CPUFreq policy
  * @policy: the policy to verify
  *
  * Validates a new CPUFreq policy. This function has to be called with
-- 
2.55.0

