Return-Path: <SRS0=xbvJ=TK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55334C04A6B
	for <linux-pm@archiver.kernel.org>; Fri, 10 May 2019 10:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2734020989
	for <linux-pm@archiver.kernel.org>; Fri, 10 May 2019 10:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfEJKf4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 10 May 2019 06:35:56 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52764 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfEJKf4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 May 2019 06:35:56 -0400
Received: from 79.184.254.161.ipv4.supernova.orange.pl (79.184.254.161) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id b41bd29227d1183f; Fri, 10 May 2019 12:35:53 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: Explain the kobject_put() in cpufreq_policy_alloc()
Date:   Fri, 10 May 2019 12:35:53 +0200
Message-ID: <2270903.5qkiGuZaYc@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190510103553.8vNuk5Ct5o0rqAxO2IeykhoOtPxLn7UwJBUnqylO6yc@z>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It may not be particularly clear why the kobject_put() after
failing kobject_init_and_add() in cpufreq_policy_alloc() is not
redundant, so add a comment to explain that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1133,6 +1133,11 @@ static struct cpufreq_policy *cpufreq_po
 				   cpufreq_global_kobject, "policy%u", cpu);
 	if (ret) {
 		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
+		/*
+		 * The entire policy object will be freed below, but the extra
+		 * memory allocated for the kobject name needs to be freed by
+		 * releasing the kobject.
+		 */
 		kobject_put(&policy->kobj);
 		goto err_free_real_cpus;
 	}



