From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 0/2] Add SCM warmboot support for QCOM SoCs
Date: Wed, 25 Feb 2015 15:54:10 -0700
Message-ID: <1424904852-12719-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:44569 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbbBYWyh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Feb 2015 17:54:37 -0500
Received: by pdbnh10 with SMTP id nh10so8133937pdb.11
        for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2015 14:54:37 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: galak@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>

Hi,

These patches used to be part of my cpuidle patchset, think these can go in
independently.

The patches do the following -

1. Add QCOM Secure Monitor specific enumeration for warm boot on qcom targets
2. Add an API to set up the warmboot address. Consolidate the warm boot flags
into the implementation file 

Thanks,
Lina

Lina Iyer (2):
  ARM: qcom: Add SCM warmboot flags for quad core targets.
  qcom: scm: Add scm_set_warm_boot_addr function

 arch/arm/mach-qcom/scm-boot.c | 38 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-qcom/scm-boot.h |  5 +++--
 2 files changed, 41 insertions(+), 2 deletions(-)

-- 
2.1.0

