Return-Path: <SRS0=fmUR=CQ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A299C43461
	for <linux-pm@archiver.kernel.org>; Mon,  7 Sep 2020 17:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A5832137B
	for <linux-pm@archiver.kernel.org>; Mon,  7 Sep 2020 17:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgIGR6Q (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:58:16 -0400
Received: from smtprelay0171.hostedemail.com ([216.40.44.171]:39118 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728861AbgIGR6O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2020 13:58:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E88A3180A9F56;
        Mon,  7 Sep 2020 17:58:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: price32_061303f270ce
X-Filterd-Recvd-Size: 2089
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Sep 2020 17:58:11 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 0/4] drivers core: Use sysfs_emit functions
Date:   Mon,  7 Sep 2020 10:58:04 -0700
Message-Id: <cover.1599501047.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a sample block of conversions for drivers/base from next-20200903.
It requires the suggested patch that adds sysfs_emit pafunctions from
https://lore.kernel.org/lkml/a9054fb521e65f2809671fa9c18e2453061e9d91.1598744610.git.joe@perches.com/

Convert and neaten the various uses of sprintf family functions to
sysfs_emit and sysfs_emit_at

Joe Perches (4):
  drivers core: Use sysfs_emit and sysfs_emit_at for show(device *...) functions
  drivers core: Remove strcat uses around sysfs_emit and neaten
  drivers core: Reindent a couple uses around sysfs_emit
  drivers core: Miscellaneous changes for sysfs_emit

 drivers/base/arch_topology.c            |  2 +-
 drivers/base/cacheinfo.c                | 32 ++++++++-----
 drivers/base/class.c                    |  2 +-
 drivers/base/core.c                     | 27 ++++++-----
 drivers/base/cpu.c                      | 50 ++++++++++----------
 drivers/base/dd.c                       |  2 +-
 drivers/base/firmware_loader/fallback.c |  2 +-
 drivers/base/memory.c                   | 59 +++++++++++------------
 drivers/base/node.c                     | 47 ++++++++----------
 drivers/base/platform.c                 |  8 ++--
 drivers/base/power/sysfs.c              | 63 +++++++++++++------------
 drivers/base/power/wakeup_stats.c       | 12 ++---
 drivers/base/soc.c                      | 10 ++--
 13 files changed, 159 insertions(+), 157 deletions(-)

-- 
2.26.0

