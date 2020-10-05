Return-Path: <SRS0=LE0X=DM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0205C4727D
	for <linux-pm@archiver.kernel.org>; Mon,  5 Oct 2020 17:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB17821548
	for <linux-pm@archiver.kernel.org>; Mon,  5 Oct 2020 17:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgJERN5 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 5 Oct 2020 13:13:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55396 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgJERNy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 13:13:54 -0400
Received: from 89-64-89-50.dynamic.chello.pl (89.64.89.50) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.489)
 id 20ea6863fb1d4063; Mon, 5 Oct 2020 19:13:52 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] ACPI: EC: PM: Two fixes related to suspend-to-idle
Date:   Mon, 05 Oct 2020 19:10:29 +0200
Message-ID: <1969699.iD4Ik4PeQO@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

The following two patches address two suspend-to-idle-related issues in the
ACPI EC driver.

Please refer to the patch changelogs for details.

Thanks!



