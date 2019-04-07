Return-Path: <SRS0=LXM6=SJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EFDC10F0E
	for <linux-pm@archiver.kernel.org>; Sun,  7 Apr 2019 18:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987A3213F2
	for <linux-pm@archiver.kernel.org>; Sun,  7 Apr 2019 18:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDGSNB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 7 Apr 2019 14:13:01 -0400
Received: from muru.com ([72.249.23.125]:44666 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfDGSNB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 7 Apr 2019 14:13:01 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 66CA38022;
        Sun,  7 Apr 2019 18:13:16 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 0/7] Some fixes and improvments for cpcap battery and charger
Date:   Sun,  7 Apr 2019 11:12:47 -0700
Message-Id: <20190407181254.64537-1-tony@atomide.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

I've been trying to figure out how come the coulomb counter on droid 4 is off
especially for the low power consumption values. Turns out the "coulomb counter"
values correlate better with average power consumption if we divide the value with
number of samples. Otherwise we have a curve instead of flat correlation between
the register values and power consumed. I have some patches coming up eventually to
fix that, but meanwhile I've noticed some minor issues in general that would be
good to have out of the way.

I've only tagged the first one with fixes tag, the other ones can certainly wait
for the merge window considering further changes are needed at least for low power
consumption values.

Regards,

Tony


Tony Lindgren (7):
  power: supply: cpcap-battery: Fix division by zero
  power: supply: cpcap-battery: Fix low battery check
  power: supply: cpcap-battery: Fix signed counter sample register
  power: supply: cpcap-battery: Fix coulomb counter calibration register
    use
  power: supply: cpcap-battery: Use accumulator for current and power
    average
  power: supply: cpcap-battery: Fix pointless EPROBE_DEFER warnings
  power: supply: cpcap-charger: Fix pointless EPROBE_DEFER warnings

 drivers/power/supply/cpcap-battery.c | 45 +++++++++++++++-------------
 drivers/power/supply/cpcap-charger.c |  5 ++--
 2 files changed, 27 insertions(+), 23 deletions(-)

-- 
2.21.0
