From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V9] thermal: bcm2835: add thermal driver for bcm2835 soc
Date: Thu, 19 Jan 2017 20:14:02 -0800
Message-ID: <20170120041400.GA24617@localhost.localdomain>
References: <1483808145-6206-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33999 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdATEON (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Jan 2017 23:14:13 -0500
Received: by mail-pg0-f66.google.com with SMTP id t6so5800757pgt.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Jan 2017 20:14:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1483808145-6206-1-git-send-email-kernel@martin.sperl.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kernel@martin.sperl.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hello Martin,

On Sat, Jan 07, 2017 at 04:55:45PM +0000, kernel@martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Add basic thermal driver for bcm2835 SOC.
> 
> This driver currently relies on the firmware setting up the
> tsense HW block and does not set it up itself.
> 
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> Acked-by: Eric Anholt <eric@anholt.net>
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> 

<cut>

> +
> +static const struct of_device_id bcm2835_thermal_of_match_table[] = {
> +	{
> +		.compatible = "brcm,bcm2835-thermal",
> +		.data = &(struct bcm2835_thermal_info) {
> +			.offset = 407000,
> +			.slope = -538,
> +			.trip_temp = 80000
> +		}
> +	},
> +	{
> +		.compatible = "brcm,bcm2836-thermal",
> +		.data = &(struct bcm2835_thermal_info) {
> +			.offset = 407000,
> +			.slope = -538,
> +			.trip_temp = 80000
> +		}
> +	},
> +	{
> +		.compatible = "brcm,bcm2837-thermal",
> +		.data = &(struct bcm2835_thermal_info) {
> +			/* the bcm2837 needs adjustment of +5C */
> +			.offset = 407000 + 5000,
> +			.slope = -538,
> +			.trip_temp = 80000
> +		}
> +	},
> +	{},

Just for the same of clarification, is there anything preventing this
driver of using of-thermal API? the above data (slope, offset, and
trip_temps) would be in DT the place where they are supposed to be,
instead of code.

> +};
> +MODULE_DEVICE_TABLE(of, bcm2835_thermal_of_match_table);
> +
> +static struct platform_driver bcm2835_thermal_driver = {
> +	.probe = bcm2835_thermal_probe,
> +	.remove = bcm2835_thermal_remove,
> +	.driver = {
> +		.name = "bcm2835_thermal",
> +		.of_match_table = bcm2835_thermal_of_match_table,
> +	},
> +};
> +module_platform_driver(bcm2835_thermal_driver);
> +
> +MODULE_AUTHOR("Martin Sperl");
> +MODULE_DESCRIPTION("Thermal driver for bcm2835 chip");
> +MODULE_LICENSE("GPL");
> --
> 2.1.4
