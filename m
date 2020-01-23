Return-Path: <SRS0=B1NY=3M=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D53C32771
	for <linux-pm@archiver.kernel.org>; Thu, 23 Jan 2020 01:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1BD2467A
	for <linux-pm@archiver.kernel.org>; Thu, 23 Jan 2020 01:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgAWBlv (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 22 Jan 2020 20:41:51 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:52234 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725911AbgAWBlv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2020 20:41:51 -0500
X-IronPort-AV: E=Sophos;i="5.70,351,1574092800"; 
   d="scan'208";a="82502319"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Jan 2020 09:41:48 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 5525B50A996A;
        Thu, 23 Jan 2020 09:32:33 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Thu, 23 Jan 2020 09:41:46 +0800
Received: from TEST.g08.fujitsu.local (10.167.226.147) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Thu, 23 Jan 2020 09:41:45 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <x86@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <rjw@rjwysocki.net>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>
Subject: [RFC PATCH 0/2] x86/boot: early ACPI MADT processing cleanup
Date:   Thu, 23 Jan 2020 09:41:42 +0800
Message-ID: <20200123014144.19155-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 5525B50A996A.A93DF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Logic in early_acpi_process_madt() & acpi_process_madt() is really hard to
follow now. Clean them up.

Done basic boot test on my x86-64 PC.

CCed linux-acpi@vger.kernel.org

Cao jin (2):
  x86/acpi: Improve code readablity of early madt processing
  x86/acpi: Cleanup acpi_process_madt()

 arch/x86/kernel/acpi/boot.c | 72 +++++++++++++++----------------------
 1 file changed, 28 insertions(+), 44 deletions(-)

-- 
2.21.0



