Return-Path: <SRS0=6BhR=SM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EFFC10F11
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 08:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30FF2084B
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 08:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mStHv7QU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbfDJIUu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:20:50 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32807 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbfDJIUt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2019 04:20:49 -0400
Received: by mail-lf1-f65.google.com with SMTP id j11so1139396lfm.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2019 01:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=49oAUcefl7Qs60t5vd0C3ulsmkkBE/5vo7x8P2YQaHM=;
        b=mStHv7QUTH9WDAupaSoNiNHXq56uKPHs6z21Ns4cq2pgt6lYuIwF2y1ydobFZDFkgN
         k46Q2SZP5ZgY7T277FQDd6kZnntXGYuzX9TiN6F5abjLive7ssOU6xL3aArZ7KC9+Dgo
         aHOYlHx4xjPDV3fLfRxyNPRR4uDwhdR/a8rh8vP21tjqnO8zoAHY12H2DkMr2VtjyBP9
         6MFFADfsLqamKiTq8M1UMjcQbDTzOITDphS+3jEsuZ9QAfSjZdz+Ay288jDWx9ePXqQa
         pgn8qz6S6UdQDq6t8JNpI4NkYKFB0Ufrc9RruysJpogLhp2ykoAua+bK1LHZf8NcjcuM
         7jZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=49oAUcefl7Qs60t5vd0C3ulsmkkBE/5vo7x8P2YQaHM=;
        b=pqrmLCjJkRhze5OyHWvnBwaIEZ3dZHa9HBwx2lICSi2nU/xYs/fk2xppft+qzydm2R
         CIL8gvdDAdjm8fgnj3Pwws93LYPNi/Q+4+pV9qR0MgIeEOLa9PPEMFZwaG7++Cpj3xO7
         QCf9khDULVAvaunFiRrbPfmiwPmYKZYa1h2YX6R0IDJzNCCfhU+AISBJEpsKEAhc9a5M
         AISC4a70Dvl/OHIlWb1rj3JgWFw2Uqv9iOgR+b7yNgPxaqjODv+k/hWMQz+wQNsZpkXP
         gABGvNDQJqUJab5Kd3phH5A158kFTQzQHGFbMNryBt/QY98PC3VKf5Za5PZw67AdP0hN
         +RFg==
X-Gm-Message-State: APjAAAVpnKmoO5QEEzsffO5Z/as5UPjb8VDVvpJYbh6BPVZs6AyDIvcT
        fV8etrCnqfF6VEjUOkvvvKHydQ==
X-Google-Smtp-Source: APXvYqwAQdMdf457/T9VKsq8AbW6qHKBEEhAwtd9AMaQ5kzkjyEFANj/vSnEWMDgy3/QbndrOfTM5w==
X-Received: by 2002:ac2:5222:: with SMTP id i2mr13231765lfl.32.1554884447978;
        Wed, 10 Apr 2019 01:20:47 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q6sm3385189lfj.36.2019.04.10.01.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 01:20:47 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v2 5/5] drivers: firmware: psci: Announce support for OS initiated suspend mode
Date:   Wed, 10 Apr 2019 10:20:25 +0200
Message-Id: <20190410082025.5989-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410082025.5989-1-ulf.hansson@linaro.org>
References: <20190410082025.5989-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410082025.JIiJqOQRKsB7Ebq57qWl-WuuGTQuonaYz5cnphTTqXQ@z>

PSCI firmware v1.0+, supports two different modes for CPU_SUSPEND. The
Platform Coordinated mode, which is the default and mandatory mode, while
support for the OS initiated (OSI) mode is optional.

In some cases it's interesting for the user/developer to know if the OSI
mode is supported by the PSCI FW. Therefore, let's print a message to the
log, if that is the case.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/firmware/psci/psci.c | 21 ++++++++++++++++++++-
 include/uapi/linux/psci.h    |  5 +++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index e480e0af632c..eabd01383cd6 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -95,6 +95,11 @@ static inline bool psci_has_ext_power_state(void)
 				PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK;
 }
 
+static inline bool psci_has_osi_support(void)
+{
+	return psci_cpu_suspend_feature & PSCI_1_0_OS_INITIATED;
+}
+
 static inline bool psci_power_state_loses_context(u32 state)
 {
 	const u32 mask = psci_has_ext_power_state() ?
@@ -659,10 +664,24 @@ static int __init psci_0_1_init(struct device_node *np)
 	return 0;
 }
 
+static int __init psci_1_0_init(struct device_node *np)
+{
+	int err;
+
+	err = psci_0_2_init(np);
+	if (err)
+		return err;
+
+	if (psci_has_osi_support())
+		pr_info("OSI mode supported.\n");
+
+	return 0;
+}
+
 static const struct of_device_id psci_of_match[] __initconst = {
 	{ .compatible = "arm,psci",	.data = psci_0_1_init},
 	{ .compatible = "arm,psci-0.2",	.data = psci_0_2_init},
-	{ .compatible = "arm,psci-1.0",	.data = psci_0_2_init},
+	{ .compatible = "arm,psci-1.0",	.data = psci_1_0_init},
 	{},
 };
 
diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index b3bcabe380da..581f72085c33 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -49,6 +49,7 @@
 
 #define PSCI_1_0_FN_PSCI_FEATURES		PSCI_0_2_FN(10)
 #define PSCI_1_0_FN_SYSTEM_SUSPEND		PSCI_0_2_FN(14)
+#define PSCI_1_0_FN_SET_SUSPEND_MODE		PSCI_0_2_FN(15)
 
 #define PSCI_1_0_FN64_SYSTEM_SUSPEND		PSCI_0_2_FN64(14)
 
@@ -97,6 +98,10 @@
 #define PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK	\
 			(0x1 << PSCI_1_0_FEATURES_CPU_SUSPEND_PF_SHIFT)
 
+#define PSCI_1_0_OS_INITIATED			BIT(0)
+#define PSCI_1_0_SUSPEND_MODE_PC		0
+#define PSCI_1_0_SUSPEND_MODE_OSI		1
+
 /* PSCI return values (inclusive of all PSCI versions) */
 #define PSCI_RET_SUCCESS			0
 #define PSCI_RET_NOT_SUPPORTED			-1
-- 
2.17.1

