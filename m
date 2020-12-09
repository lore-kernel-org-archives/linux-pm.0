Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA53C433FE
	for <linux-pm@archiver.kernel.org>; Wed,  9 Dec 2020 14:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59ECE23AAC
	for <linux-pm@archiver.kernel.org>; Wed,  9 Dec 2020 14:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbgLIO73 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:59:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732445AbgLIO7T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2020 09:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607525872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hyvmSp+tD6zrj4k830kMV7NEPRw1NJvTV+d5JmE7hP4=;
        b=XmTKLTTFZU2IjC2YRbwDSSTim39pZ/pI74OZ/X/t0JwmhhDD+N1NDnXUP8n1bNb5/wJ6Zp
        m2OqHaY1rp3VwoITvOTpBg4FuM1ObxV86FXL2hLyyAKeQK4pC3cC6TpsESStokLNTqhw6l
        GaXj6RkOBv07Qp4wTU/xhk9baFiE8P8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-Sb3T-6e5NGyMp7ChHWiT8g-1; Wed, 09 Dec 2020 09:57:50 -0500
X-MC-Unique: Sb3T-6e5NGyMp7ChHWiT8g-1
Received: by mail-ed1-f72.google.com with SMTP id g8so1012336edm.7
        for <linux-pm@vger.kernel.org>; Wed, 09 Dec 2020 06:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hyvmSp+tD6zrj4k830kMV7NEPRw1NJvTV+d5JmE7hP4=;
        b=nPzGZ6Eju9aEVlgOtgkW1B0UMwoELJEPKeYPrPLP7LTM/zMMy+hGZns0f1fAsmCjYu
         CGQrM5+sJETF7uRMxHStak/kiu0R269vCx++JVKfh6/z8zOHZ3OuqHA+GqDjtES1yniJ
         1+pQvTnl2n5WB4DIfPaVc18k+68vg/whLMZsRoT13uAiP4NMM3CKA0YOQYUat8iMmV3Y
         rdqRZOX1tr0/JeXFqpucArqJWTS4yHWhUBXlbxa7iCQUTPUlTKL0Spkrm3G3gi6YSfCl
         tDf0xtj2BmRO/n2sSDaGfM+WnI+T8iFgs5BDRSXxtmrnSGub5dKG4G+uJp1Zs7iB9zMi
         iLqQ==
X-Gm-Message-State: AOAM531bpWJZHa9mpnU0B68oWB1ujjk6e10tM6Yznb3naCO7dSKWe8lv
        zq+XS/nlK125hrOvmPAgcp+VWs4zkeopRlUCo2SX5mHFBwHpl3xVJJjYmrb8cBl3eYmB2QXbHhQ
        2GeDXW6Ib+7DzfI6his4=
X-Received: by 2002:a17:906:604e:: with SMTP id p14mr2460555ejj.515.1607525869017;
        Wed, 09 Dec 2020 06:57:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzttPIEq+aOcToeLeA6nbckf6Na4GwXDTNW8LKuIolx74j0K+upRkpOyKN7VeMgp9c2rMYbqQ==
X-Received: by 2002:a17:906:604e:: with SMTP id p14mr2460550ejj.515.1607525868859;
        Wed, 09 Dec 2020 06:57:48 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id k2sm1742353ejp.6.2020.12.09.06.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 06:57:48 -0800 (PST)
Subject: Re: [PATCH] power: supply: axp288_fuel_gauge: Add the ECS EF20EA to
 the blacklist
To:     Chris Chiu <chiu@endlessos.org>, sre@kernel.org, wens@csie.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org
References: <20201209045057.9509-1-chiu@endlessos.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d58351aa-14a9-2ea7-ee8b-946ba28a782e@redhat.com>
Date:   Wed, 9 Dec 2020 15:57:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201209045057.9509-1-chiu@endlessos.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 12/9/20 5:50 AM, Chris Chiu wrote:
> The ECS EF20EA laptop ships an AXP288 but it is actually using a
> different, separate FG chip for AC and battery monitoring. On this
> laptop we need to keep using the regular ACPI driver and disable the
> AXP288 FG to avoid reporting two batteries to userspace.
> 
> Signed-off-by: Chris Chiu <chiu@endlessos.org>
> ---
>  drivers/power/supply/axp288_fuel_gauge.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
> index 148eb8105803..a15c322c79ea 100644
> --- a/drivers/power/supply/axp288_fuel_gauge.c
> +++ b/drivers/power/supply/axp288_fuel_gauge.c
> @@ -739,6 +739,12 @@ static const struct dmi_system_id axp288_fuel_gauge_blacklist[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
>  		}
>  	},
> +	{
> +		/* ECS EF20 */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "EF20"),
> +		},
> +	},
>  	{}
>  };

The axp288_fuel_gauge_blacklist already has the following entry:

        {
                /* ECS EF20EA */
                .matches = {
                        DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
                },
        },

So is this real entry really necessary? The existing entry
matches the quirk for this in drivers/acpi/battery.c:

        {
                /* ECS EF20EA, AXP288 PMIC but uses separate fuel-gauge */
                .callback = battery_do_not_check_pmic_quirk,
                .matches = {
                        DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
                },
        },

And the one in drivers/acpi/ac.c:

        {
                /* ECS EF20EA, AXP288 PMIC but uses separate fuel-gauge */
                .callback = ac_do_not_check_pmic_quirk,
                .matches = {
                        DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
                },
        },

So I don't think that this patch is necessary...

Regards,

Hans


