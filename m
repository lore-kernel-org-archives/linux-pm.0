From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH V4 0/5] firmware: Add support for TI System Control
 Interface (TI-SCI) protocol driver
Date: Tue, 25 Oct 2016 20:34:48 +0300
Message-ID: <2694e4b5-20d5-f590-c6a6-55ff4cb8c16b@ti.com>
References: <20161018230837.6515-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161018230837.6515-1-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Dave Gerlach <d-gerlach@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Andrew Davis <afd@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Russ Dill <Russ.Dill@ti.com>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 19/10/16 02:08, Nishanth Menon wrote:
> Version 4 of the series is basically a rebase to v4.9-rc1, no functional
> changes.

Hi,

Any final comments on this series, or shall I send a pull-req forward? 
Very minimal changes compared to v3 so should be good to go imo.

-Tero

>
> Texas Instruments' Keystone generation System on Chips (SoC)
> starting with 66AK2G02[1], now include a dedicated SoC System Control
> entity called PMMC(Power Management Micro Controller) in line with
> ARM architecture recommendations. The function of this module is
> to integrate all system operations in a centralized location.
> Communication with the SoC System Control entity from various
> processing units like ARM/DSP occurs over Message Manager hardware
> block.
>
> This series adds the base support for TI System Control Interface
> (TI-SCI) protocol[2]. The protocol is built on top of Texas
> Instrument's Message Manager communication mechanism[3].
>
> Overall architecture is very similar to SCPI[4] as follows:
> +-------------+   +---------+     +------^-----+
> | TI SCI GENPD|   |TISCI Clk|     |TISCI reset |
> +------+------+   +----+----+     +------+-----+
>        |               |                 |
>        |          +----v--------------+  |
>        +----------> TISCI Protocol(*) <--+
>                   +----+--------------+
>                        |
>                    +---v-----------+
>                    | MAILBOX  FWK  |
>                    +---+-----------+
>                        |
>                    +---v-----------+
>                    |  TI MSGMGR    |-> TISCI hardware block
>                    +---------------+
> (*) This series.
>
>
> V4 of the series is based off v4.9-rc1 and is also available here:
> https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.10/tisci-base-v4
> Quick boot test: http://pastebin.ubuntu.com/23346183/
>
> Changes since v3:
> 	- rebase to v4.9-rc1
> 	- minor checkpatch fixes
>
> V3: https://lkml.org/lkml/2016/9/6/747
> V2: https://lkml.org/lkml/2016/8/30/273
> V1: https://lkml.org/lkml/2016/8/19/768
>
> Nishanth Menon (5):
>   Documentation: Add support for TI System Control Interface (TI-SCI)
>     protocol
>   firmware: Add basic support for TI System Control Interface (TI-SCI)
>     protocol
>   firmware: ti_sci: Add support for Device control
>   firmware: ti_sci: Add support for Clock control
>   firmware: ti_sci: Add support for reboot core service
>
>  .../devicetree/bindings/arm/keystone/ti,sci.txt    |   81 +
>  MAINTAINERS                                        |   10 +
>  drivers/firmware/Kconfig                           |   15 +
>  drivers/firmware/Makefile                          |    1 +
>  drivers/firmware/ti_sci.c                          | 1991 ++++++++++++++++++++
>  drivers/firmware/ti_sci.h                          |  492 +++++
>  include/linux/soc/ti/ti_sci_protocol.h             |  249 +++
>  7 files changed, 2839 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>  create mode 100644 drivers/firmware/ti_sci.c
>  create mode 100644 drivers/firmware/ti_sci.h
>  create mode 100644 include/linux/soc/ti/ti_sci_protocol.h
>
