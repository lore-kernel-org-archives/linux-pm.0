From: Ilia Lin <ilialin@codeaurora.org>
Subject: [PATCH v15 0/2] Kryo CPU scaling driver
Date: Wed, 30 May 2018 05:39:27 +0300
Message-ID: <1527647969-15716-1-git-send-email-ilialin@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ilia.lin@gmail.com, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, ilialin@codeaurora.org
List-Id: linux-pm@vger.kernel.org

[v15]
 * Addressed the kbuild error

[v14]
 * Addressed comment from Sudeep about DT compatible
 * Added MAINTAINERS entry

[v13]
 * Addressed comment from Sudeep about DT compatible check on init

[v12]
 * Addressed comments from Sudeep and Viresh about the single init

[v11]
 * Addressed comment from Russel about device_node reference
 * Addressed comment from Sudeep about the late_initcall
 * Transformed init into probe to take care of deferals

[v10]
 * Split the series into domains
 * Addressed comments from Viresh and Sudeep about logical CPU numbering.

The qcom-cpufreq-kryo driver is aimed to support different SOC versions.
The driver reads eFuse information and chooses the required OPP subset
by passing the OPP supported-hw parameter.

The series depends on the series from Viresh:
https://patchwork.kernel.org/patch/10418139/

The previous spin was here:
https://patchwork.kernel.org/patch/10427315/

Ilia Lin (2):
  cpufreq: Add Kryo CPU scaling driver
  dt-bindings: cpufreq: Document operating-points-v2-kryo-cpu

 .../devicetree/bindings/opp/kryo-cpufreq.txt       | 680 +++++++++++++++++++++
 MAINTAINERS                                        |   7 +
 drivers/cpufreq/Kconfig.arm                        |  11 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c               |   3 +
 drivers/cpufreq/qcom-cpufreq-kryo.c                | 212 +++++++
 6 files changed, 914 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
 create mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c

-- 
1.9.1
