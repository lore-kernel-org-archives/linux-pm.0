From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v5 7/8] power: bq27xxx_battery: Define access methods to
 write chip registers
Date: Mon, 6 Feb 2017 17:32:44 -0600
Message-ID: <dc26ca9f-6399-1c6c-731a-3652fa09ff31@ti.com>
References: <20170204091603.32242-1-liam@networkimprov.net>
 <20170204091603.32242-8-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:47491 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbdBFXct (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 18:32:49 -0500
In-Reply-To: <20170204091603.32242-8-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sre@kernel.org>
Cc: Matt Ranostay <matt@ranostay.consulting>, linux-pm@vger.kernel.org, Liam <github@networkimprov.net>, Liam Breck <kernel@networkimprov.net>

On 02/04/2017 03:16 AM, Liam Breck wrote:
> From: Liam <github@networkimprov.net>
> 
> From: Matt Ranostay <matt@ranostay.consulting>
> 
> write(), read_bulk(), write_bulk() support setting chip registers,
> e.g. with data obtained from power_supply_battery_info.
> 
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  include/linux/power/bq27xxx_battery.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
> index c433815..1a78512 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -32,6 +32,9 @@ struct bq27xxx_platform_data {
>  struct bq27xxx_device_info;
>  struct bq27xxx_access_methods {
>  	int (*read)(struct bq27xxx_device_info *di, u8 reg, bool single);
> +	int (*write)(struct bq27xxx_device_info *di, u8 reg, int value, bool single);
> +	int (*read_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int len);
> +	int (*write_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int len);

These should have been defined way earlier in the series, this will
break bisectability.

Andrew

>  };
>  
>  struct bq27xxx_reg_cache {
> 
