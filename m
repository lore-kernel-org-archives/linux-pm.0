From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v3 0/3] firmware: qcom: scm: Add cpu power on/off support
Date: Mon,  2 Mar 2015 13:30:04 -0700
Message-ID: <1425328207-58415-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, khilman@linaro.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This series of patches adds SCM cold boot clean up and support for warm boot
for QCOM quad core (and dual core) cpus.

v3 Changed:
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
 include/linux/qcom_scm.h     |  16 ++---
 3 files changed, 162 insertions(+), 29 deletions(-)

-- 
2.1.0
