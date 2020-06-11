Return-Path: <SRS0=gD7b=7Y=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F03C433DF
	for <linux-pm@archiver.kernel.org>; Thu, 11 Jun 2020 19:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F6020792
	for <linux-pm@archiver.kernel.org>; Thu, 11 Jun 2020 19:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NMNjkeuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgFKTqR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:46:17 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47238 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgFKTqQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2020 15:46:16 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05BJkFaF079040;
        Thu, 11 Jun 2020 14:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591904775;
        bh=LQmzfFjmsdor5xe6DBHw1ouc24AUPwK9xlkXTGWlHoo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NMNjkeuJO2E5F0HnUhEPDH5FbetF6K63mVNExTow104f4a6Lz+KPYV37foHsw++YB
         i50pDqdI8ANMwo5u/04lZSp3hHSDESP0G1+pjddOOS7T5oPd1nWdz/hg2rZAxGL7+V
         hy0IsbXvMD9QjoBq/wmrxjYxFoN0bzNpjxD5AzX8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05BJkFpC020354
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Jun 2020 14:46:15 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 11
 Jun 2020 14:46:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 11 Jun 2020 14:46:14 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05BJkEXD093184;
        Thu, 11 Jun 2020 14:46:14 -0500
Subject: Re: [PATCH v2 1/4] dt-bindings: power: Add BQ27561 compatible
To:     <sre@kernel.org>, <afd@ti.com>, <pali@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200528122147.6171-1-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <9f6bf644-5cb8-bc49-504e-7950931bd28b@ti.com>
Date:   Thu, 11 Jun 2020 14:46:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528122147.6171-1-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Bump to the series

On 5/28/20 7:21 AM, Dan Murphy wrote:
> Add the Texas Instruments bq27561 battery monitor to the bq27xxx
> binding.
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>   Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> index 03d1020a2e47..51cb1f685dcf 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> @@ -49,6 +49,7 @@ properties:
>         - ti,bq27426
>         - ti,bq27441
>         - ti,bq27621
> +      - ti,bq27561
>   
>     reg:
>       maxItems: 1
