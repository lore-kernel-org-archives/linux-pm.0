Return-Path: <SRS0=X62Z=4O=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD85C4BA12
	for <linux-pm@archiver.kernel.org>; Wed, 26 Feb 2020 12:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFD221927
	for <linux-pm@archiver.kernel.org>; Wed, 26 Feb 2020 12:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fP94T6G5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgBZMhA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 26 Feb 2020 07:37:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25618 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726277AbgBZMg7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2020 07:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582720618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mLQQNZrIDdY7VQtLXKq4i6b4JRBJEoJcgInVPdxphBE=;
        b=fP94T6G51rehPgKCOXaP1ctnlLp9hmHBi4kn8DL1nuMrSMOHQf72uydgKzkzfUipEnPebB
        doD8HCtQjYd3c+dYHwg+BH99VywcqmUFLDMeKXLMrBGFrGDTH678k2dMviF5Y9AmCQKJKS
        9ys9PYYcz/jxy808qH+iRys9vAkQ4Kc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-dCTt-bejNZO3dN7__pgupA-1; Wed, 26 Feb 2020 07:36:56 -0500
X-MC-Unique: dCTt-bejNZO3dN7__pgupA-1
Received: by mail-wm1-f71.google.com with SMTP id d129so868039wmd.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2020 04:36:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mLQQNZrIDdY7VQtLXKq4i6b4JRBJEoJcgInVPdxphBE=;
        b=gEPoPlPtcbP/bCqQci7nJG1AguBaMrXJauAT8WHAgEML1lBQ0YReqGClaxW+6msGsD
         DDRmAkYMuUekCPt4T9E9ostXN8Fbs/TqEIlMrhOLlhFdiM5v75gYRck90359MBY7cZ/K
         PmAsF744dGVEHn+PhXcI/WWd3GKLlcly3RTRTfBWjS+33AW75pCbNDFt9OyubFF/DBlH
         bYsLUzJcr/DZTQWHYl2lNZqid4Zp3p7QEPjUFPwXnJb0tn6+kuSEQbmdf2ylFLdTnyDG
         TxOL7hzpwUw1Qx2YhmtWGwjC8/cJqpnQ8TexESGnSCXWy2XLMV8dPXZhRWtpDlfeQf2G
         Heug==
X-Gm-Message-State: APjAAAXla5p+om5yXpqnsAzgGv2sS+XxOe0dc2B0PLbOCGOlDPWH1KkV
        +M+gmfDjm/GRfixBJUqGQYp2jrARHAu4HDihaJgTtvmF4TsmdbocyXRLo+HoFWdfbNDaKmpZmdK
        hqk/EcZqjo4MibUXifHk=
X-Received: by 2002:adf:db84:: with SMTP id u4mr5445124wri.317.1582720615611;
        Wed, 26 Feb 2020 04:36:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqy5ICo88+idPnv1W3FdLp8LmZXS9GF40BSPKVmo0XvhKxtz7IvZH5grXF+HdEWLMOC8viQecA==
X-Received: by 2002:adf:db84:: with SMTP id u4mr5445099wri.317.1582720615347;
        Wed, 26 Feb 2020 04:36:55 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id v14sm3033007wrm.30.2020.02.26.04.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 04:36:54 -0800 (PST)
Subject: Re: [PATCH] power: supply: axp288_fuel_gauge: Broaden vendor check
 for Intel Compute Sticks.
To:     Jeffery Miller <jmiller@neverware.com>, linux-pm@vger.kernel.org
Cc:     jefferym@gmail.com
References: <20200225225941.2038378-1-jmiller@neverware.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e0340a1c-a60e-a7de-e12f-66f363b77096@redhat.com>
Date:   Wed, 26 Feb 2020 13:36:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225225941.2038378-1-jmiller@neverware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 2/25/20 11:59 PM, Jeffery Miller wrote:
> The Intel Compute Stick `STK1A32SC` can have a system vendor of
> "Intel(R) Client Systems".
> Broaden the Intel Compute Stick DMI checks so that they match "Intel
> Corporation" as well as "Intel(R) Client Systems".
> 
> This fixes an issue where the STK1A32SC compute sticks were still
> exposing a battery with the existing blacklist entry.
> 
> Signed-off-by: Jeffery Miller <jmiller@neverware.com>

Thank you for the patch. The patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





> ---
> 
> I've tested this primarily with a 4.19 kernel on Intel Compute Sticks
> with the "Intel(R) Client Systems" vendor.
> 
>   drivers/power/supply/axp288_fuel_gauge.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
> index e1bc4e6e6f30..f40fa0e63b6e 100644
> --- a/drivers/power/supply/axp288_fuel_gauge.c
> +++ b/drivers/power/supply/axp288_fuel_gauge.c
> @@ -706,14 +706,14 @@ static const struct dmi_system_id axp288_fuel_gauge_blacklist[] = {
>   	{
>   		/* Intel Cherry Trail Compute Stick, Windows version */
>   		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
>   			DMI_MATCH(DMI_PRODUCT_NAME, "STK1AW32SC"),
>   		},
>   	},
>   	{
>   		/* Intel Cherry Trail Compute Stick, version without an OS */
>   		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
>   			DMI_MATCH(DMI_PRODUCT_NAME, "STK1A32SC"),
>   		},
>   	},
> 

