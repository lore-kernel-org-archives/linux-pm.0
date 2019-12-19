Return-Path: <SRS0=UOP4=2J=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6BDC43603
	for <linux-pm@archiver.kernel.org>; Thu, 19 Dec 2019 22:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FCA24685
	for <linux-pm@archiver.kernel.org>; Thu, 19 Dec 2019 22:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfLSWzy (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:55:54 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51514 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfLSWzy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 17:55:54 -0500
Received: from 79.184.253.1.ipv4.supernova.orange.pl (79.184.253.1) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id ee0c570a228e0dac; Thu, 19 Dec 2019 23:55:51 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: [PATCH] mailmap: Add entry for <rjw@sisk.pl>
Date:   Thu, 19 Dec 2019 23:55:51 +0100
Message-ID: <5262239.5eEoY8XddG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The old email address I contributed to the kernel from in the past
has not been functional for a few years, so add a .mailmap entry
for it.

Signed-off-by: Rafael J. Wysocki <rjw@rjwysocki.net>
---
 .mailmap |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/.mailmap
===================================================================
--- linux-pm.orig/.mailmap
+++ linux-pm/.mailmap
@@ -216,6 +216,7 @@ Praveen BP <praveenbp@ti.com>
 Punit Agrawal <punitagrawal@gmail.com> <punit.agrawal@arm.com>
 Qais Yousef <qsyousef@gmail.com> <qais.yousef@imgtec.com>
 Quentin Perret <qperret@qperret.net> <quentin.perret@arm.com>
+Rafael J. Wysocki <rjw@rjwysocki.net> <rjw@sisk.pl>
 Rajesh Shah <rajesh.shah@intel.com>
 Ralf Baechle <ralf@linux-mips.org>
 Ralf Wildenhues <Ralf.Wildenhues@gmx.de>



