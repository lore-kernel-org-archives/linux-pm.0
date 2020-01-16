Return-Path: <SRS0=m8DM=3F=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34506C33CAF
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jan 2020 23:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E862072E
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jan 2020 23:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579216708;
	bh=GrD/yoq2VR7i3XYGvbkYffHu0uIOJYpAsSukO2Qoips=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=ip1Z3vBpi2pXBmWICoR54uWa1BA3c1L/FKjSLpqkZsYLA925hbATzPq7PNXIskSbK
	 3N9oNW3MIocXtpeBNpqWpcC5HC7xIgkgT0nH57AAHwsWKPK3LrVxjHXkAVRuoJQLCd
	 g+JWeNg1f7MnJtRkN1es28bOST9fLY02Wo/UZs8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbgAPXS1 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:18:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38982 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbgAPXS1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 18:18:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id 77so21015769oty.6;
        Thu, 16 Jan 2020 15:18:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9EAHGBuNSiTZ5l+4zkY1z64r39UtR5n6bdLL5+4kKYw=;
        b=b+jUIvN1fqe2yQJwN17tm5K0bnCqpeKpHEZDNXmoHmjsv9r37u4aySrAV/wv3DZbEM
         k08SjMNPSN35gUQ5uS5vbXgwyNpELMmjvOdWCi94jpFhh6RVp4YxD5pNAAJRWsqC749Z
         4ohQTOxvL6cqTdv64SEBY3evPYWmFvJiT+zpJFG7StueOVAF7w5tWRR6w+92nTNIcBgm
         9NXQOtGx8hkraHvyb8dyQ9p8/xe1OelU8427903oLzI04+SD+bvR4cmQpLALkogrC8C0
         BGMOdvgRZOOweTqDHXbDHnsd4w8ZNAs3omCeckUnt6eoKC3fj8FgSg/e6QfZ0liGV4Cb
         HHAw==
X-Gm-Message-State: APjAAAWqPFCo7dBuQFTILnZPnpC42hulTz1vuSuk3mmiM96FaqpgrHwl
        nooz4NeHNR+Z7s9Jo6dn6emE0Y5KFrf9MWK5gOsC96y5
X-Google-Smtp-Source: APXvYqwUZi+VXujTD0dJq+O3DBa1rtWtuoNRma2EaFrjX1F544jKaMnrJ4XSyslqHMl0UHvJxJbc4yTEuKlc5uInp7I=
X-Received: by 2002:a05:6830:1e67:: with SMTP id m7mr4139324otr.262.1579216706411;
 Thu, 16 Jan 2020 15:18:26 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Jan 2020 00:18:15 +0100
Message-ID: <CAJZ5v0gx+Om02PH6t74R0d2F_sPZwncOSMWrhA0Yx77=xdpCyA@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v5.5-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.5-rc7

with top-most commit 57388a2ccb6c2f554fee39772886c69b796dde53

 cpuidle: teo: Fix intervals[] array indexing bug

on top of commit b3a987b0264d3ddbb24293ebff10eddfc472f653

 Linux 5.5-rc6

to receive a power management fix for 5.5-rc7.

This fixes a coding mistake in the teo cpuidle governor causing data
to be written beyond the last array element (Ikjoon Jang).

Thanks!


---------------

Ikjoon Jang (1):
      cpuidle: teo: Fix intervals[] array indexing bug

---------------

 drivers/cpuidle/governors/teo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
