From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v2 0/4] ARM: K2G: Add support for TI-SCI Generic PM Domains
Date: Wed, 19 Oct 2016 15:33:43 -0500
Message-ID: <20161019203347.17893-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([198.47.19.12]:47693 "EHLO arroyo.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941389AbcJSUeq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Oct 2016 16:34:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>, Sudeep Holla <sudeep.holla@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>

Hi,
This is v2 of the series to add support for TI SCI PM Domains. v1 of
the series can be found here [1]. Several things have changed since v1:

- New patch to add a void *data to struct generic_pm_domain_data to
  allow to store per device data associated with a genpd
- From v1, squash patch 1 and 2 to introduce docs and dt-bindings in
  one patch based on comment from Ulf
- Fix some grammar errors in Documentation
- Based on comments from Ulf, rework actual genpd implementation to
  avoid creating one genpd per device and instead use device start/stop
  hooks provided as part of genpd to control device state based on pm_runtime
  implementation. Also make use of new of_genpd_add_provider_simple API
  introduced by Jon Hunter and do not provide custom of_xlate to genpd core,
  instead registering devices as they probe through attach_dev hook provided
  by genpd framework.

Most of the changes were motivated by the comments from Ulf Hannson on v1 that we
should not use a 1-to-1 genpd to device mapping. The new approach allows us to
create a single genpd and store information about each device as they attach to
the genpd. Then the device start/stop hooks for that genpd leverage the
per-device data to control power states over the TI SCI protocol.

This driver makes use of the ti_sci driver sent here [2] by Nishanth Menon and
applies on top of his series on v4.9-rc1.

Regards,
Dave

[1] http://www.spinics.net/lists/arm-kernel/msg525204.html
[2] http://www.spinics.net/lists/arm-kernel/msg536851.html

Dave Gerlach (4):
  PM / Domains: Add generic data pointer to genpd data struct
  dt-bindings: Add TI SCI PM Domains
  soc: ti: Add ti_sci_pm_domains driver
  ARM: keystone: Drop PM domain support for k2g

 .../devicetree/bindings/soc/ti/sci-pm-domain.txt   |  54 ++++++
 MAINTAINERS                                        |   3 +
 arch/arm/mach-keystone/Kconfig                     |   1 +
 arch/arm/mach-keystone/pm_domain.c                 |   4 +-
 drivers/soc/ti/Kconfig                             |  12 ++
 drivers/soc/ti/Makefile                            |   1 +
 drivers/soc/ti/ti_sci_pm_domains.c                 | 198 +++++++++++++++++++++
 include/dt-bindings/genpd/k2g.h                    |  90 ++++++++++
 include/linux/pm_domain.h                          |   1 +
 9 files changed, 363 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 create mode 100644 drivers/soc/ti/ti_sci_pm_domains.c
 create mode 100644 include/dt-bindings/genpd/k2g.h

-- 
2.9.3

