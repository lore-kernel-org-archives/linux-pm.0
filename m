Return-Path: <SRS0=Ia5J=CR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F062FC43461
	for <linux-pm@archiver.kernel.org>; Tue,  8 Sep 2020 20:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB8E22098B
	for <linux-pm@archiver.kernel.org>; Tue,  8 Sep 2020 20:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y9WdigwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbgIHUxa (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:53:30 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60896 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730425AbgIHUx0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 16:53:26 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 088KrNMu018749;
        Tue, 8 Sep 2020 15:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599598403;
        bh=pC5zpAJTBXlu/oSruNGiXQ+ayCSfyDddlcj1JxQybXE=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=y9WdigwF5wTvqtSVSdFyQlMn75eO2VnJq8Y9uCzkAUGOlk/lnvybpM8X9GddRWDoN
         Og3o1fDSoCwKE8kvaup/lIMjg+8dhoYNgv6O7mPOwkiJDHaeYxgByzc7q9IEZwYTPu
         LA6gf/escNXgdzgTYJpBrnGTXHn/UGsDNWDQpXk8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 088KrNhO104076
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Sep 2020 15:53:23 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Sep
 2020 15:53:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Sep 2020 15:53:23 -0500
Received: from [10.250.38.37] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 088KrNRO005070;
        Tue, 8 Sep 2020 15:53:23 -0500
Subject: Re: [PATCH 4/7] power: supply: bq27xxx: use BIT() for bit flags
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200908201319.3567-1-krzk@kernel.org>
 <20200908201319.3567-4-krzk@kernel.org>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <af09a19d-3261-a1bb-4d38-e7f543648154@ti.com>
Date:   Tue, 8 Sep 2020 15:53:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908201319.3567-4-krzk@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Krzysztof

On 9/8/20 3:13 PM, Krzysztof Kozlowski wrote:
> BIT() is a preferred way to toggle bit-like flags: no problems with 32/64
> bit systems, less chances for mistakes.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   drivers/power/supply/bq27xxx_battery.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 2deac3fbb036..e971af43dd45 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -847,13 +847,14 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
>   
>   #define bq27z561_dm_regs 0
>   #define bq28z610_dm_regs 0
> -
> -#define BQ27XXX_O_ZERO	0x00000001
> -#define BQ27XXX_O_OTDC	0x00000002 /* has OTC/OTD overtemperature flags */
> -#define BQ27XXX_O_UTOT  0x00000004 /* has OT overtemperature flag */
> -#define BQ27XXX_O_CFGUP	0x00000008
> -#define BQ27XXX_O_RAM	0x00000010
> -#define BQ27Z561_O_BITS	0x00000020
> +#define bq34z100_dm_regs 0
> +
> +#define BQ27XXX_O_ZERO		BIT(0)
> +#define BQ27XXX_O_OTDC		BIT(1) /* has OTC/OTD overtemperature flags */
> +#define BQ27XXX_O_UTOT		BIT(2) /* has OT overtemperature flag */
> +#define BQ27XXX_O_CFGUP		BIT(3)
> +#define BQ27XXX_O_RAM		BIT(4)
> +#define BQ27Z561_O_BITS		BIT(5)
>   

It seems you have added whitespaces that you submitted a patch to fix in 
3/7.

Also squash 3 and 4.

Dan

