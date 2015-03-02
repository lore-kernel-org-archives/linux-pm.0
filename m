From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v4 0/3] firmware: qcom: scm: Add cpu power on/off support
Date: Mon,  2 Mar 2015 16:30:27 -0700
Message-ID: <1425339030-45828-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:38348 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960AbbCBXam (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2015 18:30:42 -0500
Received: by padbj1 with SMTP id bj1so47785920pad.5
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2015 15:30:42 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, khilman@linaro.org, Lina Iyer <lina.iyer@linaro.org>

Hi,

This series of patches adds SCM cold boot clean up and support for warm boot
for QCOM quad core (and dual core) cpus.

v4 Changes:
- Added QCOM_SCM_CPU_DOWN_ prefix for L2 on/off enums, relocated them to be close
  to the function declaration.

v3 Changes:
- Addressed review comments from Kumar.
	+ Cleaned up the cold boot api and the warm boot api to match
	+ Uniform qcom_scm_ prefix
- Add support for cpu power down using scm_call_atomic1() from [1].
	+ No longer dependent on the series from sboyd.

v2 Changes:
- Merge the warm boot patches into a single patch.

[1]. https://lkml.org/lkml/2014/8/4/765

Thanks,
Lina

Lina Iyer (3):
  firmware: qcom: scm: Clean cold boot entry to export only the API
  firmware: qcom: scm: Add qcom_scm_set_warm_boot_addr function
  firmware: qcom: scm: Support cpu power down through SCM

 arch/arm/mach-qcom/platsmp.c |  21 +-----
 drivers/firmware/qcom_scm.c  | 154 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/qcom_scm.h     |  17 +++--
 3 files changed, 163 insertions(+), 29 deletions(-)

-- 
2.1.0

