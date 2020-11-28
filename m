Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF65FC63798
	for <linux-pm@archiver.kernel.org>; Sat, 28 Nov 2020 23:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85FE620691
	for <linux-pm@archiver.kernel.org>; Sat, 28 Nov 2020 23:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVpNv7k1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgK1Xoa (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 28 Nov 2020 18:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgK1Xoa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Nov 2020 18:44:30 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF9EC0613D2;
        Sat, 28 Nov 2020 15:43:49 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id s9so10696883ljo.11;
        Sat, 28 Nov 2020 15:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A4+PFcgBTaTkF/FKuE+BID+gT0pT9KH7sfkapQYrDBs=;
        b=gVpNv7k10XC4rlKGb9EcFr7zYdHtXwjROi/InIq1J3ZF3npx6NDQQXS0ZGWAwzjANE
         bmvzWqQ+tzXgbHC8ej9+1Qg5G7Db8Qv5riUhQqpfToy+4z68V6mf5HEuxlZwT/1qxhdR
         ZCrpnW4B6LyEG5+RhpZbDSHRqeJwtjkev+Ota+srXUSAHZDUPfG+cw0/rzpghuelGiDE
         HN6CHUCq26kboAP3Ows7IqCU1qhrCudrg5i3DXn8nRLp5rds/fmycSOMIcboDfz0YIR0
         PWRVVhj8Bum9hVrWI0hfr9Trv6riq4mCB6gchWPWArROM4CXoCuqvZOnc3O1aFSXBlVq
         kTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A4+PFcgBTaTkF/FKuE+BID+gT0pT9KH7sfkapQYrDBs=;
        b=pr3JCrsHAwLzOgYNk25d0qp9GZ7+T9JVeAfFILpv3cm+TmzY8KcoSsRJAt0GkgLf+S
         lozRmD4VHLrKomwUu4fQhRQoDcKuM4PqozL5bm87nKkLtf9bTN69Y8bWfr6dOLAQSlu3
         ltNIQPDDe89ceYCFWNru5W3/avviD132qBsZGH+u4IkUyjbmLEc1SA1XiMAl9AujRDT1
         ApV0hmiiWLJYY13T06o2oA3ypSUHFOQNPdAt8N7vugXuM8DOSrxq9yb9UAIYFXb9pgUq
         vcroM4inQeLpFcLPqvFobj7D9mgI0mhaeqYhI24VAZk7ZeJNxPs+EXXXF4i0jdU7I+k5
         25IA==
X-Gm-Message-State: AOAM533t35JOWBb239akFhl+kzTfBgOkMAvGSZCfwHTYTIcUIgBBe7sG
        e5Oi2ztohjaoBb6FhB+GJo4=
X-Google-Smtp-Source: ABdhPJxQN1oIJ2E8TWVf/0E50zZwAIiDDZM8RiEZuUNYAgmgLbJphpCZAkSV5TGeb+Pl7Kkz2288/A==
X-Received: by 2002:a05:651c:211e:: with SMTP id a30mr6754336ljq.18.1606607028392;
        Sat, 28 Nov 2020 15:43:48 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-6.NA.cust.bahnhof.se. [158.174.22.6])
        by smtp.gmail.com with ESMTPSA id k185sm1223370lfd.294.2020.11.28.15.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 15:43:47 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] thermal: Constify static attribute_group structs
Date:   Sun, 29 Nov 2020 00:43:42 +0100
Message-Id: <20201128234342.36684-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The only usage of these structs is to assign their address to the
thermal_zone_attribute_groups array, which consists of pointers to
const, so make them const to allow the compiler to put them in read-only
memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index a6f371fc9af2..0866e949339b 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -425,7 +425,7 @@ static struct attribute *thermal_zone_dev_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group thermal_zone_attribute_group = {
+static const struct attribute_group thermal_zone_attribute_group = {
 	.attrs = thermal_zone_dev_attrs,
 };
 
@@ -434,7 +434,7 @@ static struct attribute *thermal_zone_mode_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group thermal_zone_mode_attribute_group = {
+static const struct attribute_group thermal_zone_mode_attribute_group = {
 	.attrs = thermal_zone_mode_attrs,
 };
 
@@ -468,7 +468,7 @@ static umode_t thermal_zone_passive_is_visible(struct kobject *kobj,
 	return 0;
 }
 
-static struct attribute_group thermal_zone_passive_attribute_group = {
+static const struct attribute_group thermal_zone_passive_attribute_group = {
 	.attrs = thermal_zone_passive_attrs,
 	.is_visible = thermal_zone_passive_is_visible,
 };
-- 
2.29.2

