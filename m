Return-Path: <SRS0=ZSGc=DA=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C856FC4727D
	for <linux-pm@archiver.kernel.org>; Wed, 23 Sep 2020 20:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E958206DB
	for <linux-pm@archiver.kernel.org>; Wed, 23 Sep 2020 20:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600892345;
	bh=67irmCRtbP7AGPKEMBlUnsizeDR/qE2sRnJe8qhBebA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=N83Gv2MypUyxeRn6txelyPEci7Dbp48Vh7Vxa2C77Bid0qaoyfNp/YQaX+o011U9i
	 AbJnUPmNcq8iA3d/144489ev+y+IO4PIMIJT7By+8dbmRB8WFuBatet7uUBvjRjvhu
	 NvKp2YwBqy35x37rkgMDSBaRZPyNUIuI3SEbSsXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgIWUTE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 23 Sep 2020 16:19:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbgIWUTE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 23 Sep 2020 16:19:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 087B1206D9;
        Wed, 23 Sep 2020 20:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600892343;
        bh=67irmCRtbP7AGPKEMBlUnsizeDR/qE2sRnJe8qhBebA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0qsWFe1dFX26VU+6k7RW/FpnuiX8UNvcxbXy6LpI+JzArGXsMDhsC9zP7+W8ynjni
         qZtuCV8JcEGbpj50xOzHV9m9Tqi5v+RnUsjAr2X6v7wyFi2JwovRY6ZKuE1p78ZzT+
         J4oj60zqTNRYulml2wQXmbHpipjRSEf75ofA6Y3c=
Date:   Wed, 23 Sep 2020 21:18:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Michael Auchter <michael.auchter@ni.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: dac: ad5686: add support for AD5338R
Message-ID: <20200923211858.4709ec53@archlinux>
In-Reply-To: <20200922184012.557622-1-michael.auchter@ni.com>
References: <20200922184012.557622-1-michael.auchter@ni.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 22 Sep 2020 13:40:10 -0500
Michael Auchter <michael.auchter@ni.com> wrote:

> The AD5338R is a 10-bit DAC with 2 outputs and an internal 2.5V
> reference (enabled by default). The register configuration is nearly
> identical to the AD5696R DAC that's already supported by this driver,
> with the channel selection bits being the only thing different.
> 
> Signed-off-by: Michael Auchter <michael.auchter@ni.com>

Looks good to me - just the DT binding to tweak for v3 unless
anyone else comments.

Thanks,

Jonathan


> ---
> Changes since v1:
> - Keep things sorted by product name
> - Update Kconfig description to list supported converters
> 
>  drivers/iio/dac/Kconfig      |  7 ++++---
>  drivers/iio/dac/ad5686.c     | 13 +++++++++++++
>  drivers/iio/dac/ad5686.h     |  1 +
>  drivers/iio/dac/ad5696-i2c.c |  1 +
>  4 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index dae8d27e772d..6f6074a5d3db 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -141,9 +141,10 @@ config AD5696_I2C
>  	depends on I2C
>  	select AD5686
>  	help
> -	  Say yes here to build support for Analog Devices AD5671R, AD5675R,
> -	  AD5694, AD5694R, AD5695R, AD5696, AD5696R Voltage Output Digital to
> -	  Analog Converter.
> +	  Say yes here to build support for Analog Devices AD5311R, AD5338R,
> +	  AD5671R, AD5675R, AD5691R, AD5692R, AD5693, AD5693R, AD5694, AD5694R,
> +	  AD5695R, AD5696, and AD5696R Digital to Analog converters.
> +
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad5696.
>  
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 56cf9344d187..382b3eb7ec06 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -210,6 +210,12 @@ static struct iio_chan_spec name[] = {				\
>  		AD5868_CHANNEL(0, 0, bits, _shift),		\
>  }
>  
> +#define DECLARE_AD5338_CHANNELS(name, bits, _shift)		\
> +static struct iio_chan_spec name[] = {				\
> +		AD5868_CHANNEL(0, 1, bits, _shift),		\
> +		AD5868_CHANNEL(1, 8, bits, _shift),		\
> +}
> +
>  #define DECLARE_AD5686_CHANNELS(name, bits, _shift)		\
>  static struct iio_chan_spec name[] = {				\
>  		AD5868_CHANNEL(0, 1, bits, _shift),		\
> @@ -252,6 +258,7 @@ static struct iio_chan_spec name[] = {				\
>  
>  DECLARE_AD5693_CHANNELS(ad5310r_channels, 10, 2);
>  DECLARE_AD5693_CHANNELS(ad5311r_channels, 10, 6);
> +DECLARE_AD5338_CHANNELS(ad5338r_channels, 10, 6);
>  DECLARE_AD5676_CHANNELS(ad5672_channels, 12, 4);
>  DECLARE_AD5679_CHANNELS(ad5674r_channels, 12, 4);
>  DECLARE_AD5676_CHANNELS(ad5676_channels, 16, 0);
> @@ -276,6 +283,12 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
>  		.num_channels = 1,
>  		.regmap_type = AD5693_REGMAP,
>  	},
> +	[ID_AD5338R] = {
> +		.channels = ad5338r_channels,
> +		.int_vref_mv = 2500,
> +		.num_channels = 2,
> +		.regmap_type = AD5686_REGMAP,
> +	},
>  	[ID_AD5671R] = {
>  		.channels = ad5672_channels,
>  		.int_vref_mv = 2500,
> diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> index 52009b5eef88..c714afa40adf 100644
> --- a/drivers/iio/dac/ad5686.h
> +++ b/drivers/iio/dac/ad5686.h
> @@ -52,6 +52,7 @@
>  enum ad5686_supported_device_ids {
>  	ID_AD5310R,
>  	ID_AD5311R,
> +	ID_AD5338R,
>  	ID_AD5671R,
>  	ID_AD5672R,
>  	ID_AD5674R,
> diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
> index ccf794caef43..89e7b063b7bb 100644
> --- a/drivers/iio/dac/ad5696-i2c.c
> +++ b/drivers/iio/dac/ad5696-i2c.c
> @@ -72,6 +72,7 @@ static int ad5686_i2c_remove(struct i2c_client *i2c)
>  
>  static const struct i2c_device_id ad5686_i2c_id[] = {
>  	{"ad5311r", ID_AD5311R},
> +	{"ad5338r", ID_AD5338R},
>  	{"ad5671r", ID_AD5671R},
>  	{"ad5675r", ID_AD5675R},
>  	{"ad5691r", ID_AD5691R},

