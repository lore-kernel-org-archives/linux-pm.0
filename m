Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E91EDA32;
	Wed,  4 Mar 2026 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648222; cv=none; b=Y/o/ilzd+MZg2L47shXs+hLRd36rdlYggHl2xtpooTb1AtGUJTPncLDVjUr3HcyVbNdLWpVuJk6Sq/bWWiHDetjFVq2tGNkQuPyGK/67FsABhZkNgL3unlQX9kOS9j7pLcTVrh7ytvB0vH81zuhvrqHX+Nl+eOtLmXSSnEEEuqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648222; c=relaxed/simple;
	bh=u5w8JFVQh9V063Ayn3LoWkO1eI87LCfsVRka5iu9rx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIx9UadUxm68cNvyxLEgoWUIYM6C3tuje0X5vWMP7PEDBkpy7o7c5YWoSDBmXrBd3b/bZuxPRe/ebi2GgCtSbLFWE15mNlj9Icmam7evKgHfnRzmWdPXknm8w0dcJ9idICOzEC4YNTHQoVG2JzpIc6/JUGGZZLHnzBRBAwnWD74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmQn7JL6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmQn7JL6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44EDC4CEF7;
	Wed,  4 Mar 2026 18:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772648222;
	bh=u5w8JFVQh9V063Ayn3LoWkO1eI87LCfsVRka5iu9rx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DmQn7JL6Eu/+0RmDoHMDzYFbdBP3JiJZgE/qxYJJkMe+PS5Mvmw9yalL5oA36+l/B
	 uYzOyxxDlkDFz0cfpga186fW/p6TlKFmi5k2YqhbjrQxfP860D5L5v+fYiQyPq2G2w
	 vfSvGztpVh0Y4f6Q83+JiMMoocY5FPdNrt47z6Dk4zsCtvoNaVLp6ExFo3TTBuMmLQ
	 ZQuJgqnR9IVPKolQABj+jaG77iSSMEWisxNeSyx2Pf9Kkt5RUdMIOXhdDklIWnQRJ8
	 p9ojUdfqi96bGA4393kdQMHqqHJmQyR7b8sI5Xbf3WcvuliENYR81YwU/HlcI5hO+m
	 93EiyjTWcxdpA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-rtc@vger.kernel.org,
 Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v1 7/7] ACPI: TAD: Update the driver description comment
Date: Wed, 04 Mar 2026 19:16:48 +0100
Message-ID: <23034847.EfDdHjke4D@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5092662.31r3eYUQgx@rafael.j.wysocki>
References: <5092662.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Update the preamble comment describing the driver to match the code
after previous changes along with the copyright information.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -2,12 +2,10 @@
 /*
  * ACPI Time and Alarm (TAD) Device Driver
  *
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018 - 2026 Intel Corporation
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  *
- * This driver is based on Section 9.18 of the ACPI 6.2 specification revision.
- *
- * It only supports the system wakeup capabilities of the TAD.
+ * This driver is based on ACPI 6.6, Section 9.17.
  *
  * Provided are sysfs attributes, available under the TAD platform device,
  * allowing user space to manage the AC and DC wakeup timers of the TAD:
@@ -18,6 +16,11 @@
  *
  * The wakeup events handling and power management of the TAD is expected to
  * be taken care of by the ACPI PM domain attached to its platform device.
+ *
+ * If the TAD supports the get/set real time features, as indicated by the
+ * capability mask returned by _GCP under the TAD object, additional sysfs
+ * attributes are created allowing the real time to be set and read and an RTC
+ * class device is registered under the TAD platform device.
  */
 
 #include <linux/acpi.h>
@@ -32,7 +35,7 @@ MODULE_DESCRIPTION("ACPI Time and Alarm
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Rafael J. Wysocki");
 
-/* ACPI TAD capability flags (ACPI 6.2, Section 9.18.2) */
+/* ACPI TAD capability flags (ACPI 6.6, Section 9.17.2) */
 #define ACPI_TAD_AC_WAKE	BIT(0)
 #define ACPI_TAD_DC_WAKE	BIT(1)
 #define ACPI_TAD_RT		BIT(2)



