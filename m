Return-Path: <SRS0=BiZX=YC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A9EECE58C
	for <linux-pm@archiver.kernel.org>; Wed,  9 Oct 2019 21:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8621206B6
	for <linux-pm@archiver.kernel.org>; Wed,  9 Oct 2019 21:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfJIVG3 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 9 Oct 2019 17:06:29 -0400
Received: from muru.com ([72.249.23.125]:36482 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729908AbfJIVG3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Oct 2019 17:06:29 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 9AEFE8140;
        Wed,  9 Oct 2019 21:07:02 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 0/5] cpcap battery simplification and calibrate support
Date:   Wed,  9 Oct 2019 14:06:16 -0700
Message-Id: <20191009210621.10522-1-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This set of changes simplifies the coulomb counter code for cpcap-battery.
And the last patch in the series add support for coulomb counter calibration
on probe.

Regards,

Tony

Tony Lindgren (5):
  power: supply: cpcap-battery: Move coulomb counter units per lsb to
    ddata
  power: supply: cpcap-battery: Simplify coulomb counter calculation
    with div_s64
  power: supply: cpcap-battery: Simplify short term power average
    calculation
  power: supply: cpcap-battery: Read and save integrator register CCI
  power: supply: cpcap-battery: Add basic coulomb counter calibrate
    support

 drivers/power/supply/cpcap-battery.c | 178 +++++++++++++++++++--------
 1 file changed, 125 insertions(+), 53 deletions(-)

-- 
2.23.0
