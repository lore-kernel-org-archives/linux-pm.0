Return-Path: <SRS0=xQv0=SK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A07DC282DE
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 08:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E776920880
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 08:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfDHIqt (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:46:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:54602 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726465AbfDHIqs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Apr 2019 04:46:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1BD76B039;
        Mon,  8 Apr 2019 08:46:47 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     Rafael Wysocki <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] x86: Do not override performance EPB MSR value on servers
Date:   Mon, 08 Apr 2019 10:46:46 +0200
Message-ID: <36183132.7cOCK0nhyl@house>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It is about this kernel message showing up on quite a lot servers:
[    0.072652] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.076003] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)

With this patch the EPB value is not overridden anymore on systems
which expose themselves as appliance or enterprise server via ACPI
perferred profile variable.

Signed-off-by: trenn@suse.de


Index: perf_bias_acpi_server_only/arch/x86/kernel/cpu/intel_epb.c
===================================================================
--- perf_bias_acpi_server_only.orig/arch/x86/kernel/cpu/intel_epb.c	2019-04-05 14:43:04.280222577 +0200
+++ perf_bias_acpi_server_only/arch/x86/kernel/cpu/intel_epb.c	2019-04-08 10:01:26.029278425 +0200
@@ -19,6 +19,8 @@
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
 
+#include <linux/acpi.h>
+
 /**
  * DOC: overview
  *
@@ -89,7 +91,10 @@ static void intel_epb_restore(void)
 		 * ('normal').
 		 */
 		val = epb & EPB_MASK;
-		if (val == ENERGY_PERF_BIAS_PERFORMANCE) {
+		if (acpi_gbl_FADT.preferred_profile == PM_ENTERPRISE_SERVER ||
+		    acpi_gbl_FADT.preferred_profile == PM_PERFORMANCE_SERVER) {
+			/* Keep performance setting on servers */
+		} else	if (val == ENERGY_PERF_BIAS_PERFORMANCE) {
 			val = ENERGY_PERF_BIAS_NORMAL;
 			pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
 		}

