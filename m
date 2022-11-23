Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F379C4332F
	for <linux-pm@archiver.kernel.org>; Wed, 23 Nov 2022 11:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbiKWLSt (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 23 Nov 2022 06:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236577AbiKWLSr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2022 06:18:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA49B2CE19
        for <linux-pm@vger.kernel.org>; Wed, 23 Nov 2022 03:18:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2C682220CB;
        Wed, 23 Nov 2022 11:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669202325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=00OhBU4iXoxiaePx3pyjTPJdpW1s+hcCdeVze4o3PIs=;
        b=vayAqOHjjJx1lxNDdMBH85hJtiVmnZL2EUcOf/YZjS/33fInCH9bJPm2EjpBFuKzk1k7KT
        3TSFdPVzmaECugj2k5ZrwokjUbTIxZ6pAonzopNtLGO2b3gaeYL0N2iXwPQ9027FqTF9Xc
        K6WuFkKUrXgOqb4Ew5DLjkrqrFoRvkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669202325;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=00OhBU4iXoxiaePx3pyjTPJdpW1s+hcCdeVze4o3PIs=;
        b=cyNqnH3EcIrrvgtTdKXwX27siqLx1x1H25tJ3+FHzxOWrSXd1Y9wld9prXI1jutOa2nXhm
        zLpoiVW0YIVOsqDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02D1A13A37;
        Wed, 23 Nov 2022 11:18:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zYn+OpQBfmNaRwAAMHmgww
        (envelope-from <trenn@suse.de>); Wed, 23 Nov 2022 11:18:44 +0000
From:   Thomas Renninger <trenn@suse.de>
To:     skhan@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, Thomas Renninger <trenn@suse.de>
Subject: [PATCH 0/2] Introduce powercap userspace frontend
Date:   Wed, 23 Nov 2022 12:18:08 +0100
Message-Id: <20221123111810.16017-1-trenn@suse.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

cpupower powercap-info
cpupower monitor -m RAPL

further development could provide:
cpupower powercap-set
to enable/disable RAPL domains, etc.

Thomas Renninger (2):
  cpupower: Introduce powercap intel-rapl library and powercap-info
    command
  cpupower: rapl monitor - shows the used power consumption in uj for
    each rapl domain

 tools/power/cpupower/Makefile                 |  15 +-
 tools/power/cpupower/lib/powercap.c           | 290 ++++++++++++++++++
 tools/power/cpupower/lib/powercap.h           |  54 ++++
 .../cpupower/man/cpupower-powercap-info.1     |  25 ++
 tools/power/cpupower/utils/builtin.h          |   2 +
 tools/power/cpupower/utils/cpupower.c         |   1 +
 .../utils/idle_monitor/cpupower-monitor.c     |   7 +-
 .../utils/idle_monitor/idle_monitors.def      |   1 +
 .../utils/idle_monitor/rapl_monitor.c         | 148 +++++++++
 tools/power/cpupower/utils/powercap-info.c    | 117 +++++++
 10 files changed, 653 insertions(+), 7 deletions(-)
 create mode 100644 tools/power/cpupower/lib/powercap.c
 create mode 100644 tools/power/cpupower/lib/powercap.h
 create mode 100644 tools/power/cpupower/man/cpupower-powercap-info.1
 create mode 100644 tools/power/cpupower/utils/idle_monitor/rapl_monitor.c
 create mode 100644 tools/power/cpupower/utils/powercap-info.c

-- 
2.37.1

