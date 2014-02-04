From: Thomas Abraham <ta.omasab@gmail.com>
Subject: [PATCH 0/2] Add device tree based lookup of boost mode OPPs
Date: Tue,  4 Feb 2014 15:11:28 +0530
Message-ID: <1391506890-7335-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: rjw@rjwysocki.net, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, thomas.ab@samsung.com
List-Id: linux-pm@vger.kernel.org

Commit 6f19efc0 ("cpufreq: Add boost frequency support in core") adds
support for CPU boost mode for CPUfreq drivers. To use the new boost
mode, CPUfreq drivers have to specify the boost mode frequency and
voltage within the CPUfreq driver, which is the case for Exynos4x12
CPUfreq driver.

But for CPUfreq drivers which obtain the OPPs from cpus node, this
patch series adds support to specify boost mode OPPs in dt node. This
requirement came up when Lukasz pointed out the regression caused by
the Exynos CPUfreq driver consolidation patches.

Thomas Abraham (2):
  PM / OPP: Add support for 'boost' mode OPP
  Documentation: devicetree: Add boost-opp binding to list boost mode OPPs

 Documentation/devicetree/bindings/power/opp.txt |    9 +++
 drivers/base/power/opp.c                        |   69 ++++++++++++++++++-----
 2 files changed, 65 insertions(+), 13 deletions(-)

-- 
1.7.10.4
