Return-Path: <SRS0=BiZX=YC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CF0ECE58C
	for <linux-pm@archiver.kernel.org>; Wed,  9 Oct 2019 20:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653F62190F
	for <linux-pm@archiver.kernel.org>; Wed,  9 Oct 2019 20:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbfJIUw5 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 9 Oct 2019 16:52:57 -0400
Received: from muru.com ([72.249.23.125]:36414 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbfJIUw4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Oct 2019 16:52:56 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 4B7628140;
        Wed,  9 Oct 2019 20:53:30 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCHv2 0/2] cpcap charger and battery fixes
Date:   Wed,  9 Oct 2019 13:52:50 -0700
Message-Id: <20191009205252.9510-1-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Here are few fixes for cpcap charger and battery. These can probably wait
for v5.5 if preferred that way and can be applied separate from the 4.2V
charger fix.

Regards,

Tony

Changes since v1:

- Sent the updated 4.2V voltage fix separately

Tony Lindgren (2):
  power: supply: cpcap-battery: Check voltage before orderly_poweroff
  power: supply: cpcap-charger: Improve battery detection

 drivers/power/supply/cpcap-battery.c | 9 ++++++---
 drivers/power/supply/cpcap-charger.c | 7 ++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.23.0
