Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B341C695;
	Mon, 21 Sep 2026 06:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789972981; cv=none; b=bYUD54Vw5vcp4s250pthrE2at48cQSa1cgt2BpGFl8kvnaPOvvYp39OaEifRAWo/W4FXJUoZcNR35D+7hn2yz9nFFecGOlTthSCQPN/kRxksTdmuW5QN0biV/SRqTUbTkDNtAQBLQgP3dwB3MoXchbHBbF9ocfIjhKvhDRJqFws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789972981; c=relaxed/simple;
	bh=xheYWZwm84QazUB9TG8AYCFqTost28k3R1q9BvfBgsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ef7BAiH/GjyRORZzq2RynOLISsszZjaU+vzry5i2w+qngO3ltExSWsf5/WdsjSYVJW0RITih/8jUmxE1wB5GlV9lBKFI0Ud4ldqNTbgzRk558nqUjHY/BIoor9uN57xcVHYC3Zx+EfRJ6nmnbqMQqj2EbxNMl5ZPxDGZAWe/W1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=H3VTRiYT; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="H3VTRiYT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=s4n3l4U8YoT7N6BGdjVPFOln+aL9nFcoSNkd532a7Tk=;
	b=H3VTRiYT1Nj+l1YzvQHyUzAIKYmrhOcyUo8Twe/NHuj189vtJEXbuysHm+aa+s
	1xOYTBR8CtnJ/u376fzIBKJDnc53QMmBMzzlr1AhTz481S2BW6ajQcijOBqYDWEU
	6u+jJhCIGneFbtMQZwS5K0IRBjyzhwvB8Fs4QWNAu8SGg=
Received: from LAPTOP-EGO65D59.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD38j_R0bBqA8JWBw--.19491S2;
	Mon, 21 Sep 2026 14:42:29 +0800 (CST)
From: =?UTF-8?q?=E6=9E=97=E6=BF=AC=E5=93=B2?= <m18667909625@163.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m18667909625@163.com
Subject: [PATCH 2/2] PM: hibernate: use kstrtouint to parse resume= device numbers
Date: Mon, 21 Sep 2026 14:42:21 +0800
Message-ID: <20260921064221.81459-1-m18667909625@163.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD38j_R0bBqA8JWBw--.19491S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWrAr4UJFWfKF1UWF13twb_yoW8WryfpF
	WDAa98JrW7Aw4UGasruFs2vasIqw4kG3W3GFZ2qw4fAry7trnYqrs0gr1Ygry2qrWrW3Za
	qF45tws0qrW3GFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piYhF7UUUUU=
X-CM-SenderInfo: bpryllixzqmlisv6il2tof0z/xtbC-hVwdmqw0dV69gAA3-

simple_strtoul() is deprecated. Replace the base-16 parse with
kstrtouint(); the explicit trailing-character check the old code
needed is provided by kstrtouint() itself. As a side effect, values
wider than 32 bits are now rejected instead of being silently
truncated before the dev_t conversion.

Signed-off-by: 林濬哲 <m18667909625@163.com>
Assisted-by: AI coding assistant (disclosed per kernel AI guidelines)
---
 kernel/power/hibernate.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index d2479c69d71a..74f2d20518cc 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -14,6 +14,7 @@
 #include <crypto/acompress.h>
 #include <linux/blkdev.h>
 #include <linux/export.h>
+#include <linux/kstrtox.h>
 #include <linux/suspend.h>
 #include <linux/reboot.h>
 #include <linux/string.h>
@@ -1278,7 +1279,7 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 	error = lookup_bdev(name, &dev);
 	if (error) {
 		unsigned maj, min, offset;
-		char *p, dummy;
+		char dummy;
 
 		error = 0;
 		if (sscanf(name, "%u:%u%c", &maj, &min, &dummy) == 2 ||
@@ -1288,9 +1289,12 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 			if (maj != MAJOR(dev) || min != MINOR(dev))
 				error = -EINVAL;
 		} else {
-			dev = new_decode_dev(simple_strtoul(name, &p, 16));
-			if (*p)
+			unsigned int val;
+
+			if (kstrtouint(name, 16, &val))
 				error = -EINVAL;
+			else
+				dev = new_decode_dev(val);
 		}
 	}
 	kfree(name);
-- 
2.53.0

