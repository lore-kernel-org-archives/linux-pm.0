Return-Path: <SRS0=7C+u=4Q=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B54C3F2CE
	for <linux-pm@archiver.kernel.org>; Fri, 28 Feb 2020 02:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202292469F
	for <linux-pm@archiver.kernel.org>; Fri, 28 Feb 2020 02:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgB1CUW (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 27 Feb 2020 21:20:22 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:42662 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730343AbgB1CUW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 21:20:22 -0500
Received: from [10.18.91.106] (10.18.91.106) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 28 Feb
 2020 10:20:47 +0800
Subject: Re: [PATCH] dt-bindings: power: Fix dt_binding_check error
To:     Rob Herring <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-pm@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Victor Wan <victor.wan@amlogic.com>
References: <1582269169-17557-1-git-send-email-jianxin.pan@amlogic.com>
 <20200226172702.GA6632@bogus>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <4f1d2562-31e1-0dfc-2c23-f208249848d6@amlogic.com>
Date:   Fri, 28 Feb 2020 10:20:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200226172702.GA6632@bogus>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.91.106]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rob,

Thanks for the ACK.
I have resent it to Kevin for linux-amlogic and Stephen for linux-next.

On 2020/2/27 1:27, Rob Herring wrote:
> On Fri, Feb 21, 2020 at 03:12:48PM +0800, Jianxin Pan wrote:
>> Missing ';' in the end of secure-monitor example node.
>>
>> Fixes: f50b4108ede1 ("dt-bindings: power: add Amlogic secure power domains bindings")
>> Reported-by: Rob Herring<robh+dt@kernel.org>
> 
> space                     ^
I fixed it in the resend version.
> 
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> ---
>>  Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This error isn't in my tree, so make sure it's applied where the 
> referenced commit is.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
>>
>> diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>> index af32209..bc4e037 100644
>> --- a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>> +++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>> @@ -36,5 +36,5 @@ examples:
>>              compatible = "amlogic,meson-a1-pwrc";
>>              #power-domain-cells = <1>;
>>          };
>> -    }
>> +    };
>>  
>> -- 
>> 2.7.4
>>
> 
> .
> 

