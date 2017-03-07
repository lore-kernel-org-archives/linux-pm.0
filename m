From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v4 0/5] ARM: K2G: Add support for TI-SCI Generic PM Domains
Date: Tue, 7 Mar 2017 04:22:29 -0600
Message-ID: <1488882154-21485-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi,
This is v4 of the series to add support for TI-SCI Generic PM Domains.
Previous versions can be found here:

v3: https://www.spinics.net/lists/kernel/msg2413975.html
v2: https://www.spinics.net/lists/kernel/msg2364612.html
v1: http://www.spinics.net/lists/arm-kernel/msg525204.html

After much debate I have returned to using the phandle cell to pass the SCI ID
rather than the separate "ti,sci-id" property that was not very popular. In
order to do this I needed to make a change to the genpd framework which can be
seen in patch 2 and should benefit others that have client . Rather than
checking for zero phandle args and failing if any are present the
of_genpd_add_provider_simple call does not check at all and instead leaves
parsing and interpretation up to the platform genpd driver.

This allows the ti_sci_pm_domains driver to parse the phandle and use the first
phandle cell as the sci-id rather than getting it from a separate property.

Besides that none of the original patches have changed apart from updating the
year to 2017 in patches 3 and 4 and of course a small update to patch 4 to let
the ti_sci_pm_domains parse the phandle and extract the sci-id rather than
looking for the rejected ti,sci-id property.

I did not update the "power-domain" binding document because in regards to
#power-domain-cells it already states "can be any value as specified by device
tree binding documentation of particular provider" which I think already
describes the change in patch 2.

Regards,
Dave

Dave Gerlach (5):
  PM / Domains: Add generic data pointer to genpd data struct
  PM / Domains: Do not check if simple providers have phandle cells
  dt-bindings: Add TI SCI PM Domains
  soc: ti: Add ti_sci_pm_domains driver
  ARM: keystone: Drop PM domain support for k2g

 .../devicetree/bindings/soc/ti/sci-pm-domain.txt   |  59 ++++++
 MAINTAINERS                                        |   3 +
 arch/arm/mach-keystone/Kconfig                     |   1 +
 arch/arm/mach-keystone/pm_domain.c                 |   4 +-
 drivers/base/power/domain.c                        |   2 -
 drivers/soc/ti/Kconfig                             |  12 ++
 drivers/soc/ti/Makefile                            |   1 +
 drivers/soc/ti/ti_sci_pm_domains.c                 | 202 +++++++++++++++++++++
 include/dt-bindings/genpd/k2g.h                    |  90 +++++++++
 include/linux/pm_domain.h                          |   1 +
 10 files changed, 372 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 create mode 100644 drivers/soc/ti/ti_sci_pm_domains.c
 create mode 100644 include/dt-bindings/genpd/k2g.h

-- 
2.11.0
