Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9993BE14A;
	Sat, 10 Oct 2026 03:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791602366; cv=none; b=kIWNXXyPsCL3PPrU5zMXoBRE1aIRUXreOQ83vGEdepol9GphwXdjPdD8BehEsBeODyhHt+5NZVmGwnplJe5biNgKiDxN21b/47npnd2YNMIC62wB5U3PrX/tfkpJCXSHBcSv8DyPGfN6z5N5xs97jd+O3vBS0DK+0mhxRZxxO5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791602366; c=relaxed/simple;
	bh=4RgnYGWTiZ6NF+FHxeyKwroRsPSRbAkubHI0lZQNQa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RuJc9nRI2euhD/wprJIIJeDoVj3+9Tazsh+e3q8UlqC0r6UdU8yY1A5MfSoE4XnDoR3GnqfnNtUwgtL66OzQTpm9BLjKYvXTie0EfMQ2riklqWPj1GssF6rRZCBOF3YuWkR8G3hzuG8elDhGqK91YSAkduFtUKWj/FJM3uUnll0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LwQf68Rb; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LwQf68Rb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nN
	MA+WC0KzuZnR5EnT8J/gdZZ2/cKp32vYMWHBSf1nc=; b=LwQf68RbHgCdUgFykq
	fE3dj87tLef+e8gfF/qBDAU7KN6DvBCtqGCERLbYoJxHnWSnktM7yOgjSNfRG0jR
	qmyKaiJtkibnB3sJAewgj7o9JpT8e7CvIFiv1ZzogCJY9pXWgGllI7c46YL18sWF
	0Kh9mHCahNR9UmSEfTYcz5E+0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnT6Wrrslqc_cnDw--.19732S2;
	Sat, 10 Oct 2026 11:19:08 +0800 (CST)
From: Yongxin Yang <yangyongxin@kylinos.cn>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	pavel@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yongxin Yang <yangyongxin@kylinos.cn>
Subject: [PATCH] PM: hibernate: Log hibernation mode at S4 entry
Date: Sat, 10 Oct 2026 11:19:03 +0800
Message-Id: <20261010031903.123484-1-yangyongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnT6Wrrslqc_cnDw--.19732S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW3JF1DurW5ArW7JF4UCFg_yoW8XFW8pr
	yqgrs7Ja9rX3W2y3W0qFy8JF98Z39agw45JFnrWrZrArn2qa9Yya1SgF109rWjk34xta1S
	qF4qv34DJF47uF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Udu4UUUUUU=
Sender: yang_yongxin123@163.com
X-CM-SenderInfo: 51dqwsp1rqw5tlqrjji6rwjhhfrp/xtbC5AzjgWrJrqwSZgAA3f

The S4 path is the only place where the kernel decides whether a
completed image write ends in poweroff or reboot, but it leaves no
trace of that decision in the log. If the resume path later fails or
hangs, the tester cannot tell which outcome was requested, so a report
of "S4 rebooted instead of powering off" cannot be attributed to
configuration or to platform behavior.

Append the mode name to the existing "hibernation entry" message, so
that line reads "hibernation entry (reboot)" or "hibernation entry
(shutdown)" instead of a bare "hibernation entry". The name comes from
hibernation_mode, the same value power_down() later switches on
(1 = platform, 2 = shutdown, 3 = reboot).

No functional change.

Signed-off-by: Yongxin Yang <yangyongxin@kylinos.cn>
---
 kernel/power/hibernate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e365e440cd52..92808832a9ba 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -794,7 +794,11 @@ int hibernate(void)
 		goto Unlock;
 	}
 
-	pr_info("hibernation entry\n");
+	pr_info("hibernation entry (%s)\n",
+		hibernation_mode == HIBERNATION_REBOOT ? "reboot" :
+		hibernation_mode == HIBERNATION_PLATFORM ? "platform" :
+		hibernation_mode == HIBERNATION_TEST_RESUME ? "test_resume" :
+		"shutdown");
 	pm_prepare_console();
 	error = pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, PM_POST_HIBERNATION);
 	if (error)
-- 
2.25.1

