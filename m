From: Thomas Abraham <ta.omasab@gmail.com>
Subject: [PATCH v3 0/2] cpufreq: opp: Add device tree based lookup of boost mode frequency
Date: Wed, 14 May 2014 06:32:58 +0530
Message-ID: <1400029380-5372-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: rjw@rjwysocki.net, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, thomas.ab@samsung.com
List-Id: linux-pm@vger.kernel.org

Changes since v2:
- Reworked based on the "PM / OPP: move cpufreq specific helpers out of OPP layer"
  patch series posted by Nishanth Menon <nm@ti.com>.

Changes since v1:
- Boost mode frequencies are specfied as a set of frequencies instead of
  specifying them as OPPs. Thanks to Nishanth, Lukasz and Rob for the
  feedback.

Commit 6f19efc0 ("cpufreq: Add boost frequency support in core") adds
support for CPU boost mode for CPUfreq drivers. To use the new boost
mode, CPUfreq drivers have to specify the boost mode frequency and
voltage within the CPUfreq driver, which is the case for Exynos4x12
CPUfreq driver.

But for CPUfreq drivers which obtain the OPPs from cpus node, this
patch series adds support to specify boost mode frequencies in the
cpu device tree node. This requirement came up when Lukasz pointed
out the regression caused by the Exynos CPUfreq driver consolidation
patches.

Thomas Abraham (2):
  cpufreq / OPP: Allow boost frequency to be looked up from device tree
  Documentation: devicetree: Add boost-frequency binding to list boost mode frequency

 .../devicetree/bindings/cpufreq/cpufreq-boost.txt  |   11 ++++++
 drivers/cpufreq/cpufreq_opp.c                      |   39 ++++++++++++++++++++
 2 files changed, 50 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt

-- 
1.7.4.4
