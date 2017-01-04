From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v3 0/4] ARM: K2G: Add support for TI-SCI Generic PM Domains
Date: Wed, 4 Jan 2017 14:55:32 -0600
Message-ID: <20170104205536.15963-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>, Sudeep Holla <sudeep.holla@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-pm@vger.kernel.org

Hi,
This is v3 of the series to add support for TI-SCI Generic PM Domains.
Previous versions can be found here:

v2: https://www.spinics.net/lists/kernel/msg2364612.html
v1: http://www.spinics.net/lists/arm-kernel/msg525204.html

This version is rebased on v4.10-rc2 but is the same as v2 with the
exception of patch 2 in which the devicetree binding documentation
needed to be updated to show the k2g_pds node should be a child of
the pmmc node. Apart from that, the acks provided by Ulf were added
to patches 1 and 3.

Now that the TI-SCI series has been merged [1] this series will be ready
to go in with an ack on the DT binding. Rob had raised some questions on
the necessity ti,sci-id property but I believe these were properly
addressed during the discussion of v2 so hopefully an ack is in order now.

Regards,
Dave

[1] http://www.spinics.net/lists/arm-kernel/msg536851.html

Dave Gerlach (4):
  PM / Domains: Add generic data pointer to genpd data struct
  dt-bindings: Add TI SCI PM Domains
  soc: ti: Add ti_sci_pm_domains driver
  ARM: keystone: Drop PM domain support for k2g

 .../devicetree/bindings/soc/ti/sci-pm-domain.txt   |  59 ++++++
 MAINTAINERS                                        |   3 +
 arch/arm/mach-keystone/Kconfig                     |   1 +
 arch/arm/mach-keystone/pm_domain.c                 |   4 +-
 drivers/soc/ti/Kconfig                             |  12 ++
 drivers/soc/ti/Makefile                            |   1 +
 drivers/soc/ti/ti_sci_pm_domains.c                 | 198 +++++++++++++++++++++
 include/dt-bindings/genpd/k2g.h                    |  90 ++++++++++
 include/linux/pm_domain.h                          |   1 +
 9 files changed, 368 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 create mode 100644 drivers/soc/ti/ti_sci_pm_domains.c
 create mode 100644 include/dt-bindings/genpd/k2g.h

-- 
2.11.0
