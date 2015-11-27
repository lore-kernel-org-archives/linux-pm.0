From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v1 1/5] thermal: rockchip: fix a trivial typo
Date: Fri, 27 Nov 2015 10:49:23 +0100
Message-ID: <5259912.5mmETGszQg@diego>
References: <1448592746-2129-1-git-send-email-wxt@rock-chips.com> <1448592746-2129-2-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:49713 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752914AbbK0Jtb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 27 Nov 2015 04:49:31 -0500
In-Reply-To: <1448592746-2129-2-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-rockchip@lists.infradead.org, Dan Carpenter <dan.carpenter@oracle.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <trivial@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org

Hi Caesar,

Am Freitag, 27. November 2015, 10:52:22 schrieb Caesar Wang:
> This patchset trys to dictate unified format for driver.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> 
> ---
> 
> Changes in v1:
> - Search more trivial typo for me.
> 
>  drivers/thermal/rockchip_thermal.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c
> b/drivers/thermal/rockchip_thermal.c index e845841..5a8840b 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -38,7 +38,7 @@ enum tshut_mode {
>  };
> 
>  /**
> - * the system Temperature Sensors tshut(tshut) polarity
> + * The system Temperature Sensors tshut(tshut) polarity
>   * the bit 8 is tshut polarity.
>   * 0: low active, 1: high active
>   */
> @@ -57,10 +57,10 @@ enum sensor_id {
>  };
> 
>  /**
> -* The conversion table has the adc value and temperature.
> -* ADC_DECREMENT is the adc value decremnet.(e.g. v2_code_table)
> -* ADC_INCREMNET is the adc value incremnet.(e.g. v3_code_table)
> -*/
> + * The conversion table has the adc value and temperature.
> + * ADC_DECREMENT: the adc value is of diminishing.(e.g. v2_code_table)
> + * ADC_INCREMENT: the adc value is incremental.(e.g. v3_code_table)
> + */
>  enum adc_sort_mode {
>  	ADC_DECREMENT = 0,
>  	ADC_INCREMENT,
> @@ -75,13 +75,13 @@ enum adc_sort_mode {

You could simply move to documenting the fields in the header (like 
exynos_tmu.c for example) instead of inside the table. I think there are even 
tools that create documention from these comments, so I'd suggest:

/*
 * struct chip_tsadc_table: hold information about chip-specific differences
 * @id: conversion table
 * @length: size of conversion table
 * @data_mask: mask to apply on data inputs
 * @mode: sort mode of this adc variant (incrementing or decrementing)
 */
>  struct chip_tsadc_table {
>  	const struct tsadc_table *id;
> 
> -	/* the array table size*/
> +	/* The array table size */
>  	unsigned int length;
> 
> -	/* that analogic mask data */
> +	/* That analogic mask data */
>  	u32 data_mask;
> 
> -	/* the sort mode is adc value that increment or decrement in table */
> +	/* The sort mode is adc value that increment or decrement in table */
>  	enum adc_sort_mode mode;
>  };
> 
> @@ -617,7 +617,7 @@ rockchip_thermal_register_sensor(struct platform_device
> *pdev, return 0;
>  }
> 
> -/*
> +/**
>   * Reset TSADC Controller, reset all tsadc registers.
>   */
>  static void rockchip_thermal_reset_controller(struct reset_control *reset)

