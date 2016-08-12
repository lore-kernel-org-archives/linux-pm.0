From: Markus Mayer <mmayer@broadcom.com>
Subject: [PATCH 0/3] Broadcom AVS CPUfreq driver
Date: Fri, 12 Aug 2016 16:25:28 -0700
Message-ID: <1471044331-2480-1-git-send-email-mmayer@broadcom.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36790 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbcHLXZw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Aug 2016 19:25:52 -0400
Received: by mail-qk0-f172.google.com with SMTP id l2so846189qkf.3
        for <linux-pm@vger.kernel.org>; Fri, 12 Aug 2016 16:25:52 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Device Tree List <devicetree@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>

This series contains the CPUfreq driver for Broadcom SoCs that use "AVS
Firmware" for voltage and frequency scaling. All voltage and frequency
transitions are performed by the firmware and are therefore hidden from
Linux.

The driver provides a standard CPUfreq interface to other kernel
components and to userland on the one hand and communicates with the
AVS co-processor on the other.

Communication between the two processors is via shared mailbox
registers and interrupts (ARM -> AVS to tell the firmware that there is
a command to process and AVS -> ARM to tell the driver that a command
finished executing).

Markus Mayer (3):
  dt: cpufreq: brcm: New binding document for brcm-avs-cpufreq
  cpufreq: brcm-avs-cpufreq: AVS CPUfreq driver for Broadcom SoCs
  cpufreq: brcm-avs-cpufreq: add debugfs support

 .../bindings/cpufreq/brcm-avs-cpufreq.txt          |   84 ++
 MAINTAINERS                                        |    8 +
 drivers/cpufreq/Kconfig.arm                        |   10 +
 drivers/cpufreq/Makefile                           |    1 +
 drivers/cpufreq/brcm-avs-cpufreq.c                 | 1000 ++++++++++++++++++++
 5 files changed, 1103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/brcm-avs-cpufreq.txt
 create mode 100644 drivers/cpufreq/brcm-avs-cpufreq.c

-- 
2.7.4

