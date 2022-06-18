Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AE3C433EF
	for <linux-pm@archiver.kernel.org>; Sat, 18 Jun 2022 16:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbiFRQNr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 18 Jun 2022 12:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiFRQNq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Jun 2022 12:13:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37B8E2E;
        Sat, 18 Jun 2022 09:13:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87FB160E26;
        Sat, 18 Jun 2022 16:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEB9C3411A;
        Sat, 18 Jun 2022 16:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655568824;
        bh=2gIKQ8ubOcnsBBSWp6GfCgq3UozPwU7l7+trpyF8mhw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JKnrjyeclXAOruVVLOZyUUBQ5c5qMkS+26B67rlt+rqneBX2j0dqSow2HlNh4re1c
         TiGkFe9e2WlAc5p67z4aqpv89MoVXSEEAifcZjSAL/5jXHcqgt5BNQxQWDtlWKmDcR
         dMbas9685HTp2m069sUF6n9/z9cOEwDIX/lwgyfxFpoMcxfwiIoPN9Eq9BooqLWsmS
         ChjnxjP2zT1m1Ccl9xk5YcGgcWXo+zAXHXwvJht68kGTlLc7U5iVoYff6ULDmDnswi
         Z+dBXx5do0Ysvm/INgT/p8EZjhYR7l9U8V3KL9V5jkmv1AMkOqToQLP8v0PHWGYYI7
         wLVZbt1Y65htg==
Date:   Sat, 18 Jun 2022 17:23:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/6] iio: adc: mp2629: fix wrong comparison of
 channel
Message-ID: <20220618172301.44363feb@jic23-huawei>
In-Reply-To: <20220615145357.2370044-2-sravanhome@gmail.com>
References: <20220615145357.2370044-1-sravanhome@gmail.com>
        <20220615145357.2370044-2-sravanhome@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Jun 2022 16:53:52 +0200
Saravanan Sekar <sravanhome@gmail.com> wrote:

> Input voltage channel enum is compared against iio address instead
> of the channel.
> 
> Fixes: 7abd9fb64682 ("iio: adc: mp2629: Add support for mp2629 ADC driver")
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

So how do you want to handle this?  If I take it as a separate fix it will
take a while to get upstream so that the later part of this series can be
applied on top of it.

If the fix isn't super urgent, then perhaps we just queue it up with the
rest of the series and Lee picks up through MFD?

On basis we might go that way.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Also, this probably wants a stable tag.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/mp2629_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
> index aca084f1e78a..e7fbfe92e884 100644
> --- a/drivers/iio/adc/mp2629_adc.c
> +++ b/drivers/iio/adc/mp2629_adc.c
> @@ -73,7 +73,7 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  
> -		if (chan->address == MP2629_INPUT_VOLT)
> +		if (chan->channel == MP2629_INPUT_VOLT)
>  			rval &= GENMASK(6, 0);
>  		*val = rval;
>  		return IIO_VAL_INT;

