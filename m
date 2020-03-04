Return-Path: <SRS0=FCtK=4V=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAA1C3F2CE
	for <linux-pm@archiver.kernel.org>; Wed,  4 Mar 2020 16:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA7E22522
	for <linux-pm@archiver.kernel.org>; Wed,  4 Mar 2020 16:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbgCDQeU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:34:20 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:42431 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgCDQeU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 11:34:20 -0500
Received: from [10.18.90.110] (10.18.90.110) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.1591.10; Thu, 5 Mar 2020
 00:34:48 +0800
Subject: Re: [PATCH v2] dt-bindings: power: Fix dt_binding_check error
To:     Rob Herring <robh@kernel.org>
List-Id: <soc.lore.kernel.org>
CC:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>, SoC Team <soc@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        <devicetree@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1583164448-83438-1-git-send-email-jianxin.pan@amlogic.com>
 <20200302201554.GA22028@bogus>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <4fb6a6c2-5df3-9cff-eb00-a6d00963426d@amlogic.com>
Date:   Thu, 5 Mar 2020 00:34:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200302201554.GA22028@bogus>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.90.110]
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On 2020/3/3 4:15, Rob Herring wrote:
> On Mon, 2 Mar 2020 23:54:08 +0800, Jianxin Pan wrote:
>> Missing ';' in the end of secure-monitor example node.
>>
>> Fixes: 165b5fb294e8 ("dt-bindings: power: add Amlogic secure power domains bindings")
>> Reported-by: Rob Herring <robh+dt@kernel.org>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> ---
>>  Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
Sorry to forget the tag, Kevin has added it for me, and I will keep it in mind next time.
> If a tag was not added on purpose, please state why and what changed.
> 
> .
> 

