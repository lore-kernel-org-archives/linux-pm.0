Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hUbws6al"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0239B19A;
	Wed, 29 Nov 2023 05:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=JYC5B10TWRchyHN96t
	T3YdbL8clZjtk6DHRMYsmi0FU=; b=hUbws6al1txBXOAkqAlg5bnYsvI364QoXN
	IfYGq7lJj3BGPXzQWwpy2Xfbok1hfV7Ig4amVik8uo6dBcOVYx5j1QX37ZCQTzaR
	NcCRs0HTglMB2buZmsEhfaSEregIS7JUJ5RVfUfk2L9hpl8x4Oi6CtE5at+nnnuM
	8ny92SM8k=
Received: from localhost.localdomain (unknown [39.144.190.126])
	by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wDXnxTnQGdlILsMCg--.42572S2;
	Wed, 29 Nov 2023 21:47:21 +0800 (CST)
From: Haoran Liu <liuhaoran14@163.com>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [power/reset] qnap-poweroff: Add error handling
Date: Wed, 29 Nov 2023 05:47:16 -0800
Message-Id: <20231129134716.34161-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDXnxTnQGdlILsMCg--.42572S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw4UAr13Zw4rCrWfXr1xuFg_yoWDurc_W3
	4fX34xXan7Kr1kCFsakF47ZrWxCF92vFn3Xr4IqFyfC345Ww1DJrWqqr17Ja4kX34UCrWD
	GFZ8Xr43CF1fZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRK73kUUUUUU==
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/xtbBcgc3gletj5TR4QABsQ
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

This patch introduces error handling for the of_match_node call
in the qnap_power_off_probe function within
drivers/power/reset/qnap-poweroff.c. Previously, there was no
check for a null return value from of_match_node, which could
lead to improper behavior if the device tree matching failed.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/power/reset/qnap-poweroff.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/power/reset/qnap-poweroff.c b/drivers/power/reset/qnap-poweroff.c
index 0ddf7f25f7b8..bc0b547211d6 100644
--- a/drivers/power/reset/qnap-poweroff.c
+++ b/drivers/power/reset/qnap-poweroff.c
@@ -77,6 +77,11 @@ static int qnap_power_off_probe(struct platform_device *pdev)
 
 	const struct of_device_id *match =
 		of_match_node(qnap_power_off_of_match_table, np);
+	if (!match) {
+		dev_err(&pdev->dev, "No matching device found\n");
+		return -ENODEV;
+	}
+
 	cfg = match->data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.17.1

