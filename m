From: Markus Mayer <code@mmayer.net>
Subject: [PATCH v5 0/3] Broadcom STB AVS CPUfreq driver
Date: Thu, 27 Oct 2016 14:05:33 -0700
Message-ID: <20161027210536.98988-1-code@mmayer.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Device Tree List <devicetree@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>
List-Id: linux-pm@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

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

Changes from v4:
    - Addressed comments regarding the binding document (see also
      https://lkml.org/lkml/2016/10/19/642)
    - Added Virsh's Acks
    - Rebased on v4.9-rc1
    - Patches sent from non-Broadcom account on purpose to prevent series
      from being marked as spam (this is currently happening for some
      recipients)
    - No changes to any code

Changes from v3:
    - moved code from brcm_avs_cpufreq_exit() into brcm_avs_cpufreq_remove()
    - removed brcm_avs_cpufreq_exit() altogether

Changes from v2:
    - removed file Documentation/cpu-freq/brcmstb-avs-cpufreq.txt, instead
      adding the text as comment in the driver itself
    - wildcard match in MAINTAINERS file (drivers/cpufreq/brcmstb*)
    - drivers/cpufreq/Kconfig.arm: have ARM_BRCMSTB_AVS_CPUFREQ default y
      for ARCH_BRCMSTB
    - fixed naming and Kconfig entry for CONFIG_ARM_BRCMSTB_AVS_CPUFREQ_DEBUG
    - reordered and fixed include files
    - made sure driver name doesn't exceed size of cpufreq_driver.name
    - got rid of device_node pointers in struct private_data; there's no
      need for them, as we can call of_node_put() in __map_region()
    - don't set driver_data for CPUFREQ_TABLE_END
    - have brcm_avs_cpufreq_get() read from the firmware rather than return
      policy->cur
    - don't update policy->cur in brcm_avs_target_index()
    - created new function brcm_avs_prepare_init() to handle compatibility
      checks during initialization and moved corresponding code from
      brcm_avs_cpufreq_init() to the new function
    - brcm_avs_prepare_init() is called from brcm_avs_cpufreq_probe() and
      therefore will only be called once, even in the case of an error,
      whereas brcm_avs_cpufreq_init() is called for every core if there is
      an error
    - renamed brcm_avs_cpu_(init|exit) to brcm_avs_cpufreq_(init|exit)
    - added platform_set_drvdata(pdev, NULL) upon deregistration
    - fixed various style complaints by checkpatch.pl --strict
    - fixed other style issues
    - updated and improved some comments
    - added Viresh's Acks to patches 1/3 and 3/3

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

 .../bindings/cpufreq/brcm,stb-avs-cpu-freq.txt     |   78 ++
 MAINTAINERS                                        |    8 +
 drivers/cpufreq/Kconfig.arm                        |   21 +
 drivers/cpufreq/Makefile                           |    1 +
 drivers/cpufreq/brcmstb-avs-cpufreq.c              | 1057 ++++++++++++++++++++
 5 files changed, 1165 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/brcm,stb-avs-cpu-freq.txt
 create mode 100644 drivers/cpufreq/brcmstb-avs-cpufreq.c

-- 
2.7.4
