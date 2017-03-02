From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v7 0/9] devicetree battery support and client bq27xxx_battery
Date: Thu, 2 Mar 2017 14:52:51 -0800
Message-ID: <CAKvHMgQxYSeuwGmLWH6Okg9xVYsyF3fuXNFKgSM0THJHyY1Ehw@mail.gmail.com>
References: <20170221213008.30044-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33068 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdCBWx1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Mar 2017 17:53:27 -0500
Received: by mail-it0-f67.google.com with SMTP id 68so540702itg.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Mar 2017 14:52:52 -0800 (PST)
In-Reply-To: <20170221213008.30044-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>

Hi Andrew,

I have a new rev ready,with support for bq27500 & 545 & 421. How soon
could you test it? If this week, I'll post ASAP...


On Tue, Feb 21, 2017 at 1:29 PM, Liam Breck <liam@networkimprov.net> wrote:
> Overview:
> * new devicetree battery node specifies static battery data
> * fuel gauge and charger nodes shall use monitored-battery=<&battery_node>
> * new power_supply_get_battery_info() reads battery data from devicetree
> * new struct power_supply_battery_info provides battery data to drivers
> * drivers surface battery data in sysfs via related power_supply_prop_* fields
> * bq27xxx driver calls the above and writes battery data to RAM/NVM for params
>   essential to correct operation: energy-full-design-microwatt-hours,
>   charge-full-design-microamp-hours, voltage-min-design-microvolt
>
> Changes in v7:
>   bq27xxx_battery:
> *   support chips where terminate_voltage & design_* live in separate blocks
> *   draft support for 421, 441, 621 chips
> *   new patch to log chip memory fields
> *   report bus I/O errors; return error code in bq27xxx_battery_i2c
> *   verify checksum in read_dm_block()
> *   use set_cfgupdate only if chip provides it, soft_reset on I/O error
> *   block_data_control=0 only in write_dm_block()
> *   note toxic code from TI bqtool in write_dm_block()
> *   lots of functionally neutral polishing
>   Documentation/devicetree/.../battery.txt:
> *   mention power_supply_get_battery_info()
>
> Changes in v6:
> * Documentation/devictree/... fixes
> * bq27xxx_battery: clarify names
> * bq27xxx_battery: verify that selected registers are supported
> * bq27xxx_battery: allocate NVM buffer on stack
> * bq27xxx_battery_i2c: fix return code of bulk_read
>
> Changes in v5:
> * incorporate feedback into Documentation/devicetree/.../battery.txt
> * use power_supply_prop_* names in devicetree and power_supply_battery_info
> * default fields to -EINVAL in power_supply_battery_info
> * power_supply_get_battery_info() always looks for "monitored-battery"
> * power_supply_get_battery_info() emits a warning if !psy->of_node
> * squash patches for power_supply_battery_info
> * bq27xxx_battery: check power_supply_battery_info values
> * bq27xxx_battery: note missing power_supply_prop_* features
> * bq27xxx_battery: new patch for access methods
>
> Changes in v4:
> * add "fixed-battery" compatible field to be be more consistant with devicetree
>
> Changes in v3:
> * split i2c changes into respective patches
> * add documentation for battery information for fuel gauge
> * rebased documentation patches on change on the list
> * abstracted the battery configuration for the state machine
>   to an generic struct and platform data access function
>
> Changes in v2:
> * add documentation for uWh and uAh property units
> * change devicetree entries to match new property units
>
> Liam (5):
>   devicetree: power: Add battery.txt
>   devicetree: power: bq27xxx: Add monitored-battery documentation
>   power: power_supply: Add power_supply_battery_info and API
>   power: bq27xxx_battery: Add power_supply_battery_info support
>   power: bq27xxx_battery: Add print_dm() to log chip memory
>
> Matt Ranostay (4):
>   devicetree: property-units: Add uWh and uAh units
>   power: bq27xxx_battery: Define access methods to write chip registers
>   power: bq27xxx_battery: Add BQ27425 chip id
>   power: bq27xxx_battery_i2c: Add I2C bulk read/write functions
>
>  .../devicetree/bindings/power/supply/battery.txt   |  42 ++
>  .../devicetree/bindings/power/supply/bq27xxx.txt   |  11 +-
>  .../devicetree/bindings/property-units.txt         |   2 +
>  drivers/power/supply/bq27xxx_battery.c             | 473 ++++++++++++++++++++-
>  drivers/power/supply/bq27xxx_battery_i2c.c         |  84 +++-
>  drivers/power/supply/power_supply_core.c           |  40 ++
>  include/linux/power/bq27xxx_battery.h              |   6 +-
>  include/linux/power_supply.h                       |  18 +
>  8 files changed, 669 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt
>
> --
> 2.9.3
>
