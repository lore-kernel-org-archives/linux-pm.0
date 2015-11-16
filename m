From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH v4 0/3] Dynamic power model from device tree
Date: Mon, 16 Nov 2015 19:30:22 +0000
Message-ID: <1447702225-13323-1-git-send-email-punit.agrawal@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:57705 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750878AbbKPTaq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2015 14:30:46 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, edubezval@gmail.com, dawei.chien@mediatek.com, javi.merino@arm.com

Hi,

This patchset adds support to build a single-coefficient dynamic power
model for a CPU. The model is used by the CPU cooling device to
provide an estimate of power consumption and also translate allocated
power to performance cap.

Changes from previous posting -

v3 -> v4:
arm_big_little: Migrated to using static arrays
arm_big_little: Updated Kconfig to support building thermal as module

Patch 1 extends the CPU nodes binding to provide an optional dynamic
power coefficient which can be used to create a dynamic power model
for the CPUs. This model is used to constrain device power consumption
(using power_allocator governor) when the system is thermally
constrained.

Patches 2-3 extends the cpufreq-dt and arm_big_little driver to
register cpu cooling devices with the dynamic coefficient when
provided.

The patches were previously posted at [0][1][2]. Mediatek platform
8173 builds on these bindings to build the power model.

If there are no objections, I'd appreciate Acks from device tree
bindings maintainers.

Thanks,
Punit

[0] http://thread.gmane.org/gmane.linux.kernel/2002152
[1] http://thread.gmane.org/gmane.linux.kernel/2011466
[2] http://marc.info/?l=linux-kernel&m=144709020014884&w=2

Punit Agrawal (3):
  devicetree: bindings: Add optional dynamic-power-coefficient property
  cpufreq-dt: Supply power coefficient when registering cooling devices
  cpufreq: arm_big_little: Add support to register a cpufreq cooling
    device

 Documentation/devicetree/bindings/arm/cpus.txt | 17 +++++++++++++
 drivers/cpufreq/Kconfig.arm                    |  2 ++
 drivers/cpufreq/arm_big_little.c               | 35 ++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt.c                   |  9 +++++--
 4 files changed, 61 insertions(+), 2 deletions(-)

-- 
2.6.2

