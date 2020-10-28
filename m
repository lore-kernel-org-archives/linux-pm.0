Return-Path: <SRS0=Ui8E=ED=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD23C56201
	for <linux-pm@archiver.kernel.org>; Wed, 28 Oct 2020 23:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 425EC20E65
	for <linux-pm@archiver.kernel.org>; Wed, 28 Oct 2020 23:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgJ1Xkk (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:40:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59545 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgJ1XjE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 19:39:04 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kXk8M-00040b-Cl; Wed, 28 Oct 2020 12:00:54 +0000
To:     Nishanth Menon <nm@ti.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org
From:   Colin Ian King <colin.king@canonical.com>
Subject: re: PM / devfreq: map devfreq drivers to governor using name
Message-ID: <8aec701c-73d1-d2a1-c894-8dec844ed865@canonical.com>
Date:   Wed, 28 Oct 2020 12:00:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Static analysis of linux-next with Coverity has found a potential null
pointer dereference issue with the following commit:

commit 1b5c1be2c88e8445a20fa1929e26c37e7ca8c926
Author: Nishanth Menon <nm@ti.com>
Date:   Mon Oct 29 15:01:45 2012 -0500

    PM / devfreq: map devfreq drivers to governor using name


The analysis is as follows for devfreq_remove_governor in
drivers/devfreq/devfreq.c

1312

deref_ptr_in_call: Dereferencing pointer devfreq->governor.

1313                if (!strncmp(devfreq->governor->name, governor->name,
1314                             DEVFREQ_NAME_LEN)) {
1315                        /* we should have a devfreq governor! */

Dereference before null check (REVERSE_INULL)
check_after_deref: Null-checking devfreq->governor suggests that it may
be null, but it has already been dereferenced on all paths leading to
the check.

1316                        if (!devfreq->governor) {
1317                                dev_warn(dev, "%s: Governor %s NOT
present\n",
1318                                         __func__, governor->name);
1319                                continue;
1320                                /* Fall through */

So devfreq->governor->name is dereferencing devfreq->governor before a
null check on devfreq->governor

Colin
