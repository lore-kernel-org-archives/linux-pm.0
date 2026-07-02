Received: from forward203a.mail.yandex.net (forward203a.mail.yandex.net [178.154.239.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E048D318EDA
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008510; cv=none; b=UEPFfzpo9aOmVmjl39/4Z5d9P4qblWYvalsjweoEgnW89Rl/XiPkGdtsAwrJO1Rz3edi7Tcth7Zde1QhpwMjOGEsL3bXNQyaX5TV5FvT5hN7l13vS2bQnmccq+q3gfET6rOISu4EeRV8cNuBHzIrGP4SNmV5umLiPffHbkGpua0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008510; c=relaxed/simple;
	bh=NQ3fp+9rUcQbyamzvkuDvoIdVQbexW3B7gF24N2kQlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZWz1Jk2ILJyT43tZluSivIpFBBu5BPygFVUu0+XQ6g6fyb1CR0X808+spIeW8tP4J3zmAyRLGVnAb3YnYFJHNb6eoegR3Cr3XY6ez1qRUEv4w4npvM2y7aXytBX+pFvbd7YwacpEX/HlYu1X9o4b2V1yamNQU1YZcOPnHtR2oEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=FXsfJksj; arc=none smtp.client-ip=178.154.239.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="FXsfJksj"
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
	by forward203a.mail.yandex.net (postfix) with ESMTPS id DF21186B81
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 19:08:17 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:3388:0:640:154:0])
	by forward101a.mail.yandex.net (postfix) with ESMTPS id EA25880729;
	Thu, 02 Jul 2026 19:08:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (smtp) with ESMTPSA id 68jpSWDgRGk0-P307luuP;
	Thu, 02 Jul 2026 19:08:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1783008488; bh=nIAO2JMDm8zmWo5zU/mtRghbaV8XPNzO4zOfujxRXbM=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=FXsfJksj1OAuCd7H2N35iyfcLd1SEw+/DQXh+VD1qC7ravIeWBfhhs5NPQPrVZiJ2
	 DVx+qm1iFuY2jr6Y9KlHgbkFKuIKe9Dwl50ZHl9uIX3eoQkY22czsFY/JJyxnq4QCu
	 ejEYwvVVxQ96Gy4sGwUvjr0r9RJO3PrZq1fDp0mQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] thermal: intel: int340x: simplify ptc_temperature_write()
Date: Thu,  2 Jul 2026 19:02:40 +0300
Message-ID: <20260702160240.2929965-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify 'ptc_temperature_write()' by using the convenient
'kstrtou32_from_user()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../int340x_thermal/platform_temperature_control.c  | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c b/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
index d92a6f84a778..43cb809c5dcc 100644
--- a/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
+++ b/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
@@ -227,17 +227,12 @@ static ssize_t ptc_temperature_write(struct file *file, const char __user *data,
 {
 	struct ptc_data *ptc_instance = file->private_data;
 	struct pci_dev *pdev = ptc_instance->pdev;
-	char buf[32];
-	ssize_t len;
 	u32 value;
+	int ret;
 
-	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, data, len))
-		return -EFAULT;
-
-	buf[len] = '\0';
-	if (kstrtouint(buf, 0, &value))
-		return -EINVAL;
+	ret = kstrtou32_from_user(data, count, 0, &value);
+	if (unlikely(ret))
+		return ret;
 
 	if (ptc_mmio_regs[PTC_TEMP_OVERRIDE_INDEX].units)
 		value /= ptc_mmio_regs[PTC_TEMP_OVERRIDE_INDEX].units;
-- 
2.55.0

