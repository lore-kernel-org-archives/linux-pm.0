Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE81F2EBB8C;
	Wed, 24 Jun 2026 05:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782279560; cv=none; b=J6Uc4u1JKJ7UuRM5yvAvRUV3maJ7J/y0AFXNY0ZP258INp2Do+WWsJR45E7Y6nDQZeS18DbLzSOMLUIPd3SQIvu15PQ1bnUHmONB2Vs5LA2AA7+6Gq3oL9NJQQnK2L3y0sNNjNZ//iCe+z94S4Ac99x40EZjb3S9y0/fx/Yg6/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782279560; c=relaxed/simple;
	bh=3V49h+s7WGoHtx/AH+44KmIGRG/gBbObi9EoGXvbjfU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eZauqq52uo8vysQGkcYPbpUJrYh+1Cb8czW90ckrapGBGPElZkQJ4OqJA/ECA5JiYa4uN2cbvkvtcTV3PQejm4Bk7uFd4n705gTqs8Y7NjRLg18SBpWc0V8c3PTGR/AfE2dgDuHr7kd/9YP+/A5jPwwwhBujJ4lAYvKfVc4K2gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hn4YzEaF; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="hn4YzEaF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782279534;
	bh=xGipAegcs2tM6sL22i/ARJjGvvdlBGHWO13FPjPUA20=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=hn4YzEaFOYZ9nE8LWWPbUXoyrxqUFJjGF3G3INJbj8XMzHO/7KaxJlBBYEB341ucP
	 m3Dp/1ccioFSSfKd1/XrAlOQrR6IxUYdVOmG1Ki5b/slXqVJCr/KdtbqhEXTIzmtqF
	 47Yox4qrCpkRKgUyT3AaGtZ/b37BrCgbLvdnt/1g=
X-QQ-mid: zesmtpsz6t1782279524t88fa8540
X-QQ-Originating-IP: pyR2xeITrCe5B7LjDY+48bJJOk3bykD2Q+nKvBre8m4=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Jun 2026 13:38:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8782820033205812087
EX-QQ-RecipientCnt: 7
From: Haowen Tu <tuhaowen@uniontech.com>
To: rafael@kernel.org
Cc: pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@uniontech.com,
	Haowen Tu <tuhaowen@uniontech.com>
Subject: [PATCH] PM: wakelocks: Fix off-by-one in wakeup source limit
Date: Wed, 24 Jun 2026 13:38:39 +0800
Message-Id: <20260624053839.2150567-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OOE4uoWbaTrH0IxSwKG0sbXbnAeqeXTU58aN3nGoWdJsGuw5wWbqrlsu
	UqEb075ofAMxyQimbY+yLCi3XA53Lmeqh0ojeHXgOkMqcC9fyPUWilC9MUUS+q35BZIyn75
	yx2ak2HI+ZDCfe11jyb1UjWkcXB71LhqMOuHQQVH0RW7osLOSyzyb+7tdpkUn/dcZqhmXz7
	fCajzi/68O/+svWakZZkUlw5Fjb92luZxqPT4OEjZdiPFMp0pb215jWvCZE6OBFEo6W1GYt
	qk8NioRdRKzkfEFKNQCSGJBeuO82bxaS7xkJalHqb5j+Fo9wwiX5r30/gYXcIfseZJtg9GR
	1iqjU5oo4orDNybB7tkqE5qhyZU6iYomhYDcy+eh+45M6nxS39+WgKTQTED/j2zW/SlZ6jz
	j/e+EIZX6ayFsT1m4MXKFAaKpbiv7pJEH77faum9dprWJ/9wlwFTXnuXbI8hGgG1yA5Zu6f
	yJeeCRA1BoniP1ZOcuBzj0va0j2p5CiVCzWgRPZT7U3lTt7SBn0hIdZwrMQmMEtWBoWMwkQ
	2rgAgSUJkWq/F44jLggjXZYx59Qz6zC2vAAcp8LK2im6YThFbLIy7vn1Ga01FLtslVJXF6b
	YtCrPMZ/p3V1nNuDVinhAw4nsF0Il1iCgyXU1wY+XKMGPnENiqXWMz8rDZKBiJrvH/3Hs8T
	n+KDJSA8GL7b2O9sQXNpZHVTQD/alctkPtOEAUZKfh+UbBYzLB1BQhHM+WudjDMVhStkysd
	m4f8RrdXUIncYjFaOWLsuxQUsMT88fEmMhUedvPpr/hY3ST8IPK/c3Bj84dedzHuO5DKyDL
	3/c36fGIZ0S1kJ7d0ADvkzp+zM+XJ4F5WpD4bps3rqQ5Xm4z6fxHlnYZWISr8It5ZjDNkDw
	omKXhftJRXttlHl4Mb7v705tkYytfhH0u+SJSnNnuebP369Y7Cvr+dwTuhIn+OxQt0kefuA
	p+cJYtsAQ7PD+53U5gjCtjD1rrTKGMuWmvbAGhdCY4wfP96JdTMTeMUllnNVy6FRN0v1R6y
	YFsMW5ym+A2/Pf2KNyxNd5YmyjR0WRzvQKTz4ogAd7rH5eOkzn2jytzLc1v4M=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

CONFIG_PM_WAKELOCKS_LIMIT is documented as the maximum number of
user-space wakeup sources. However, the limit check is performed before
the counter is incremented and only rejects new wakeup sources when the
current number is greater than the limit. This allows one extra wakeup
source to be created.

Reject new wakeup sources once the counter has reached the limit.

Fixes: b86ff9820fd5 ("PM / Sleep: Add user space interface for manipulating wakeup sources, v3")
Signed-off-by: Haowen Tu <tuhaowen@uniontech.com>
---
 kernel/power/wakelock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
index fd763da06a87..a8b6bd5ec46b 100644
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -63,7 +63,7 @@ static unsigned int number_of_wakelocks;
 
 static inline bool wakelocks_limit_exceeded(void)
 {
-	return number_of_wakelocks > CONFIG_PM_WAKELOCKS_LIMIT;
+	return number_of_wakelocks >= CONFIG_PM_WAKELOCKS_LIMIT;
 }
 
 static inline void increment_wakelocks_number(void)
-- 
2.20.1

