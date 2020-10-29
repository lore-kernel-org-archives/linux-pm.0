Return-Path: <SRS0=VPpk=EE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013E3C4363A
	for <linux-pm@archiver.kernel.org>; Thu, 29 Oct 2020 19:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC4220756
	for <linux-pm@archiver.kernel.org>; Thu, 29 Oct 2020 19:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ho+Au2HM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgJ2TDM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 29 Oct 2020 15:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgJ2TDM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 15:03:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CF1C0613CF;
        Thu, 29 Oct 2020 12:03:11 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ce9003d743c4902fedd6b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:e900:3d74:3c49:2fe:dd6b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9264A1EC04CB;
        Thu, 29 Oct 2020 20:03:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603998189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=5g6+L4dmcjH0AZJZPbI+QWg3eUgbDM06/9Jfcu8DQ28=;
        b=ho+Au2HMYcADRJAr1mGTsWhNAGn+r0OL7URMHYVD45z49M51RYnJbMvs5GerfJ9ZwznJ3Z
        sx+zWL+Nma2gP4IMsCYrEX7u7cAIhZ8F5sc5+oOhtUN6rgERXgmBYfZQswKnmUA6nAmTST
        ABo6YFJDzAGgTqCTvw/aA2yJPaMGqcI=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/4] x86: Remove direct use of MSR_IA32_ENERGY_PERF_BIAS
Date:   Thu, 29 Oct 2020 20:02:55 +0100
Message-Id: <20201029190259.3476-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi,

here's v2 with some of Shuah's comments integrated.

If no one has anything against it, I'll route them all through tip.

Thx.

---
Changelog:

v0:
--

here's something from my todo list: remove all in-kernel tools use of
that MSR and lastly drop it from the allowed-MSRs-list in the filtering.

Out-of-tree tools should do a similar, trivial conversion.

Constructive comments are, as always, appreciated.

Borislav Petkov (4):
  tools/power/cpupower: Read energy_perf_bias from sysfs
  tools/power/turbostat: Read energy_perf_bias from sysfs
  tools/power/x86_energy_perf_policy: Read energy_perf_bias from sysfs
  x86/msr: Do not allow writes to MSR_IA32_ENERGY_PERF_BIAS

 arch/x86/kernel/msr.c                         |   3 -
 tools/power/cpupower/lib/cpupower.c           |  23 +++-
 tools/power/cpupower/lib/cpupower_intern.h    |   5 +
 tools/power/cpupower/utils/cpupower-info.c    |   2 +-
 tools/power/cpupower/utils/cpupower-set.c     |   2 +-
 tools/power/cpupower/utils/helpers/helpers.h  |   8 +-
 tools/power/cpupower/utils/helpers/misc.c     |  48 ++++++++
 tools/power/cpupower/utils/helpers/msr.c      |  28 -----
 tools/power/x86/turbostat/turbostat.c         |  29 ++++-
 .../x86_energy_perf_policy.c                  | 109 ++++++++++++++++--
 10 files changed, 204 insertions(+), 53 deletions(-)

-- 
2.21.0

