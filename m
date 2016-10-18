From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V4 0/5] firmware: Add support for TI System Control Interface
 (TI-SCI) protocol driver
Date: Tue, 18 Oct 2016 18:08:32 -0500
Message-ID: <20161018230837.6515-1-nm@ti.com>
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
To: Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Kevin Hilman <khilman@baylibre.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Davis <afd@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Russ Dill <Russ.Dill@ti.com>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Version 4 of the series is basically a rebase to v4.9-rc1, no functional
changes.

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


V4 of the series is based off v4.9-rc1 and is also available here:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.10/tisci-base-v4
Quick boot test: http://pastebin.ubuntu.com/23346183/

Changes since v3:
	- rebase to v4.9-rc1
	- minor checkpatch fixes

V3: https://lkml.org/lkml/2016/9/6/747
V2: https://lkml.org/lkml/2016/8/30/273
V1: https://lkml.org/lkml/2016/8/19/768

Nishanth Menon (5):
  Documentation: Add support for TI System Control Interface (TI-SCI)
    protocol
  firmware: Add basic support for TI System Control Interface (TI-SCI)
    protocol
  firmware: ti_sci: Add support for Device control
  firmware: ti_sci: Add support for Clock control
  firmware: ti_sci: Add support for reboot core service

 .../devicetree/bindings/arm/keystone/ti,sci.txt    |   81 +
 MAINTAINERS                                        |   10 +
 drivers/firmware/Kconfig                           |   15 +
 drivers/firmware/Makefile                          |    1 +
 drivers/firmware/ti_sci.c                          | 1991 ++++++++++++++++++++
 drivers/firmware/ti_sci.h                          |  492 +++++
 include/linux/soc/ti/ti_sci_protocol.h             |  249 +++
 7 files changed, 2839 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
 create mode 100644 drivers/firmware/ti_sci.c
 create mode 100644 drivers/firmware/ti_sci.h
 create mode 100644 include/linux/soc/ti/ti_sci_protocol.h

-- 
2.10.0
