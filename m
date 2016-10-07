From: Markus Mayer <mmayer@broadcom.com>
Subject: [RESEND PATCH v2 0/3] Broadcom AVS CPUfreq driver
Date: Fri,  7 Oct 2016 16:20:03 -0700
Message-ID: <1475882406-1992-1-git-send-email-mmayer@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Device Tree List <devicetree@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>
List-Id: linux-pm@vger.kernel.org

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

lkml.org seems to be down for me. Here are patchwork links to the original
series:

https://patchwork.kernel.org/patch/9278119/
https://patchwork.kernel.org/patch/9278121/
https://patchwork.kernel.org/patch/9278127/

Changes from v1:
    - renamed binding document 
    - rewrote the introduction of the binding document
    - created a new driver documentation file that contains Linux specific
      information that was previously part of the binding document
    - renamed the driver (and related config options) to include a reference
      to "STB", since this implementation is primarily intended for use on
      set-top boxes
    - improved comments
    - updated function __map_region()
    - updated struct private_data
    - added code to unmap memory regions in the error and exit paths
    - added new sysfs property to report frequency directly from the
      co-processor register

Markus Mayer (3):
  dt: cpufreq: brcm: New binding document for brcmstb-avs-cpufreq
  cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for Broadcom STB SoCs
  cpufreq: brcmstb-avs-cpufreq: add debugfs support

 Documentation/cpu-freq/brcmstb-avs-cpufreq.txt     |   27 +
 .../bindings/cpufreq/brcm,stb-avs-cpu-freq.txt     |   77 ++
 MAINTAINERS                                        |    9 +
 drivers/cpufreq/Kconfig.arm                        |   10 +
 drivers/cpufreq/Makefile                           |    1 +
 drivers/cpufreq/brcmstb-avs-cpufreq.c              | 1026 ++++++++++++++++++++
 6 files changed, 1150 insertions(+)
 create mode 100644 Documentation/cpu-freq/brcmstb-avs-cpufreq.txt
 create mode 100644 Documentation/devicetree/bindings/cpufreq/brcm,stb-avs-cpu-freq.txt
 create mode 100644 drivers/cpufreq/brcmstb-avs-cpufreq.c

-- 
2.7.4
