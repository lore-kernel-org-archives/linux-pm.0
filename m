Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2ECC4338F
	for <linux-pm@archiver.kernel.org>; Tue, 10 Aug 2021 01:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ABEF61004
	for <linux-pm@archiver.kernel.org>; Tue, 10 Aug 2021 01:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhHJBpF (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 9 Aug 2021 21:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhHJBpF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Aug 2021 21:45:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323DCC0613D3;
        Mon,  9 Aug 2021 18:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=WZjBScLSkxsej2CYjZzeF6pwIPZQKqWEzTgHASXF2KM=; b=FvprHoA9kqiaa6ghZpx071lb90
        WbbBGbJb+bizqEWTFWwbb3VsFr2pMmrET/IAxj/DChk6vvri3yaAkWdvnRMeUy98ZpODo+0SWPtvA
        zYPTIk/s0RYE5uoNO7CAQuTxlEdKGUUgmIniNXsB9YWQKZ5AD7avk3XgFjeQXcrm+ULhCz86s2CAo
        xwu0vxUAlPoihyQbZf6565gJWIueN9S0/whKbZoG9e59HJoWvA+UNE+Zrlo3psS2FlywNEBBnfonN
        JZ+2U6iMkK11Qro5WHthuoPy9YPu4pyvEMBXi5U6luBKX7XrnAD0/2nzFy2Z81GOV5T0To9anWlKv
        2meyVO/w==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDGot-002EN3-6m; Tue, 10 Aug 2021 01:44:43 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH] kernel/power: unmark 'state' functions as kernel-doc
Date:   Mon,  9 Aug 2021 18:44:42 -0700
Message-Id: <20210810014442.7446-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix kernel-doc warnings in kernel/power/main.c by unmarking the
comment block as kernel-doc notation. This eliminates the following
kernel-doc warnings:

kernel/power/main.c:593: warning: expecting prototype for state(). Prototype was for state_show() instead
kernel/power/main.c:593: warning: Function parameter or member 'kobj' not described in 'state_show'
kernel/power/main.c:593: warning: Function parameter or member 'attr' not described in 'state_show'
kernel/power/main.c:593: warning: Function parameter or member 'buf' not described in 'state_show'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
---
 kernel/power/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210809.orig/kernel/power/main.c
+++ linux-next-20210809/kernel/power/main.c
@@ -577,7 +577,7 @@ static inline void pm_print_times_init(v
 
 struct kobject *power_kobj;
 
-/**
+/*
  * state - control system sleep states.
  *
  * show() returns available sleep state labels, which may be "mem", "standby",
