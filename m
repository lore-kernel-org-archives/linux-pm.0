Return-Path: <SRS0=FDY0=3G=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6EDC33CB6
	for <linux-pm@archiver.kernel.org>; Fri, 17 Jan 2020 16:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B26A214AF
	for <linux-pm@archiver.kernel.org>; Fri, 17 Jan 2020 16:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgAQQGK (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:06:10 -0500
Received: from bin-mail-out-05.binero.net ([195.74.38.228]:23254 "EHLO
        bin-mail-out-05.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729108AbgAQQGK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 11:06:10 -0500
X-Halon-ID: 446cdcf2-3943-11ea-a00b-005056917a89
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p54ac5d7b.dip0.t-ipconnect.de [84.172.93.123])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPA
        id 446cdcf2-3943-11ea-a00b-005056917a89;
        Fri, 17 Jan 2020 17:06:09 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     linux-pm@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v3 0/2] thermal: rcar_{gen3_}thermal: Remove temperature
Date:   Fri, 17 Jan 2020 17:05:52 +0100
Message-Id: <20200117160554.3812787-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This series removes the checks that the read out temperature are within
the guaranteed operation limits described in the hardware manual. It has
been discussed with the hardware guys and the judgement is that it's
better to report a best effort temperature instead of failing with -EIO

Niklas Söderlund (2):
  thermal: rcar_thermal: Remove temperature bound
  thermal: rcar_gen3_thermal: Remove temperature bound

 drivers/thermal/rcar_gen3_thermal.c | 4 +---
 drivers/thermal/rcar_thermal.c      | 7 +------
 2 files changed, 2 insertions(+), 9 deletions(-)

-- 
2.24.1

