Return-Path: <SRS0=HLSa=2N=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD01C2D0C0
	for <linux-pm@archiver.kernel.org>; Mon, 23 Dec 2019 14:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADC820709
	for <linux-pm@archiver.kernel.org>; Mon, 23 Dec 2019 14:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b="E+AB4TDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfLWO0w (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:26:52 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:44870 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfLWO0w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2019 09:26:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 81E823FF88;
        Mon, 23 Dec 2019 15:20:27 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=flawful.org header.i=@flawful.org header.b=E+AB4TDP;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=flawful.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JoEtkJlzAztB; Mon, 23 Dec 2019 15:20:26 +0100 (CET)
Received: from flawful.org (ua-84-217-220-205.bbcust.telenor.se [84.217.220.205])
        (Authenticated sender: mb274189)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id A101A3FF7F;
        Mon, 23 Dec 2019 15:20:25 +0100 (CET)
Received: by flawful.org (Postfix, from userid 1001)
        id 261241496; Mon, 23 Dec 2019 15:20:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flawful.org; s=mail;
        t=1577110825; bh=YctLqQstM2RVCMZgTLiBTPIfDGVU6P21oJ4N0sJMepc=;
        h=From:To:Cc:Subject:Date:From;
        b=E+AB4TDPWHTerlPCA3RLFixjE89ykQIfqRO2IolXSuzVRZARtea6k5gzhrtpjZtfg
         hzmRy7HVy1iQIBzDQ2fv79FL+OSMiMDu/WRiF3HLt5uWhaPfM0H8WK2O1dX/UBqMCJ
         xAf8+JHhD2FmIAhQAaMzhoLwoAwKp1UGFMkIuruY=
From:   Niklas Cassel <nks@flawful.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: [PATCH 0/5] qcom-cpr fixes for rjw bleeding-edge
Date:   Mon, 23 Dec 2019 15:19:29 +0100
Message-Id: <20191223141934.19837-1-nks@flawful.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Rafael,

Here comes some bug fixes for qcom-cpr that were detected
once the driver got some more build testing.

Patches 1-2 fix warnings detected by the intel test robot.

Patch 3 fixes an error I detected when doing an allnoconfig
and enabling simply the qcom-cpr driver.

Patches 4-5 are only detected when building with W=1.
However, I decided to fix these as well, in order to hopefully
avoid any further build test reports.

The series is based on your bleeding-edge branch.
Feel free to squash them with the existing commit if you
so desire.

Niklas Cassel (5):
  power: avs: qcom-cpr: fix invalid printk specifier in debug print
  power: avs: qcom-cpr: fix unsigned expression compared with zero
  power: avs: qcom-cpr: make sure that regmap is available
  power: avs: qcom-cpr: remove set but unused variable
  power: avs: qcom-cpr: make cpr_get_opp_hz_for_req() static

 drivers/power/avs/Kconfig    |  1 +
 drivers/power/avs/qcom-cpr.c | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.24.1

