Return-Path: <SRS0=snuF=TO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E88C04AB4
	for <linux-pm@archiver.kernel.org>; Tue, 14 May 2019 17:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4939520879
	for <linux-pm@archiver.kernel.org>; Tue, 14 May 2019 17:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfENRqX (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 14 May 2019 13:46:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbfENRqX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 May 2019 13:46:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 790203082E5A
        for <linux-pm@vger.kernel.org>; Tue, 14 May 2019 17:46:23 +0000 (UTC)
Received: from prarit.khw1.lab.eng.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2347E5C5E0;
        Tue, 14 May 2019 17:46:23 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-pm@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] tools/power turbostat: Increase default buffer size
Date:   Tue, 14 May 2019 13:46:21 -0400
Message-Id: <20190514174621.12227-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 14 May 2019 17:46:23 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

'turbostat -D' fails on INTEL_FAM6_KABYLAKE_DESKTOP systems with a
segfault because the default buffer size is too small.

Increase the default to 1536.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c7727be9719f..b401d1aec394 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5135,7 +5135,7 @@ int initialize_counters(int cpu_id)
 
 void allocate_output_buffer()
 {
-	output_buffer = calloc(1, (1 + topo.num_cpus) * 1024);
+	output_buffer = calloc(1, (1 + topo.num_cpus) * 1536);
 	outp = output_buffer;
 	if (outp == NULL)
 		err(-1, "calloc output buffer");
-- 
2.21.0

