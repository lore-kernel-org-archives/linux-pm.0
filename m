Return-Path: <SRS0=eR+e=6A=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB3CC352BE
	for <linux-pm@archiver.kernel.org>; Thu, 16 Apr 2020 05:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5707214AF
	for <linux-pm@archiver.kernel.org>; Thu, 16 Apr 2020 05:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406805AbgDPFsQ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 16 Apr 2020 01:48:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:38370 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405910AbgDPFsM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Apr 2020 01:48:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E8098ACAE;
        Thu, 16 Apr 2020 05:48:06 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Doug Smythies <dsmythies@telus.net>,
        Like Xu <like.xu@linux.intel.com>,
        Neil Rickert <nwr10cst-oslnx@yahoo.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 0/4] Frequency invariance fixes for x86
Date:   Thu, 16 Apr 2020 07:47:41 +0200
Message-Id: <20200416054745.740-1-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Patches 1-3 address bugs in the current frequency invariance support for x86,
including the incompatibility with cpu0 hotplug reported by Chris Wilson at
https://lore.kernel.org/lkml/158556634294.3228.4889951961483021094@build.alporthouse.com/
and the issue with CPUs that have less than 4 cores pointed out earlier
today by Like Xu at
https://lore.kernel.org/lkml/20200416021210.170736-1-like.xu@linux.intel.com/ 

Patch 4 is a minor code reorganization.

Giovanni Gherdovich (3):
  x86, sched: Bail out of frequency invariance if base frequency is
    unknown
  x86, sched: Account for CPUs with less than 4 cores in freq.
    invariance
  x86, sched: Move check for CPU type to caller function

Peter Zijlstra (Intel) (1):
  x86, sched: Don't enable static key when starting secondary CPUs

 arch/x86/kernel/smpboot.c | 47 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 14 deletions(-)

-- 
2.16.4

