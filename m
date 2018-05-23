From: Ilia Lin <ilialin@codeaurora.org>
Subject: [PATCH v10 0/2] Kryo CPU scaling driver
Date: Wed, 23 May 2018 12:40:52 +0300
Message-ID: <1527068454-28921-1-git-send-email-ilialin@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

[v10]
 * Split the series into domains
 * Addressed comments from Viresh and Sudeep about logical CPU numbering.

The qcom-cpufreq-kryo driver is aimed to support different SOC versions.
The driver reads eFuse information and chooses the required OPP subset
by passing the OPP supported-hw parameter.

The series depends on the series from Viresh:
https://patchwork.kernel.org/patch/10418139/

The previous spin was here:
https://patchwork.kernel.org/patch/10420751/
https://patchwork.kernel.org/patch/10414761/

Ilia Lin (2):
  cpufreq: Add Kryo CPU scaling driver
  dt-bindings: cpufreq: Document operating-points-v2-kryo-cpu

 .../devicetree/bindings/opp/kryo-cpufreq.txt       | 680 +++++++++++++++++++++
 drivers/cpufreq/Kconfig.arm                        |  10 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c               |   3 +
 drivers/cpufreq/qcom-cpufreq-kryo.c                | 163 +++++
 5 files changed, 857 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
 create mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c

-- 
1.9.1
