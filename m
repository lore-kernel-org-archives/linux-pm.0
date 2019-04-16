Return-Path: <SRS0=HULK=SS=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199DCC10F13
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 17:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA64220880
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 17:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wjObvgoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbfDPRLE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:11:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35101 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDPRLE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Apr 2019 13:11:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so28158090wrp.2
        for <linux-pm@vger.kernel.org>; Tue, 16 Apr 2019 10:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oWLy0fdzoqHSqiqWsOxnepnsSX53GKH/m2bnqNBOvnY=;
        b=wjObvgoNGZkC0yfwzDxvSqd8fli3P2CBY/+ZHqm9/9Av1TXyaQeMM7gl+Pad9bPW8X
         9J9yyl09KCNYJ6tUnCMJz4ihKpp1cIlM6OdW3/Z8uOo6Z/naUpuMmRSKjhpuEHQ7LAU8
         F9WyckhzyLid6QCBpjklL5tyHfh3xhcTUJTVFe6PBtIHjkbZQ2Cu0UOVdsS/NH6ua5sm
         d3szw3aMcl0w5RqOjuBFLBbJlr7QGXeS2mCkCaxz/sZWXTDL7IrUpen6jRZLe5WsGVbA
         +kUSiLHwFCCyKuuergCEj4MMvwE2YVlgkQPAIJFaoO0urKStxHlyFf9c1Dnt5BTGaiAs
         EXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oWLy0fdzoqHSqiqWsOxnepnsSX53GKH/m2bnqNBOvnY=;
        b=Vjzldh9xBAOBZvnk6qgqfGINHNl7W+5M3l0rRIJqeb3ucgkz5y1KLcYNBqEPlRZfk/
         PsA7mOXbM+x7JiViG4hh1o1kmu/SwlJke3ixI5wo124iIgIIYqbyipVrteMZZrHvgXRj
         hBwoZe/1gjcBirG71gPD48qH6mX4wItsq6KN4sJcDNAz1mKkpKgSJlWGQZfZ9vQcOGll
         5IpQJTnYRg9ToAaCY+kka1Yp2RoHHgVaDljKZP/+FwLyTtz7DHLSftaaq7MRAgy9pskH
         Tef4UnQZ8Oc1V9wTb/8lRM4aiQBKhWuRJbV/rQnYsBlbCEl2jK3zUYUz7/MzJ3rfyHB9
         3DuA==
X-Gm-Message-State: APjAAAX8rfAMKenuwvYVDN6NGxtjar6QqV3TqFss27jBFoANTfsuK3qk
        VfCSbzwX0acNuKuVW76XF0bZag==
X-Google-Smtp-Source: APXvYqxvDX2OR1z8qY4WaubwCqLtH7EqL84Hg+CdXAwW8c4TLExANW+XQV4iuR0Fdyr6nuqlL0T+dQ==
X-Received: by 2002:adf:d848:: with SMTP id k8mr5243313wrl.185.1555434662189;
        Tue, 16 Apr 2019 10:11:02 -0700 (PDT)
Received: from [192.168.0.41] (50.251.95.92.rev.sfr.net. [92.95.251.50])
        by smtp.googlemail.com with ESMTPSA id e7sm21648920wme.37.2019.04.16.10.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 10:11:01 -0700 (PDT)
Subject: Re: [PATCH v4 10/12] thermal: qoriq: Do not report invalid
 temperature reading
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
 <20190413082748.29990-11-andrew.smirnov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6c07ec86-297f-01e0-f150-1b03c0a27c62@linaro.org>
Date:   Tue, 16 Apr 2019 19:11:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190413082748.29990-11-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190416171100.hBQe137EuooxaqetvOiRBpbx1_L0pK5enuW2fm4oZLE@z>

On 13/04/2019 10:27, Andrey Smirnov wrote:
> Before returning measured temperature data to upper layer we need to
> make sure that the reading was marked as "valid" to avoid reporting
> bogus data.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> Cc: linux-imx@nxp.com
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


>  drivers/thermal/qoriq_thermal.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index abbbfe88422e..5c459a9d0db3 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -37,6 +37,7 @@
>  #define REGS_TRITSR(n)	(0x100 + 16 * (n)) /* Immediate Temperature
>  					    * Site Register
>  					    */
> +#define TRITSR_V	BIT(31)
>  #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
>  					   * Control Register
>  					   */
> @@ -48,10 +49,25 @@ static int tmu_get_temp(int id, void *p, int *temp)
>  {
>  	struct qoriq_tmu_data *qdata = p;
>  	u32 val;
> +	/*
> +	 * REGS_TRITSR(id) has the following layout:
> +	 *
> +	 * 31  ... 7 6 5 4 3 2 1 0
> +	 *  V          TEMP
> +	 *
> +	 * Where V bit signifies if the measurement is ready and is
> +	 * within sensor range. TEMP is an 8 bit value representing
> +	 * temperature in C.
> +	 */
> +	if (regmap_read_poll_timeout(qdata->regmap,
> +				     REGS_TRITSR(id),
> +				     val,
> +				     val & TRITSR_V,
> +				     USEC_PER_MSEC,
> +				     10 * USEC_PER_MSEC))
> +		return -ENODATA;
>  
> -	regmap_read(qdata->regmap, REGS_TRITSR(id), &val);
>  	*temp = (val & 0xff) * 1000;
> -
>  	return 0;
>  }
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

