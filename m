Return-Path: <SRS0=ZSVA=DN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4B7C41604
	for <linux-pm@archiver.kernel.org>; Tue,  6 Oct 2020 17:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC9B207EA
	for <linux-pm@archiver.kernel.org>; Tue,  6 Oct 2020 17:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qpVabzX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgJFRXL (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 6 Oct 2020 13:23:11 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39600 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgJFRXL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 13:23:11 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 096HN7JF124036;
        Tue, 6 Oct 2020 12:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602004987;
        bh=41BcokSKV9gxGfkcOCDo5PCrNWnXiEAbwwDLF96Ay/U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qpVabzX8XIS9XB/EhB9bMbTnoeCq8ZLenN1WL2C1yF+5T07iUunabxBBFx+VKM7Rv
         yFgG1WrxVQ3YIMWKJHo/0MW+K+mCCdm2XExKYp9T4H0sNwGqz4gaUDANBvYKfrR8w/
         Tr0T7JDQ+3JNoGDRpZK3TUsDKQhRicPJTHo97lMs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 096HN7wN076746
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Oct 2020 12:23:07 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 6 Oct
 2020 12:23:06 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 6 Oct 2020 12:23:06 -0500
Received: from [10.250.37.2] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 096HN6S2108408;
        Tue, 6 Oct 2020 12:23:06 -0500
Subject: Re: [PATCH][next] power: supply: bq25980: remove redundant zero check
 on ret
To:     Colin King <colin.king@canonical.com>,
        Sebastian Reichel <sre@kernel.org>, <linux-pm@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201006170600.545361-1-colin.king@canonical.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <4239fc37-c1d4-23e5-c784-b171eb6173ab@ti.com>
Date:   Tue, 6 Oct 2020 12:23:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201006170600.545361-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Colin

On 10/6/20 12:06 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently ret is assigned to zero and the following statement checks
> if it is non-zero. This check is redundant and can be removed
>
> Addresses-Coverity: ("Logically dead code")
> Fixes: 5069185fc18e ("power: supply: bq25980: Add support for the BQ259xx family")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/power/supply/bq25980_charger.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
> index 3995fb7cf060..f04f9acdb13b 100644
> --- a/drivers/power/supply/bq25980_charger.c
> +++ b/drivers/power/supply/bq25980_charger.c
> @@ -613,9 +613,6 @@ static int bq25980_set_battery_property(struct power_supply *psy,
>   	struct bq25980_device *bq = power_supply_get_drvdata(psy);
>   	int ret = 0;
>   
> -	if (ret)
> -		return ret;
> -
>   	switch (psp) {
>   	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>   		ret = bq25980_set_const_charge_curr(bq, val->intval);

Thanks for the patch

Acked-by: Dan Murphy <dmurphy@ti.com>

