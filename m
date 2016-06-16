From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2 0/3] firmware: scpi: add device power domain support
Date: Thu, 16 Jun 2016 11:37:58 +0100
Message-ID: <1466073481-697-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42825 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751681AbcFPKiQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 16 Jun 2016 06:38:16 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jon Medhurst <tixy@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>

This series add support for SCPI based device device power state
management using genpd.

Regards,
Sudeep

v1[1]->v2:
	- Fixed the endianness handling in scpi_device_get_power_state
	  as spotted by Tixy
	- Renamed scpi_pd.c to scpi_pm_domain.c as suggested by Ulf
	- Added Mark's ack on DT binding

[1] https://marc.info/?l=linux-kernel&m=146522850003483&w=2

Sudeep Holla (3):
  firmware: arm_scpi: add support for device power state management
  Documentation: add DT bindings for ARM SCPI power domains
  firmware: scpi: add device power domain support using genpd

 Documentation/devicetree/bindings/arm/arm,scpi.txt |  34 +++++
 drivers/firmware/Kconfig                           |   9 ++
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/arm_scpi.c                        |  30 ++++
 drivers/firmware/scpi_pm_domain.c                  | 152 +++++++++++++++++++++
 include/linux/scpi_protocol.h                      |   2 +
 6 files changed, 228 insertions(+)
 create mode 100644 drivers/firmware/scpi_pm_domain.c

--
2.7.4

