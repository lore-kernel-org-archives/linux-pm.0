Return-Path: <SRS0=Cnqh=6G=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B2AC55185
	for <linux-pm@archiver.kernel.org>; Wed, 22 Apr 2020 22:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BF3F2076E
	for <linux-pm@archiver.kernel.org>; Wed, 22 Apr 2020 22:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgDVWCI (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:02:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:59118 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgDVWCH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 18:02:07 -0400
IronPort-SDR: mjwgTs8q2EsDqnsZMb3G/xuphsDsiLuZ/QjEmHuDVheSilnC1Oui+V+oY2Nr6VJQ70tLV0UiOp
 rSlhqEgOSWWA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 15:02:07 -0700
IronPort-SDR: vZetjHzZwYVnEI89fh1/NHQO4oX77tqhXS+An4NDsrXBi4Tcgl60AI3NeV84kO87L2h8BPXRgg
 erAKDktpohUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; 
   d="scan'208";a="290982811"
Received: from njamal-mobl.amr.corp.intel.com (HELO rantogno-mobl3.intel.com) ([10.251.145.212])
  by fmsmga002.fm.intel.com with ESMTP; 22 Apr 2020 15:02:07 -0700
From:   Rafael Antognolli <rafael.antognolli@intel.com>
To:     linux-pm@vger.kernel.org
Subject: [PATCH 0/1] Add new GFXAMHz field to turbostat.
Date:   Wed, 22 Apr 2020 15:02:06 -0700
Message-Id: <20200422220207.17425-1-rafael.antognolli@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I work on the Mesa team at Intel and we have been using turbostat a lot
to monitor CPU and GPU frequency. However, turbostat only displays the
frequency read by
/sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz. We have been
also manually printing the content from gt_act_freq_mhz, but would be
nice if it was just another column in turbostat.

The following patch adds that, with a field name called "GFXAMHz" (open
to better names, of course). Would it be reasonable to have such patch?

If not, would you propose something else instead?

Thank you!

Rafael Antognolli (1):
  turbostat: Add a new GFXAMHz column that exposes gt_act_freq_mhz.

 tools/power/x86/turbostat/turbostat.c | 50 +++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

-- 
2.26.2

