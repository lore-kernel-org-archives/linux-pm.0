Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057AAC433EF
	for <linux-pm@archiver.kernel.org>; Thu, 24 Mar 2022 16:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352028AbiCXRBE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 24 Mar 2022 13:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346149AbiCXRBD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2022 13:01:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7295F5EDD7
        for <linux-pm@vger.kernel.org>; Thu, 24 Mar 2022 09:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648141170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=b/sS1I4x2XsmlSGjKr1ZTMhx5qQzprN548q1C8bCjuA=;
        b=Rwwkn9eUvqnJoYPycMDNL+Lxm7030qo9qp/R16af6kaKjQ2e2ve6oatOyu7osgoCyDF2B+
        G7ti7pTKt8OZR3di683KXAHB9CbFXWjdOORXEyF5l4UfH9K34B/UgH/zuGViKCwqbEFz9r
        QctRS9+xAw1DcP7bKA+A9emt2UUBFqU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-08azyXoUOjCal3lrW4fzKA-1; Thu, 24 Mar 2022 12:59:24 -0400
X-MC-Unique: 08azyXoUOjCal3lrW4fzKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 792FD1C0E341;
        Thu, 24 Mar 2022 16:59:23 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F160C15D7D;
        Thu, 24 Mar 2022 16:59:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Huang Jianan <huangjianan@oppo.com>,
        Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Amit Kucheria <amitk@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Documentation/ABI/testing: Sphinx warning fixes
Date:   Thu, 24 Mar 2022 17:59:15 +0100
Message-Id: <20220324165918.22005-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

After Stephen reported some Sphinx warnings for the platform-drivers-x86,
I had to first figure out how to reproduce these. It turns out that to
regenerate the htmldocs for Documentation/ABI/testing one has to run:

touch Documentation/admin-guide/abi-testing.rst && make htmldocs

This turned up not only warnings from platform/x86 driver ABI but also
for some others. While at it I've written fixes for those too.

I'm not sure how these should be merged, I guess that the relevant
subsys maintainers will pick these up?

Regards,

Hans
   

Hans de Goede (3):
  Documentation/ABI: sysfs-driver-aspeed-uart-routing: Fix sphinx
    warning
  Documentation/ABI: sysfs-class-thermal: Fix Sphinx warning
  Documentation/ABI: sysfs-fs-erofs: Fix Sphinx errors

 Documentation/ABI/testing/sysfs-class-thermal              | 2 +-
 Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing | 7 ++++---
 Documentation/ABI/testing/sysfs-fs-erofs                   | 5 +++--
 3 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.35.1

