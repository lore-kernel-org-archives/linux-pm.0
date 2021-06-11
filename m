Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014B0C48BD1
	for <linux-pm@archiver.kernel.org>; Fri, 11 Jun 2021 16:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D38F0613C3
	for <linux-pm@archiver.kernel.org>; Fri, 11 Jun 2021 16:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhFKRAu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:00:50 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49266 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhFKRAt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jun 2021 13:00:49 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.5)
 id c1029fb533963793; Fri, 11 Jun 2021 18:58:49 +0200
Received: from kreacher.localnet (89-64-82-41.dynamic.chello.pl [89.64.82.41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id ACEC56698B2;
        Fri, 11 Jun 2021 18:58:48 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>
Subject: [PATCH] ACPI: power: Use dev_dbg() to print some messages
Date:   Fri, 11 Jun 2021 18:58:48 +0200
Message-ID: <2601165.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.82.41
X-CLIENT-HOSTNAME: 89-64-82-41.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrfedukedgudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepkeelrdeigedrkedvrdegudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekvddrgedupdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghpsehsuhhsvgdruggv
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The messages printed by acpi_resume_power_resources() and
acpi_turn_off_unused_power_resources() are not important enough to be
printed with pr_info(), so use dev_dbg() instead of it to get rid of
some noise in the kernel log.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/power.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -1004,7 +1004,7 @@ void acpi_resume_power_resources(void)
 
 		if (state == ACPI_POWER_RESOURCE_STATE_OFF
 		    && resource->ref_count) {
-			dev_info(&resource->device.dev, "Turning ON\n");
+			dev_dbg(&resource->device.dev, "Turning ON\n");
 			__acpi_power_on(resource);
 		}
 
@@ -1034,7 +1034,7 @@ void acpi_turn_off_unused_power_resource
 		 */
 		if (!resource->ref_count &&
 		    resource->state != ACPI_POWER_RESOURCE_STATE_OFF) {
-			dev_info(&resource->device.dev, "Turning OFF\n");
+			dev_dbg(&resource->device.dev, "Turning OFF\n");
 			__acpi_power_off(resource);
 		}
 



