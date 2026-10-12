Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D49B38DC74;
	Mon, 12 Oct 2026 04:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791778706; cv=none; b=gjdZLdM71iPKqwAUJLJ9gd7OgA3aaB+xDdROYewOB4jBluOTg0RCcNhwIaXM0Tt57kxihWRBbtBkP3SfjpU/Vx5N0O9hwZsddjZlFPwAVu0iwDv1ZpbHojG4R9423R7c8K5YSmXcoxlBHDUOUkx6eb5h/ZmNiHFuxuwzXJtZVf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791778706; c=relaxed/simple;
	bh=ShqiIO+0C4dqBr7y0+/PYE+wO7QxUHXqzbfogHmVcFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=otyahTLLlRXaHoxBDSIuu2PoEIGhuOXrNk2eTTZWvIfvCmjFkUPpQ3EF8Y7nHJ9p++dLnrptXOs0dIsk2DimAq4tceiujZkdNItaczZDFhzdvonkX2Bq43Hmk9aaMx2pZWTsGbzEizhNfIljUm8zqXBoZqa9zTB8c1s63CEmbMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ys5Tgezo; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ys5Tgezo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=zy
	4SkW+De5fmcOdbmplwsroUT0S8hLQyOd2wp72yl7A=; b=Ys5TgezoQAEMvy6n2M
	c4Yrx6Cf7dGzhi9Gj7UN71xihdDXXzorA/nYr/Oob4+QuTWuo56uwTNx7oRqCTRE
	KtQcCEa3YvLmhdqekEQ00/lPSy998SPHur1NONj5sqSHyvIUQfh6qCDHmrLgPwbG
	lxi0rTIA8sX4fTgN+G7cjDkWs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3_5mAX8xqgQIyEA--.14690S2;
	Mon, 12 Oct 2026 12:18:09 +0800 (CST)
From: Yongxin Yang <yangyongxin@kylinos.cn>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	pavel@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yongxin Yang <yangyongxin@kylinos.cn>
Subject: [PATCH v2] PM: hibernate: Log hibernation mode at S4 entry
Date: Mon, 12 Oct 2026 12:17:33 +0800
Message-Id: <20261012041733.798932-1-yangyongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261010031903.123484-1-yangyongxin@kylinos.cn>
References: <20261010031903.123484-1-yangyongxin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_5mAX8xqgQIyEA--.14690S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW3JF4rCF1UJFWUtF1xAFb_yoW8Ww1kp3
	yqqr4kta9rZ3W2y3W0qFWrJF98Z39agw45JFnFgr9rArn2qa9YyF4SgF10vrWjk3s7ta1S
	qF1qv34DJr47uF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ud5rsUUUUU=
Sender: yang_yongxin123@163.com
X-CM-SenderInfo: 51dqwsp1rqw5tlqrjji6rwjhhfrp/xtbDAAHFY2rMX4EbWQAA3d

The S4 path is the only place where the kernel decides whether a
completed image write ends in poweroff or reboot, but it leaves no
trace of that decision in the log. If the resume path later fails or
hangs, the tester cannot tell which outcome was requested, so a report
of "S4 rebooted instead of powering off" cannot be attributed to
configuration or to platform behavior.

Append the mode name to the existing "hibernation entry" message, so
that line reads "hibernation entry (reboot)", "hibernation entry
(shutdown)" or "hibernation entry (suspend)" instead of a bare
"hibernation entry". The name comes from hibernation_mode, the same
value power_down() later switches on (1 = platform, 2 = shutdown,
3 = reboot, 4 = suspend).

No functional change.

Signed-off-by: Yongxin Yang <yangyongxin@kylinos.cn>
---
 kernel/power/hibernate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e365e440cd52..2a285d29cbe3 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -794,7 +794,14 @@ int hibernate(void)
 		goto Unlock;
 	}
 
-	pr_info("hibernation entry\n");
+	pr_info("hibernation entry (%s)\n",
+		hibernation_mode == HIBERNATION_REBOOT ? "reboot" :
+		hibernation_mode == HIBERNATION_PLATFORM ? "platform" :
+#ifdef CONFIG_SUSPEND
+		hibernation_mode == HIBERNATION_SUSPEND ? "suspend" :
+#endif
+		hibernation_mode == HIBERNATION_TEST_RESUME ? "test_resume" :
+		"shutdown");
 	pm_prepare_console();
 	error = pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, PM_POST_HIBERNATION);
 	if (error)
-- 
2.25.1

