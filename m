Return-Path: <SRS0=bbN6=27=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C928C33CA2
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jan 2020 10:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5F22082E
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jan 2020 10:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgAJK6A (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:58:00 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:54097 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbgAJK6A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 05:58:00 -0500
Received: from 79.184.255.90.ipv4.supernova.orange.pl (79.184.255.90) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 7037ea166fca5e63; Fri, 10 Jan 2020 11:57:58 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/8] intel_idle: Eliminate __setup_broadcast_timer()
Date:   Fri, 10 Jan 2020 11:43:23 +0100
Message-ID: <26343594.6IAkRYhI4F@kreacher>
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

The __setup_broadcast_timer() static function is only called in one
place and "true" is passed to it as the argument in there, so
effectively it is a wrapper arround tick_broadcast_enable().

To simplify the code, call tick_broadcast_enable() directly instead
of __setup_broadcast_timer() and drop the latter.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -967,14 +967,6 @@ static bool intel_idle_verify_cstate(uns
 	return true;
 }
 
-static void __setup_broadcast_timer(bool on)
-{
-	if (on)
-		tick_broadcast_enable();
-	else
-		tick_broadcast_disable();
-}
-
 static void auto_demotion_disable(void)
 {
 	unsigned long long msr_bits;
@@ -1624,7 +1616,7 @@ static int intel_idle_cpu_online(unsigne
 	struct cpuidle_device *dev;
 
 	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE)
-		__setup_broadcast_timer(true);
+		tick_broadcast_enable();
 
 	/*
 	 * Some systems can hotplug a cpu at runtime after



