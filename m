Return-Path: <SRS0=cFiq=5F=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1396DC4332B
	for <linux-pm@archiver.kernel.org>; Fri, 20 Mar 2020 14:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F262072D
	for <linux-pm@archiver.kernel.org>; Fri, 20 Mar 2020 14:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCTOHc (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 20 Mar 2020 10:07:32 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61321 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgCTOHc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 10:07:32 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 110b52a977f0d81c; Fri, 20 Mar 2020 15:07:30 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH] ACPI: s2idle: Fix comment in acpi_s2idle_prepare_late()
Date:   Fri, 20 Mar 2020 15:07:29 +0100
Message-ID: <6786907.GdQOV8UKbS@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Fix a comment in acpi_s2idle_prepare_late() that has become outdated
after commit f0ac20c3f613 ("ACPI: EC: Fix flushing of pending work").

Fixes: f0ac20c3f613 ("ACPI: EC: Fix flushing of pending work")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -982,10 +982,7 @@ static int acpi_s2idle_prepare_late(void
 
 static void acpi_s2idle_sync(void)
 {
-	/*
-	 * The EC driver uses the system workqueue and an additional special
-	 * one, so those need to be flushed too.
-	 */
+	/* The EC driver uses special workqueues that need to be flushed. */
 	acpi_ec_flush_work();
 	acpi_os_wait_events_complete(); /* synchronize Notify handling */
 }



