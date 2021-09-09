Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3B7C433EF
	for <linux-pm@archiver.kernel.org>; Thu,  9 Sep 2021 08:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F8E16109E
	for <linux-pm@archiver.kernel.org>; Thu,  9 Sep 2021 08:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhIII50 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 9 Sep 2021 04:57:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232213AbhIII5Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Sep 2021 04:57:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C768611B0;
        Thu,  9 Sep 2021 08:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631177776;
        bh=ujCdNUpO/qOVpyAN9tlZP7oy3guFkGiQFv5iyV0yKK4=;
        h=From:To:Cc:Subject:Date:From;
        b=lKAaeKJDNYhH+hhiTekeu+rWcp14RDK5u/CHH8LPSDpzCabC40DWCOGRFqCyq23KY
         4cEDVDnoz5NrUQlnuLaIOFJDYj0WMkLmUzRQkV2ZhY3kNINeRrPTGvbP29H6as/Vn7
         A9Gbzt3hQvg3z/qbvbNTqimcu0NWismRHiKGi+JLSSlTaXxnHmuM+4XhSE5cqWL2du
         0g0X6gBbGdxUDyv1Vs8Z7RrWIic4Xd0vSBoZOT1BkPaKPBSDXmrESUAWr4FprRs7C3
         kK7fyQdbAz/2GffwhnPYBnICorq6r7jSP1DPeKEyNBoSsW5+fAAiTfrNUr62E0DZdf
         aN8E7j3Eqqwkw==
From:   Antoine Tenart <atenart@kernel.org>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     Antoine Tenart <atenart@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v2 0/2] thermal: int340x: fix tcc offset on resume
Date:   Thu,  9 Sep 2021 10:56:11 +0200
Message-Id: <20210909085613.5577-1-atenart@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This is a follow-up of [1]. As discussed in the initial thread, the fix
is now split into two commits: the two commits combined are fixing the
issue in a nice way for 5.15, but only the first one is meant to be
applied on stable kernels (to avoid conflicts).

The issue this is fixing is described in patch 1. Tl;dr: a
suspend/resume cycle can end-up in setting a wrong tcc offset value,
which can lead to machines shutting down because of overheating (when
they should not).

I've stripped the Acked-by/Tested-by flags from v1 as the patch was
split. But the end result for 5.15+ kernels should be the same.

Thanks,
Antoine

[1] https://lore.kernel.org/linux-pm/20210908161632.15520-1-atenart@kernel.org/T/

Antoine Tenart (2):
  thermal: int340x: do not set a wrong tcc offset on resume
  thermal: int340x: improve the tcc offset saving for suspend/resume

 .../intel/int340x_thermal/int3401_thermal.c   |  8 +++-
 .../processor_thermal_device.c                | 39 ++++++++++++++-----
 .../processor_thermal_device.h                |  1 +
 .../processor_thermal_device_pci.c            | 18 ++++++++-
 .../processor_thermal_device_pci_legacy.c     |  8 +++-
 5 files changed, 62 insertions(+), 12 deletions(-)

-- 
2.31.1

