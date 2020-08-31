Return-Path: <SRS0=Ra4R=CJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE53C43461
	for <linux-pm@archiver.kernel.org>; Mon, 31 Aug 2020 15:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18C3207EA
	for <linux-pm@archiver.kernel.org>; Mon, 31 Aug 2020 15:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598888325;
	bh=PpOTd+1JuLVd/oGNLu014WCPcxYLqueUtP1FoVeSTfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TrrfWfVN3wEYeSWqpp9ymSZu/7Wic5VwrQ/voWx8r5W5pvKyz5b4E0qm7bH0aOWHR
	 8JKcKwV2I/u+02Xi4CFsYtPKfpURp87J52iEOlcMJu31SNGl2I+1pJFxO5stwqZx7l
	 bpt6KdVp12MFKi14q/4EuoHtRYfe8koraH8bwIpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgHaPaW (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:30:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbgHaPaT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 31 Aug 2020 11:30:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 420B02083E;
        Mon, 31 Aug 2020 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598887819;
        bh=PpOTd+1JuLVd/oGNLu014WCPcxYLqueUtP1FoVeSTfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jqTlza5IIZqwpEW1OU3+TW5bFldNsXdG3980VmfciXYEMlXU+AkFg6SRRenfOAcLr
         BV3Ug1udLb64wx1CLHY28eFzDRiEoFb9FeQ5CTo7ArOz/tHocIN9YOTfMFe+zdUAji
         XIn5lUvljO4TR0AhmiTjwhCQQEOVNhBFzrHG6JXw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Marco Elver <elver@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 30/42] cpuidle: Fixup IRQ state
Date:   Mon, 31 Aug 2020 11:29:22 -0400
Message-Id: <20200831152934.1023912-30-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831152934.1023912-1-sashal@kernel.org>
References: <20200831152934.1023912-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 49d9c5936314e44d314c605c39cce0fd947f9c3a ]

Match the pattern elsewhere in this file.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Marco Elver <elver@google.com>
Link: https://lkml.kernel.org/r/20200821085348.251340558@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpuidle/cpuidle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 87197319ab069..2fe4f3cdf54d7 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -153,7 +153,8 @@ static void enter_s2idle_proper(struct cpuidle_driver *drv,
 	 */
 	stop_critical_timings();
 	drv->states[index].enter_s2idle(dev, drv, index);
-	WARN_ON(!irqs_disabled());
+	if (WARN_ON_ONCE(!irqs_disabled()))
+		local_irq_disable();
 	/*
 	 * timekeeping_resume() that will be called by tick_unfreeze() for the
 	 * first CPU executing it calls functions containing RCU read-side
-- 
2.25.1

