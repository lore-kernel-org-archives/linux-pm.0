From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH V2 0/5] firmware: Add support for TI System Control Interface (TI-SCI) protocol driver
Date: Tue, 30 Aug 2016 08:06:42 -0500
Message-ID: <20160830130647.6828-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Thanks for the reviews on the patches, here is v2 of the series.

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

V2 of the series is based off v4.8-rc1 and is also available here:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.9/tisci-base-v2

V1 of the series: https://lkml.org/lkml/2016/8/19/768

Changes in V2 of the series:
	- Review comments incorporated from Lokesh and Rob
	- Minor cleanup of comments for debug interface.

[1] http://www.ti.com/product/66ak2g02
[2] http://processors.wiki.ti.com/index.php/TISCI
[3] Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
[4] Documentation/devicetree/bindings/arm/arm,scpi.txt

Related series (based on v1):

* https://lkml.org/lkml/2016/8/19/790 (GENPD for TISCI)
* https://lkml.org/lkml/2016/8/19/811 (Clock support for TISCI) 

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
 drivers/firmware/ti_sci.c                          | 1997 ++++++++++++++++++++
 drivers/firmware/ti_sci.h                          |  492 +++++
 include/linux/soc/ti/ti_sci_protocol.h             |  249 +++
 7 files changed, 2830 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
 create mode 100644 drivers/firmware/ti_sci.c
 create mode 100644 drivers/firmware/ti_sci.h
 create mode 100644 include/linux/soc/ti/ti_sci_protocol.h

-- 
2.9.1.200.gb1ec08f

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
