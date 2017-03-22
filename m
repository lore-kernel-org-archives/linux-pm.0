From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v11 06/10] power: bq27xxx_battery: Define access methods
 to write chip registers
Date: Wed, 22 Mar 2017 14:56:51 -0500
Message-ID: <fab07920-0267-e2f5-bac2-18c1628fa7a4@ti.com>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-7-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:41664 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdCVT6O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 15:58:14 -0400
In-Reply-To: <20170320094335.19224-7-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

On 03/20/2017 04:43 AM, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
> 
> Declare bus.write/read_bulk/write_bulk() to support get/set of chip registers,
> e.g. with inputs from power_supply_battery_info.
> 
> Add bq27xxx_write() & bq27xxx_xfer() helper functions to call the above.
> 
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 35 ++++++++++++++++++++++++++++++++++
>  include/linux/power/bq27xxx_battery.h  |  3 +++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 2e2a3a8..f36a6f1 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -807,6 +807,41 @@ static inline int bq27xxx_read(struct bq27xxx_device_info *di, int reg_index,
>  	return ret;
>  }
>  
> +static inline int bq27xxx_write(struct bq27xxx_device_info *di, int reg_index,
> +				u16 value, bool single)
> +{
> +	int ret;
> +
> +	if (!di || di->regs[reg_index] == INVALID_REG_ADDR)
> +		return -EINVAL;
> +
> +	ret = di->bus.write(di, di->regs[reg_index], value, single);

You should check that .write has been defined, it will not be for the
hdq bus.

> +	if (ret < 0)
> +		dev_dbg(di->dev, "failed to write register 0x%02x (index %d)\n",
> +			di->regs[reg_index], reg_index);
> +
> +	return ret;
> +}
> +
> +static inline int bq27xxx_xfer(struct bq27xxx_device_info *di,
> +			       struct bq27xxx_dm_buf *buf, bool read)
> +{
> +	int ret;
> +	int (*xfer)(struct bq27xxx_device_info*, u8, u8*, int) =
> +		read ? di->bus.read_bulk : di->bus.write_bulk;
> +
> +	if (!di || di->regs[BQ27XXX_DM_DATA] == INVALID_REG_ADDR)
> +		return -EINVAL;
> +
> +	ret = xfer(di, di->regs[BQ27XXX_DM_DATA], buf->a, BQ27XXX_DM_SZ);
> +	if (ret < 0)
> +		dev_dbg(di->dev, "failed to %s_bulk register 0x%02x (index %d)\n",
> +			read ? "read" : "write",
> +			di->regs[BQ27XXX_DM_DATA], BQ27XXX_DM_DATA);
> +
> +	return ret;
> +}
> +
>  /*
>   * Return the battery State-of-Charge
>   * Or < 0 if something fails.
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
> index b312bce..c3369fa 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -40,6 +40,9 @@ struct bq27xxx_platform_data {
>  struct bq27xxx_device_info;
>  struct bq27xxx_access_methods {
>  	int (*read)(struct bq27xxx_device_info *di, u8 reg, bool single);
> +	int (*write)(struct bq27xxx_device_info *di, u8 reg, int value, bool single);
> +	int (*read_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int len);
> +	int (*write_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int len);
>  };
>  
>  struct bq27xxx_reg_cache {
> 
