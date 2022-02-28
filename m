Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271D3C43217
	for <linux-pm@archiver.kernel.org>; Mon, 28 Feb 2022 22:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiB1WGR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 28 Feb 2022 17:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiB1WGQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Feb 2022 17:06:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CF7C4B70;
        Mon, 28 Feb 2022 14:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=LsTLwsZ6isv+2phk734MyDwecvpupY6W/CRXpDrGAno=; b=TaKnZcVM3qgnA8RqwS/9rsFT94
        Ybkk8EZ0f5H/9P0cKQG6pwJt9mwjTc7E6lBjS75fab2id5XRHjV3+CIqaFo6XeQb3+/LgguPgJpJX
        Z6Y+AmTswo1gJQ2LQ8x3rBdFCngNgckRltN1jqAwr7v7Z0f6ADInFyJngCEhOkYZTWtexRxY/8hNp
        z40/8qG7WlGLSit/ABYkws8uqJpY8PsuOB14gOSZr/HxiBWMKXrrp1EHy9Xml+pSSszeVDGJvKgfr
        db5iGBvBJqiTow5Glaiz84/Gxc856PsaxJVQ34rHGIQldxc/2n2MUGt5SmiJK42zx1R7v2qjfLxaX
        kf5WqzBQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOo97-00EG2X-Pf; Mon, 28 Feb 2022 22:05:33 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Fabian Frederick <fabf@skynet.be>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
        Len Brown <len.brown@intel.com>
Subject: [PATCH] PM/hibernate: fix __setup handler error handling
Date:   Mon, 28 Feb 2022 14:05:32 -0800
Message-Id: <20220228220532.8531-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If an invalid value is used in "resumedelay=<seconds>", it is
silently ignored. Add a warning message and then let the __setup
handler return 1 to indicate that the kernel command line option
has been handled.

Fixes: 317cf7e5e85e3 ("PM / hibernate: convert simple_strtoul to kstrtoul")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Cc: Fabian Frederick <fabf@skynet.be>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
---
 kernel/power/hibernate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20220228.orig/kernel/power/hibernate.c
+++ linux-next-20220228/kernel/power/hibernate.c
@@ -1329,7 +1329,7 @@ static int __init resumedelay_setup(char
 	int rc = kstrtouint(str, 0, &resume_delay);
 
 	if (rc)
-		return rc;
+		pr_warn("resumedelay: bad option string '%s'\n", str);
 	return 1;
 }
 
