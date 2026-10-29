Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264465;
	b=WlsGf+d83rstCYCO4OcGJK/jvDBZeaUiX4r0BmAXZXXaWai6nptyYYPks26Ou6IxJceC
	 neKYMHge8qlhnYnwesGVRScQF5lAp7GZJbbs/iqtStmN3YgVDKmaxjmVeClL2GqtgP9O/
	 pWfwLkeX8GLYFLFVk5HFSqTq0nzCrVfbBtHbU7362jITO7c/bwNj/gnl7mGFDaoeJ3oEI
	 eAGJp/3x87t3Hx7Qn8ut6xfdf1WZfqjuP9KG4DIDhvQj5OUAZe9i8ppg4M5tHuCgQjIZO
	 V6+lfq4up8TTdmiPmFu9t3SDC31dP1lGmujsW6GivQqzUCe1YBH19BrrXEBW1/1QSQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Z3mbcZY+neJw3cJUW+gndo2WA1VaXIZUfre4RITk+7k=;
	b=ihiQyDvKzMFa22DcMs1acQx9CK5GL7OkkW/ha0tk9rbOxRX/q88tRqIe+6NyFqUUcRCx
	 c4hxsPHQKtr7fIEzk/D6wqTf++aLIiXMKcsXsRsQaI+Iuz9MB/W9+dG08T4OFYAvwpiWK
	 5W1ReUc1DFOlcd5umwA4qSXRBrt8lbatyjiG0xCLAcG3/ZLaKPpVuMtfcKtevWOFTslLw
	 41nxQIr7o5TNlZnZN8l1Cs9YCOr+RqKF2qUokkywvOpCS/5B5YbtAP1xfWCC9gwy5XaqY
	 M1aMBJs9Yd3j8H3dSHbDPt6UEZuRFvoDqNZEdHC6E9X3dfnre7SGyxe/oIaa8qv/RCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TCcGnNUJ;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD49606A324
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CD49606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TCcGnNUJ
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36a1947498bso1261393eec.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 02:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264465; x=1793869265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z3mbcZY+neJw3cJUW+gndo2WA1VaXIZUfre4RITk+7k=;
        b=TCcGnNUJc9rE3+MU2dfBg1/buLqpvuGZpYCZpTH5anu5u+ZMXaHl9K3FX4AOJa36iE
         SHLYuQ8VH7B/b7kK8397LfdltoUH5e6q2jo++wZvHhNr1Kqx2KiiJVNWv++16GSYeXQH
         t6Ww3ttl7Q+94LDcf7q0QvjHrUAXJfa/V7tBTLTrruB4gSw/g97V32iMOOU0Sm9ERl9S
         4MGRGzLa94oKF7jIl1QFcE66oOfgguRO0RAazo4KhivQuQbL7hiPIbc7D/5wupmrnu67
         NZ2ljq3nvkvPLFUrnS/YtgabfHFLNHyNR8ZRtyhzh7sH9L0c+OWsajyMQ2UolEIrFD08
         PAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264465; x=1793869265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z3mbcZY+neJw3cJUW+gndo2WA1VaXIZUfre4RITk+7k=;
        b=gO/4xA1KIsK/a48p7sx69ABFXLgd+CUua52gHh5XRnE2dNMWIuJEvvZKMSJCpa9gZn
         j8mjVZ+cjS+8+bj9u06vJqkGGT60O3/7lCQmdYxq48cwhv3fSVbX7bTXHYOH4ruhCpst
         2nzHSQKMIt6ySsv5nXhlu7NUmZ+3+BAJQz8wSLSMiuK/4PWvik8neM+FT45XOatk6bre
         Dj9vUaJ+LczvOKd/YTukVwfFW5WwuNkKX3caFuy8vwJt/mdQnGtkn/+iVef1D4gIRlM9
         RoIHQ/C1BotSyQOUvfPQ1L3hhlnx0DiWhuhRhBD8639dbre187ogAo+O8cf2rJFdIaia
         DkTA==
X-Forwarded-Encrypted: i=1; AKwUvBwwST8ty0gSndESX9WoUzpfdYjXJgbuqj3RP4o9ryOblJer7Fj4dSk2x3cZKZqIu/TBV1xENybHQA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJXKqw87ggi5CdIXUecTrYjeWrYMlLtQdU5b/0d/CwYuUC9MF1C
	JM0DGO8wjsFXio3dT/P+pRJymHL8zkdnH7t2Mnp1D5vocLONAygex0w=
X-Gm-Gg: AYBFou0XkGysPFZVi1pt13LT7eFf0vXOPkGRdiUZdYM3kdOovkoGsphaiWDk3jSanuT
	J6MG933M5QSd12XZtFLPIpvVBNR8UZO7gYQNe15VIwdOmEzjy86k0tWauB5ZorN3sTs6NdexlBI
	CY+9BlmKwIDVXmy9g9Nz7qUAu54qTlqumjEGnLe1a6OJpCMX8rr5VRM9Y37ZnK6atxokXL3k/G+
	QRObfhAoAyYNfOMNS63m+XTnRCXNnEjWWLafgYY5r5YwkZKqaxP0vn75iKA7F4s5eZNlOqJfCHl
	5Q7GY0wAJvX6zUNxVSF3053a1y2VWKRQ000jbIhYXWmP/5Gzbd/C2Ql3OKXVXaPHACgJbp3RjJB
	2mRthsRwgy0t/HP8EDIlEkaP9IDyR736LIVxGWweJcbW2RlkJ95ZvM9jtZJNrWLfzXk+guDBN/4
	11qZ/b5aA9lnWb5ZSkA8A7HC+OR2cF4oQLaV5XbvOeJ7VMAtfyDQBmaKL1fy8H6F1lVDYGtkjeN
	O9qMO5V1wnQycw+gm55mRI8VKtilMtSdW4jGiW5rSdz0qUTqjXGwrdElh/SkfIMsuYNmvAn+zGB
	XTp8Jf/oYRnjEqSoCkk/VxDSlQScqA3+wTk0Il4/D0NOwkDqBA8Yikk3g34S5A==
X-Received: by 2002:a05:7300:f894:b0:351:207d:bff4 with SMTP id 5a478bee46e88-36a202bc360mr7083860eec.4.1793264464275;
        Thu, 29 Oct 2026 02:01:04 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.20.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23641e78sm16497937eec.0.2026.10.29.02.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:01:03 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	mfd@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 11/14] acpi: disable battery and adapter for x86 apple machines
Date: Thu, 29 Oct 2026 04:52:08 -0400
Message-ID: <20261029085504.3547-12-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When macsmc-power is enabled on an Intel Mac, skip acpi-sbs
and the ACPI battery and adapter drivers, since macsmc-power
now provides them. This avoids duplicate devices.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/acpi/sbs.c       | 17 +++++++++--------
 drivers/acpi/x86/utils.c |  4 ++++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index f10bbf13c..b12f2acc0 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -634,6 +634,9 @@ static int acpi_sbs_probe(struct platform_device *pdev)
 	int result = 0;
 	int id;
 
+	if (IS_ENABLED(CONFIG_MACSMC_POWER) && x86_apple_machine)
+		return -ENODEV;
+
 	device = ACPI_COMPANION(&pdev->dev);
 	if (!device)
 		return -ENODEV;
@@ -655,14 +658,12 @@ static int acpi_sbs_probe(struct platform_device *pdev)
 
 	result = 0;
 
-	if (!x86_apple_machine) {
-		result = acpi_manager_get_info(sbs);
-		if (!result) {
-			sbs->manager_present = 1;
-			for (id = 0; id < MAX_SBS_BAT; ++id)
-				if ((sbs->batteries_supported & (1 << id)))
-					acpi_battery_add(sbs, id);
-		}
+	result = acpi_manager_get_info(sbs);
+	if (!result) {
+		sbs->manager_present = 1;
+		for (id = 0; id < MAX_SBS_BAT; ++id)
+			if ((sbs->batteries_supported & (1 << id)))
+				acpi_battery_add(sbs, id);
 	}
 
 	if (!sbs->manager_present)
diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 418951639..9f3b9b7d9 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -14,6 +14,7 @@
 #include <linux/dmi.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/x86/apple.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include "../internal.h"
@@ -608,6 +609,9 @@ bool acpi_quirk_skip_acpi_ac_and_battery(void)
 	long quirks = 0;
 	int i;
 
+	if (IS_ENABLED(CONFIG_MACSMC_POWER) && x86_apple_machine)
+		return true;
+
 	dmi_id = dmi_first_match(acpi_quirk_skip_dmi_ids);
 	if (dmi_id)
 		quirks = (unsigned long)dmi_id->driver_data;
-- 
2.55.0

