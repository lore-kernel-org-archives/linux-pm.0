Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76375CCA480
	for <linux-pm@archiver.kernel.org>; Wed, 29 Jun 2022 03:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiF2Dpm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 28 Jun 2022 23:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiF2Dpk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2022 23:45:40 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BD51838C;
        Tue, 28 Jun 2022 20:45:39 -0700 (PDT)
X-UUID: 62d1a1c3ad8744719647c2d7e9496a8b-20220629
X-GW-Reason: 13103
X-Policy-Incident: 5pS25Lu25Lq66LaF6L+HNeS6uumcgOimgeWuoeaguA==
X-Content-Feature: ica/max.line-size 71
        dict/adv 1
        dict/notice 2
        dict/time 2
        meta/cnt.alert 1
X-CPASD-INFO: 7cc0b75fc07a42879c24f8fe93ef2c33@gLOdUI9pY5aPUHmtg3WDcVmUYmSWZIa
        0e22FmGCTX1OVgnxsTWBnX1OEgnBQYl5dZFZ3dG9RYmBgYlB_i4Jyj1RiXmCCVHSTgHmdg2KQZw==
X-CLOUD-ID: 7cc0b75fc07a42879c24f8fe93ef2c33
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:2.0,URL:-5,TVAL:186.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:65.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5.
        0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:2.0,CFOB:2.0,SPC:0,SIG:-5
        ,AUF:7,DUF:134,ACD:2,DCD:2,SL:0,EISP:0,AG:0,CFC:0.347,CFSR:0.105,UAT:0,RAF:0,
        IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0,EAF:0
        ,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 62d1a1c3ad8744719647c2d7e9496a8b-20220629
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 62d1a1c3ad8744719647c2d7e9496a8b-20220629
X-User: xiongxin@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <xiongxin@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1566450409; Wed, 29 Jun 2022 09:12:14 +0800
From:   xiongxin <xiongxin@kylinos.cn>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        xiongxin@kylinos.cn, luriwen@kylinos.cn
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next 0/2] PM: suspend: Optimized suspend is fail returned by wakeup
Date:   Wed, 29 Jun 2022 09:11:44 +0800
Message-Id: <20220629011146.299521-1-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When the suspend process is executed from the /sys/power/state entry,
the pm_wakeup_clear() signal is cleared in advance, and the wakeup
signal can be captured to fail the suspend process when the suspend
process is notified by the notifier;

Expanding the scope of the pm_suspend_target_state variable also allows
the device driver to know that the system has entered the suspend
process earlier.

xiongxin (2):
  PM: suspend: expand the assignment scope of the
    pm_suspend_target_state
  PM: suspend: advanced pm_wakeup_clear() for normal suspend/hibernate

 kernel/power/process.c |  5 ++++-
 kernel/power/suspend.c | 13 +++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
