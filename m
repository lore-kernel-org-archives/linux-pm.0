Return-Path: <SRS0=bbN6=27=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712D9C33CA2
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jan 2020 10:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515C82087F
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jan 2020 10:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgAJK57 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:57:59 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55627 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbgAJK56 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 05:57:58 -0500
Received: from 79.184.255.90.ipv4.supernova.orange.pl (79.184.255.90) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 7f429f08fdd1f17e; Fri, 10 Jan 2020 11:57:56 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 3/8] intel_idle: Clean up NULL pointer check in intel_idle_init()
Date:   Fri, 10 Jan 2020 11:45:49 +0100
Message-ID: <3687000.7TDbEkBDjF@kreacher>
In-Reply-To: <14127826.m9lEolTOYu@kreacher>
References: <14127826.m9lEolTOYu@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of comparing intel_idle_cpuidle_devices with NULL apply
the "!" (not) operator to it when checking it against NULL.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -1630,7 +1630,7 @@ static int __init intel_idle_init(void)
 		 boot_cpu_data.x86_model);
 
 	intel_idle_cpuidle_devices = alloc_percpu(struct cpuidle_device);
-	if (intel_idle_cpuidle_devices == NULL)
+	if (!intel_idle_cpuidle_devices)
 		return -ENOMEM;
 
 	intel_idle_cpuidle_driver_init();



