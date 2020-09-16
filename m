Return-Path: <SRS0=SH1q=CZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BC1C433E2
	for <linux-pm@archiver.kernel.org>; Wed, 16 Sep 2020 20:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D56D221E5
	for <linux-pm@archiver.kernel.org>; Wed, 16 Sep 2020 20:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgIPUk6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:40:58 -0400
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:47174 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726843AbgIPUky (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 16:40:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id E27EB1803A837;
        Wed, 16 Sep 2020 20:40:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: flame67_0e044bd2711c
X-Filterd-Recvd-Size: 3245
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 16 Sep 2020 20:40:50 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>, linux-doc@vger.kernel.org
Subject: [PATCH V3 0/8] sysfs: drivers core: Add and use sysfs_emit and sysfs_emit_at
Date:   Wed, 16 Sep 2020 13:40:37 -0700
Message-Id: <cover.1600285923.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Output defects can exist in sysfs content using sprintf and snprintf.

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content and it's possible to overrun the
PAGE_SIZE buffer length.

Add a generic sysfs_emit function that knows that the size of the
temporary buffer and ensures that no overrun is done.

Add a generic sysfs_emit_at function that can be used in multiple
call situations that also ensures that no overrun is done.

V2: Add drivers core conversions
V3: Add a few more neatenings and conversions to drivers core
    Add mm hugetlb_report_node_meminfo conversion

Joe Perches (8):
  sysfs: Add sysfs_emit and sysfs_emit_at to format sysfs output
  drivers core: Use sysfs_emit and sysfs_emit_at for show(device *...) functions
  drivers core: Remove strcat uses around sysfs_emit and neaten
  drivers core: Reindent a couple uses around sysfs_emit
  drivers core: Miscellaneous changes for sysfs_emit
  mm: and drivers core: Convert hugetlb_report_node_meminfo to sysfs_emit
  drivers core: Use sysfs_emit for shared_cpu_map_show and shared_cpu_list_show
  drivers core: node: Use a more typical macro definition style for ACCESS_ATTR

 Documentation/filesystems/sysfs.rst     |   8 +-
 drivers/base/arch_topology.c            |   2 +-
 drivers/base/bus.c                      |   2 +-
 drivers/base/cacheinfo.c                |  49 ++--
 drivers/base/class.c                    |   2 +-
 drivers/base/core.c                     |  59 +++--
 drivers/base/cpu.c                      |  84 ++++---
 drivers/base/dd.c                       |   3 +-
 drivers/base/devcoredump.c              |   2 +-
 drivers/base/firmware_loader/fallback.c |   4 +-
 drivers/base/memory.c                   |  62 ++---
 drivers/base/node.c                     | 306 ++++++++++++------------
 drivers/base/platform.c                 |  17 +-
 drivers/base/power/sysfs.c              | 160 ++++++++-----
 drivers/base/power/wakeup_stats.c       |  17 +-
 drivers/base/soc.c                      |  64 +++--
 drivers/base/topology.c                 |  10 +-
 fs/sysfs/file.c                         |  55 +++++
 include/linux/hugetlb.h                 |   4 +-
 include/linux/sysfs.h                   |  15 ++
 mm/hugetlb.c                            |  18 +-
 21 files changed, 532 insertions(+), 411 deletions(-)

-- 
2.26.0

