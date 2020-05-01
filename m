Return-Path: <SRS0=hlrK=6P=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D61BC4724C
	for <linux-pm@archiver.kernel.org>; Fri,  1 May 2020 15:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B7624957
	for <linux-pm@archiver.kernel.org>; Fri,  1 May 2020 15:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="jL4fRjRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgEAPLU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 1 May 2020 11:11:20 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:62052 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbgEAPLU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 May 2020 11:11:20 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49DG1238SPz7N;
        Fri,  1 May 2020 17:11:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588345878; bh=cdEPjXnsn5z8U7feR9uktwJxgwGG0ztxZgZbcfEtYks=;
        h=Date:From:Subject:To:Cc:From;
        b=jL4fRjRpYzfcA9Nv12xAeNOFmBtEmxww0u+tL3y2bOYqE2ds7pjoFYO/XGFHTahFc
         opp/YGBwgz2PhAsEL1pxDapBHfJT4hSojWGf/OlkjFec3FX8h+FVlEAMa79XGExzQt
         leRLTj14QRP2cmay8emfx13+2unibV6wSNlT+kZdgModSuonJBii3PQPUGiemT1zFD
         aluCyky8t3e5KnAzuowtF7b8TlIKKsjgGiGF6D/ulby1Ja8okxTrlg6QwNcnPieB3d
         QEnuxJ25yykh1vHnVSHA4bsNEXnTiENF1dG35s67jY/xCOk13UkwsE83nDVJAlyGb8
         yGrFjMgDzrtHQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 01 May 2020 17:11:18 +0200
Message-Id: <cover.1588345420.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 0/4] power: supply: core: extend with new properties
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series extend power supply class core with additional properties
for measurements of power supply input and output power.

v4 is a rebase on top of recently applied first part of v3, including
patch 1 workaround for gcc and clang bugs.

Michał Mirosław (4):
  power: supply: core: tabularize HWMON temperature labels
  power: supply: core: add input voltage/current measurements
  power: supply: core: add output voltage measurements
  power: supply: core: document measurement points

 Documentation/power/power_supply_class.rst |   6 +
 drivers/power/supply/power_supply_hwmon.c  | 142 ++++++++++++++++++++-
 drivers/power/supply/power_supply_sysfs.c  |   5 +
 include/linux/power_supply.h               |   5 +
 4 files changed, 152 insertions(+), 6 deletions(-)

-- 
2.20.1

