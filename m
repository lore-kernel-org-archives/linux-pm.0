Return-Path: <SRS0=JVBr=SU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E91CC10F0E
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 16:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398FA21479
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 16:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H1lDS8pL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389241AbfDRQn2 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:43:28 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51193 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388716AbfDRQn2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2019 12:43:28 -0400
Received: by mail-it1-f193.google.com with SMTP id q14so4344317itk.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2019 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ta2TwVD4x4aKSUvSzxofkoqhry+DDy8oXie7QdtlLlI=;
        b=H1lDS8pLlIYoPlMaezXMI7tNdibanv+0T6lsh20pmpYUvWITAUuHhNqsXZGG6LaI7a
         uyICQaa874L3o5YXZRZgJLyJaHdGMxA4+hhDdu0huJxKszaubGx38Jm1wwm1KRgz96cj
         oFbX4IkiHQ7xdExrwGkdbO+JuLCQsKZz6ADuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ta2TwVD4x4aKSUvSzxofkoqhry+DDy8oXie7QdtlLlI=;
        b=IDwJV0kdkQnfi6pXATmlnBRzYuan/UBBdOsRYbiJlJM4qcfNaJkLS3w0mz4DrG7vLE
         JEgn/PzunJKk2QrwjxameWmonfI/d6sNnYK/cHvF6ZXiZnQHOKq4xQ3jbbQmoKs+uOr/
         JxOpnuMmJBV2aIY+er4KoF3+BJ+oKdaXPmlIr2zXqvReHbeah7kKdM6FSWjwQjuVeasS
         R/D8UuAXQOxekzDiRGSTaBrdNosyd/drY/2NzqKg3gk6vM6j7af4i2KGcxhfX6mzsHeZ
         r0Edlq6Y4dER9ZfWI5g9aLnzNFovS/Uo/N/1PpVje8Aw5GSQRChdQTA62+i4xKs1Nz+z
         LCAw==
X-Gm-Message-State: APjAAAW7phYs8Wrht3JWlScVtUJqQaH/Rs4590Pg2HUrwXTxtKNTK1Lr
        cOqg/1VuvureS0WcuuwX/52sOA==
X-Google-Smtp-Source: APXvYqyNLC87MlsR/iuvgTeSPXgWB7+rckFCi8cpwKl6fgDE3GxSSQLukf4YAFx2zL4V9D2W7gdQgQ==
X-Received: by 2002:a24:241:: with SMTP id 62mr4262723itu.67.1555605807677;
        Thu, 18 Apr 2019 09:43:27 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id g70sm1180905itg.40.2019.04.18.09.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Apr 2019 09:43:26 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org, sre@kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        lamzin@google.com, bartfab@google.com, derat@google.com,
        dtor@google.com, sjg@chromium.org, jchwong@chromium.org,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH v5 1/3] power_supply: Add Standard, Adaptive, and Custom charge types
Date:   Thu, 18 Apr 2019 10:43:12 -0600
Message-Id: <20190418164314.161065-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417214022.7jk3usygcpnls3pr@earth.universe>
References: <20190417214022.7jk3usygcpnls3pr@earth.universe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418164312.Y6wjHdFluS6X0cBWyirIsaYV1uk1vbVnw7_C0ZN6wa0@z>

Add "Standard", "Adaptive", and "Custom" modes to the charge_type
property, to expand the existing "Trickle" and "Fast" modes.
I am adding them in order to support a new Chrome OS device,
but these properties should be general enough that they can be
used on other devices.

The meaning of "Standard" is obvious, but "Adaptive" and "Custom" are
more tricky: "Adaptive" means that the charge controller uses some
custom algorithm to change the charge type automatically, with no
configuration needed. "Custom" means that the charge controller uses the
POWER_SUPPLY_PROP_CHARGE_CONTROL_* properties as configuration for some
other algorithm.

v5 changes:
- Split up adding the charge types and adding the
  POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD and
  POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD properties into
  two different commits.
v4 changes:
- Add documentation for the new properties, and add documentation for
  the the previously missing charge_control_limit and
  charge_control_limit_max properties.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 Documentation/ABI/testing/sysfs-class-power | 12 +++++++++---
 drivers/power/supply/power_supply_sysfs.c   |  2 +-
 include/linux/power_supply.h                |  8 ++++++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 5e23e22dce1b..544c4e0ef8b6 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -119,10 +119,16 @@ Date:		July 2009
 Contact:	linux-pm@vger.kernel.org
 Description:
 		Represents the type of charging currently being applied to the
-		battery.
+		battery. "Trickle", "Fast", and "Standard" all mean different
+		charging speeds. "Adaptive" means that the charger uses some
+		algorithm to adjust the charge rate dynamically, without
+		any user configuration required. "Custom" means that the charger
+		uses the charge_control_* properties as configuration for some
+		different algorithm.
 
-		Access: Read
-		Valid values: "Unknown", "N/A", "Trickle", "Fast"
+		Access: Read, Write
+		Valid values: "Unknown", "N/A", "Trickle", "Fast", "Standard",
+			      "Adaptive", "Custom"
 
 What:		/sys/class/power_supply/<supply_name>/charge_term_current
 Date:		July 2014
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index dce24f596160..64dff5cfecc3 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -56,7 +56,7 @@ static const char * const power_supply_status_text[] = {
 };
 
 static const char * const power_supply_charge_type_text[] = {
-	"Unknown", "N/A", "Trickle", "Fast"
+	"Unknown", "N/A", "Trickle", "Fast", "Standard", "Adaptive", "Custom"
 };
 
 static const char * const power_supply_health_text[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 2f9c201a54d1..e86e05d8134d 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -40,11 +40,15 @@ enum {
 	POWER_SUPPLY_STATUS_FULL,
 };
 
+/* What algorithm is the charger using? */
 enum {
 	POWER_SUPPLY_CHARGE_TYPE_UNKNOWN = 0,
 	POWER_SUPPLY_CHARGE_TYPE_NONE,
-	POWER_SUPPLY_CHARGE_TYPE_TRICKLE,
-	POWER_SUPPLY_CHARGE_TYPE_FAST,
+	POWER_SUPPLY_CHARGE_TYPE_TRICKLE,	/* slow speed */
+	POWER_SUPPLY_CHARGE_TYPE_FAST,		/* fast speed */
+	POWER_SUPPLY_CHARGE_TYPE_STANDARD,	/* normal speed */
+	POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE,	/* dynamically adjusted speed */
+	POWER_SUPPLY_CHARGE_TYPE_CUSTOM,	/* use CHARGE_CONTROL_* props */
 };
 
 enum {
-- 
2.20.1

