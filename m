From: Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [RESEND PATCH v2 0/3] Broadcom AVS CPUfreq driver
Date: Fri, 30 Sep 2016 14:55:58 -0700
Message-ID: <1475272561-8446-1-git-send-email-mmayer@broadcom.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Broadcom Kernel List <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Device Tree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Power Management List <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
