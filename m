Return-Path: <SRS0=jdfX=DC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51113C4363D
	for <linux-pm@archiver.kernel.org>; Fri, 25 Sep 2020 15:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18FB9235FD
	for <linux-pm@archiver.kernel.org>; Fri, 25 Sep 2020 15:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgIYPJL (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 25 Sep 2020 11:09:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:45022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728406AbgIYPJL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Sep 2020 11:09:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 34142AE35;
        Fri, 25 Sep 2020 15:09:10 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: tools/bootconfig: Create missing directories in Makefile install object if needed
Date:   Fri, 25 Sep 2020 17:09:09 +0200
Message-ID: <2482827.XuMzNZMSYQ@c100>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 tools/bootconfig/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/bootconfig/Makefile
+++ b/tools/bootconfig/Makefile
@@ -24,7 +24,7 @@
 	./test-bootconfig.sh $(OUTPUT)
 
 install: $(ALL_PROGRAMS)
-	install $(OUTPUT)bootconfig $(DESTDIR)$(bindir)
+	install -D $(OUTPUT)bootconfig $(DESTDIR)$(bindir)/bootconfig
 
 clean:
 	$(RM) -f $(OUTPUT)*.o $(ALL_PROGRAMS)



