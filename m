Return-Path: <SRS0=iBKh=7B=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC6DC433DF
	for <linux-pm@archiver.kernel.org>; Tue, 19 May 2020 14:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4D15207FB
	for <linux-pm@archiver.kernel.org>; Tue, 19 May 2020 14:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="irb8JtwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgESOqr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 19 May 2020 10:46:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38998 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgESOqr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2020 10:46:47 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04JEkj0G067348;
        Tue, 19 May 2020 09:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589899605;
        bh=Y26DaIi4n8BuhyRCfCi9TYUz/rg/RaO9Ay8FWNenVqU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=irb8JtwCjKFWlQ2PezGVskyGurReb505Tinijlx0BxHuxLxy5bLQKjk6PBaXiARwT
         c+NRc1DWYuAudvbbceSu8QxhYTkdnHsTUaq/pHQlykQZh/Po0bfiNH98sXKG1YpDU9
         5CMe7Kf6bGQJWZYDAO/zs8Scdp1MxoH1AxgQV0E0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04JEkjc7109937
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 09:46:45 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 19
 May 2020 09:46:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 19 May 2020 09:46:44 -0500
Received: from [10.250.38.163] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04JEkiXO045835;
        Tue, 19 May 2020 09:46:44 -0500
Subject: Re: [PATCH v7 3/3] power: supply: bq25150 introduce the bq25150
To:     Dan Murphy <dmurphy@ti.com>, <sre@kernel.org>
CC:     <sspatil@android.com>, <linux-pm@vger.kernel.org>,
        <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>
References: <20200519141916.28282-1-dmurphy@ti.com>
 <20200519141916.28282-4-dmurphy@ti.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <50b9ca3f-36e8-d13b-672c-5e72b6158869@ti.com>
Date:   Tue, 19 May 2020 10:46:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519141916.28282-4-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/19/20 10:19 AM, Dan Murphy wrote:
> +static int bq2515x_set_ilim_lvl(struct bq2515x_device *bq2515x, int val)
> +{
> +	int i;
> +
> +	if (val > BQ2515X_ILIM_MAX || val < BQ2515X_ILIM_MIN)
> +		return -EINVAL;

Clamp to these limits, not reject. Or better, modify the below loop so
it clamps to the highest or lowest value in bq2515x_ilim_lvl_values[],
then drop these #defines.

> +
> +	for (i = 0; i < ARRAY_SIZE(bq2515x_ilim_lvl_values); i++) {
> +		if (val == bq2515x_ilim_lvl_values[i])
> +			break;
> +
> +		if (val > bq2515x_ilim_lvl_values[i - 1] &&

Index out of bounds for the i = 0 case.

> +		    val < bq2515x_ilim_lvl_values[i]) {
> +			if (val - bq2515x_ilim_lvl_values[i - 1] <
> +			    bq2515x_ilim_lvl_values[i] - val) {

You are still missing the case where the value is closer to the [i]
element, you check that it is between [i-1] and [i], but only chose
[i-1] when it is closer to that than [i] but equal and greater case is
missing.

Given this sets input current limits, would instead always rounding down
be the safer option?

Andrew

> +				i = i - 1;
> +				break;
> +			}
> +		}
> +	}
> +
> +	return regmap_write(bq2515x->regmap, BQ2515X_ILIMCTRL, i);
> +}
