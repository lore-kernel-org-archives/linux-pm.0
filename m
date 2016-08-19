From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/5] firmware: Add support for TI System Control Interface
 (TI-SCI) protocol driver
Date: Fri, 19 Aug 2016 17:51:54 -0500
Message-ID: <20160819225159.10758-1-nm@ti.com>
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
To: Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew
 F . Davis" <afd@ti.com>, devicetree@vger.kernel.org, Russ Dill <Russ.Dill@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi,

Texas Instruments' Keystone generation System on Chips (SoC)
starting with 66AK2G02[1], now include a dedicated SoC System Control
entity called PMMC(Power Management Micro Controller) in line with
ARM architecture recommendations. The function of this module is
to integrate all system operations in a centralized location.
Communication with the SoC System Control entity from various
processing units like ARM/DSP occurs over Message Manager hardware
block.

This series adds the base support for TI System Control Interface
(TI-SCI) protocol[2]. The protocol is built on top of Texas
Instrument's Message Manager communication mechanism[3].

Overall architecture is very similar to SCPI[4] as follows:
+-------------+   +---------+     +------^-----+
| TI SCI GENPD|   |TISCI Clk|     |TISCI reset |
+------+------+   +----+----+     +------+-----+
       |               |                 |
       |          +----v--------------+  |
       +----------> TISCI Protocol(*) <--+
                  +----+--------------+
                       |
                   +---v-----------+
                   | MAILBOX  FWK  |
                   +---+-----------+
                       |
                   +---v-----------+
                   |  TI MSGMGR    |-> TISCI hardware block
                   +---------------+

(*) This series.

NOTE: Given that this is fundamental to the Keystone generation of SoC
starting with K2G, I have taken the liberty of adding Santosh, Tero
and myself as maintainers to these driver. Do let me know if that is
not appropriate.

[1] http://www.ti.com/product/66ak2g02
[2] http://processors.wiki.ti.com/index.php/TISCI
[3] Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
[4] Documentation/devicetree/bindings/arm/arm,scpi.txt

Baseline: v4.8-rc1
boot log: http://pastebin.ubuntu.com/23071570/ (with additional SoC specific dts patches)
Patches can also be found: https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.9/tisci-base-v1

PS: We believe the churn is done in the protocol over the last 2 TI
vendor kernel versions and minimal changes may be involved in the
future. Obviously, a lot of folks (especially Russ Dill) have been
involved in making this happen.. unfortunately, the list is a bit too
long to elaborate here :(

Nishanth Menon (5):
  Documentation: Add support for TI System Control Interface (TI-SCI)
    protocol
  firmware: Add basic support for TI System Control Interface (TI-SCI)
    protocol
  firmware: ti_sci: Add support for Device control
  firmware: ti_sci: Add support for Clock control
  firmware: ti_sci: Add support for reboot core service

 .../devicetree/bindings/arm/keystone/ti,sci.txt    |   66 +
 MAINTAINERS                                        |   10 +
 drivers/firmware/Kconfig                           |   15 +
 drivers/firmware/Makefile                          |    1 +
 drivers/firmware/ti_sci.c                          | 1993 ++++++++++++++++++++
 drivers/firmware/ti_sci.h                          |  492 +++++
 include/linux/soc/ti/ti_sci_protocol.h             |  249 +++
 7 files changed, 2826 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
 create mode 100644 drivers/firmware/ti_sci.c
 create mode 100644 drivers/firmware/ti_sci.h
 create mode 100644 include/linux/soc/ti/ti_sci_protocol.h

-- 
2.9.1.200.gb1ec08f
