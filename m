Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D482840C5AE
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879474; cv=none; b=X/tNfy04VfsBQAV8Pmjlh5U11Lzc22qZIqMyMJg714CXGPb7q/S9cCbxaJP0xlTql6eeR+nFHnwj5xRB/9qdWoyOW7CYhUWVe93EPKJwtL50aQhRTarxj6510wVQRgDoTZnFvlod8ddN9hWTW84THGPvLWoU+oddBmWx48cPl5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879474; c=relaxed/simple;
	bh=4W+k8yJOECfAI1CDMz7pSqOwHCKZSXvVNeXVPxahV0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oQNV3BjboktlS2pcDA26qp4VHtoT8C+3MSvi9pRWuWK6rtHT0xyXiWbwB6WGMo5Gi++rFXoi5y8oJLFb8pz52Q1VEWZUyGsMzMUVEnlqfph19FO8XLYN/hmNrk7mzJmYMwhABHufMkHAfq1JO5EOntfsRfB+1dnIoTp8hdP+fuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=u0zFSYq8; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=l1AqNmJ5; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="u0zFSYq8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="l1AqNmJ5"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hF6Mq5BCxzMlHw;
	Tue, 04 Aug 2026 23:37:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785879463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TPga+f9oik5jadrf4X+EnBal54d9aEA0mYgBLCA8Zls=;
	b=u0zFSYq8ciV6v4IjjcdakyEE2/uV3LAsof+YRRSA+KbhaAElEr+tFX8xsNrLQ4WYOU7OKO
	7ByGBTqvDtr01KzeI2UKOnuETriODpa8Kp/yJGNPOkgZJP04Qrl5vqofBF8bl2lDqG+WwX
	vfJaM5s0gmhSCN4hbs0Gx8LdIiNlvuuycC0PZxBZbd0sjP4F3EgK8F/JHy77NGg5k5h73t
	XepuYn4Q0aXhbH11DM7vfBaTKBO7SWyptP+R+RnMNkDs9DZ5af7EIr2MYsQVmqD5+uPY7b
	4iuTn9t5az0ZXVS4BYEvBzc6VBdQh3FnIq0fBnhq6Xa7NURzTLHDUY91C+ug0w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785879462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TPga+f9oik5jadrf4X+EnBal54d9aEA0mYgBLCA8Zls=;
	b=l1AqNmJ5cWrLoPfhKWwgMPWjZWeDJiloAyNo+egLRz/wgaWgGdacQXR9hrASDRgkJkGI1E
	QoBfSzIJUMooaii/eQKFPJ/CN5yJ7PZAUPLogzlyfsdNRhnTs8r2rnQDk6+GEVbDwVsEIf
	MJTGZEEd0+d43kFUtMFKPd48b5PTmvDIb1mZ8LUlHQ53osXIhG7bzy7ZjvetirVMm+8H/6
	w/mGs6LRDFQ+nwf+pWT2rOy6dtYCXwUv6wQvVxpDtn9NcdKRaG9sZ7k4T/Pd2TAxSZ/5wa
	recEsfZUPh8tK4wM2lZ9JAinLNB8mxu6t/M3wxf3UJTCSO5PG3RK83aoNUg6+w==
To: linux-pm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] thermal/of: Fix trivial enabled typo
Date: Tue,  4 Aug 2026 23:37:15 +0200
Message-ID: <20260804213738.287818-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 67t78njz8p6fkj9dgzqso7gtto6zd3kn
X-MBO-RS-ID: 35fa7f423f3964dcdce

Fix trivial typo, s@enabled@enable@. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/thermal/thermal_of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 100fd8a0c8cec..0217a49b08ae3 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -444,7 +444,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 
 	ret = thermal_zone_device_enable(tz);
 	if (ret) {
-		pr_err("Failed to enabled thermal zone '%s', id=%d: %d\n",
+		pr_err("Failed to enable thermal zone '%s', id=%d: %d\n",
 		       tz->type, tz->id, ret);
 		thermal_of_zone_unregister(tz);
 		return ERR_PTR(ret);
-- 
2.53.0

