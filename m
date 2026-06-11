Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EA02BDC05
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 03:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781148860; cv=none; b=NjeKt+cHSO2H2AIhijohIjo8k2cR2Mjbv5cP150xDrdehKPH8JMoyE3Wa2o+N99Uv66WaB0gI2+lpL3tzM1dfCI4prGrZaiCfF8wx/Y/XPHm+uBqNpXhlJSUR+zPw/nuX44o2fKUHSYnu3bJt49G7sf6LY5Wt43K0zlQdbKEaTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781148860; c=relaxed/simple;
	bh=s2a+j1yy7vmag8cwdRfPhDMS3bQcmK1l0CQ/682UqL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rkb3wZg3X0e6O2MBNYC71RbDpzVyCEUbxjRXvxIMuzFJ6lgO3jwdzTAcdnKHnzDgRXiBZTwXmoSCj/KE2mgoAua0TbAG6DxcB+9nPqeStJksoiuhG9No/HPVE12/KZhb8ehU87BcfdXjTjiUbj/wwtbAsf/ys3rtjzCLmt6rNvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=eQvd7XRO; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="eQvd7XRO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781148839;
	bh=zn9RBMe1JH6HMz3r989MZ/l8EKz+FrAkhOUiuaUqI6w=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=eQvd7XROWqRp1qPHsb4bArzqDjnRTv9d8sF0e2WDcdww4lZ2V0Lyo95qHbpuQumPj
	 A5pme8CgoLbuq/8S7/MuLXUjH654YHeLsBmdzWDx5ktmsX/azq4/6ZKdZri/mKqNem
	 UK0nRfax874ogau2L7qkHbloDUzkP4LlN3OnjE1A=
X-QQ-mid: esmtpsz19t1781148824tf85dc437
X-QQ-Originating-IP: BezGvKfB8SRZrfkgfNaWTp2BA+HLIvtMqFs8oTOeCmU=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 11 Jun 2026 11:32:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1270585647669996537
EX-QQ-RecipientCnt: 5
From: ankun <ankun@uniontech.com>
To: rafael@kernel.org
Cc: pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	ankun <ankun@uniontech.com>
Subject: [PATCH] PM: Avoid TOCTOU race in pm_wakeup_irq_show()
Date: Thu, 11 Jun 2026 11:32:13 +0800
Message-Id: <20260611033213.11252-1-ankun@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: N4bM8lGVinchGFhE+/GCO4uAvSQMQOtnuGGYAXUa2PW/fxN1A/jW63d9
	8LE3UCrGP1UAWHc4VRY3NfOlF/GrERh+WPzkwBfxVenMMYDtOoVUswSTma0afes4qJkohQk
	plnQpMa3E/XPjfDQkBhUkmqUq6CRWWmixYJ6IrQITM2j1UV4odpRrC+6juBNEayQV4g5Mux
	e1ClY8Zal8um82Ws+tDSm+8Sqef1nkjvlDDe4/eSkg2ShjoLjCHMERLgqRru/IiEkNydQB9
	e/BMq1m2mC0ARvdDmDLEQckPmrrccykocSlFoPwdgfgjkjUYP+Evp58H67M1j1ccE0w5k5e
	GWKNjG/4LAYNaMUCxAUjIDSl5kFLXuecNiVevvczqieUl/VicroXXnqJuzl2W30SloLptAe
	ycsdRUeSryuHIMDPOrSKC9Mlf61CWarx63kRCmKfyvOtKRgpzzzYtFXOqkj9QsgExlqd0gf
	PJFGoNp/SGH5d4gidrln7ghMKJ4qm6fsDMNscy6tKr1gHBjF1d4nJqql/dF9rSXvFNzwe8y
	aKk6Y7g5lzQO0NA49KCLMl21DSmXP+HK0Gve2UiOraEYaWfsPkVWvh5yYxIhK/VESDtZwkm
	vHeKbs0rDjjfCfvS6W0wbqY24xK7aDszEiBM6Ro6DHIxsDJK4d9jayiVHejSms0MEMrluG4
	vQYtMGT10+ZuzKbrntKD1fn9D51fMhoAQcTd5Z4wavrqf872YweNAFxfhcTZMK3MTHz1QGs
	KRSYc85fruGHoUOeP0xXVywboQNe9ZlVwKdtfgQETdhgCQnVK+RTueVtRcJmcvYXHY89PC3
	Gw75J3L6fs2a8vOffq1ZR/ihWy85Dt4GklSpg7Bv23Qr7B3R3Xz15SpXWx6b7axSTLimXQ4
	AGjLRa9bSWHKGLrqLoq3rm+Q3+gq6XQoWF6nTskomLeghKdknGKvZjW024uPR6LhKxeJLUH
	FWoqc8LprzyDfHLPxnm8bzEwDLBytgozOdmye9WLoub5HdZC+Hn29/ODe45Nk0zeDV4YDSv
	Hee9pMP9D3m1oDqe8ikCCZYdl5KIM=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

pm_wakeup_irq_show() reads the global pm_wakeup_irq variable twice:
first to check if it is zero (returning -ENODATA if so), and then again
to format the value for sysfs output. Between these two calls, the
wakeup IRQ could be cleared (e.g. by writing 0 to the same sysfs file),
leading to a time-of-check-to-time-of-use race. The result may be a
printed value of 0 despite the check having passed, or other
inconsistencies.

Cache the value in a local variable after a single read, and use that
for both the check and the output. This closes the race window and
makes the operation atomic from the caller's perspective.

Signed-off-by: ankun <ankun@uniontech.com>
---
 kernel/power/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 5429e9f19b65..08a25117e38c 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -683,10 +683,12 @@ static ssize_t pm_wakeup_irq_show(struct kobject *kobj,
 					struct kobj_attribute *attr,
 					char *buf)
 {
-	if (!pm_wakeup_irq())
+	unsigned int irq = pm_wakeup_irq();
+
+	if (!irq)
 		return -ENODATA;

-	return sysfs_emit(buf, "%u\n", pm_wakeup_irq());
+	return sysfs_emit(buf, "%u\n", irq);
 }

 power_attr_ro(pm_wakeup_irq);
--
2.20.1

