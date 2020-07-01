Return-Path: <SRS0=2dfJ=AM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51449C433E0
	for <linux-pm@archiver.kernel.org>; Wed,  1 Jul 2020 16:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 234852082F
	for <linux-pm@archiver.kernel.org>; Wed,  1 Jul 2020 16:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="peCXw7Un"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbgGAQYh (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:24:37 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54228 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgGAQYh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 12:24:37 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 061GOZ9U054544;
        Wed, 1 Jul 2020 11:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593620675;
        bh=kigpz1Ki4Ng9iztOsibk1CaplcviUb3PdUByIxjUWgI=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=peCXw7Ung2NVn9OcQo0qflxLgwv5YzKgVm2fLIU9zIfKgJpyRRwle1Nr0Uz0l6l9c
         uXGWXZEQ7AEaPIDQYLNysnsyLqBYUM14ypnfdoBuKGKLJUjDAfnH0X2LnhO7txC8ll
         icW8tQNp+yyPWv0mpJjdZMCTrMaemV4IUDwtb7SQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 061GOZVg086564
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Jul 2020 11:24:35 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 1 Jul
 2020 11:24:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 1 Jul 2020 11:24:35 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 061GOZZU033223;
        Wed, 1 Jul 2020 11:24:35 -0500
Subject: Re: [PATCH v2 1/4] dt-bindings: power: Add BQ27561 compatible
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>, <afd@ti.com>, <pali@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200528122147.6171-1-dmurphy@ti.com>
 <9f6bf644-5cb8-bc49-504e-7950931bd28b@ti.com>
Message-ID: <cabdc292-a8fc-68f5-d8f9-7b442770d3ca@ti.com>
Date:   Wed, 1 Jul 2020 11:24:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <9f6bf644-5cb8-bc49-504e-7950931bd28b@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian


On 6/11/20 2:46 PM, Dan Murphy wrote:
> Bump to the series
>
I am wondering if this patchset was applied yet?

I have not recieved any comments except Rob's acks on the bindings

Dan


