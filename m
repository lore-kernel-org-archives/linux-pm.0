Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF4FC43217
	for <linux-pm@archiver.kernel.org>; Mon, 21 Nov 2022 21:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiKUVJA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 21 Nov 2022 16:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiKUVI7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Nov 2022 16:08:59 -0500
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512C3C6622
        for <linux-pm@vger.kernel.org>; Mon, 21 Nov 2022 13:08:48 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id xE22ozk4OuZP6xE22oT8A1; Mon, 21 Nov 2022 22:08:46 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 21 Nov 2022 22:08:46 +0100
X-ME-IP: 86.243.100.34
Message-ID: <2e4c6ee6-d8d5-b4fe-ab60-cb6f440c2dee@wanadoo.fr>
Date:   Mon, 21 Nov 2022 22:08:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] interconnect: qcom: icc-rpmh: Fix an error handling path
 in qcom_icc_rpmh_probe()
Content-Language: fr
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <ec929c37c655ede7bb42e426354093c8a1377a0b.1668947686.git.christophe.jaillet@wanadoo.fr>
 <COHSZZ9A5570.1P4NTXRE9IRZR@otso>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <COHSZZ9A5570.1P4NTXRE9IRZR@otso>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Le 21/11/2022 à 08:42, Luca Weiss a écrit :
> Hi Christophe,
> 
> On Sun Nov 20, 2022 at 1:35 PM CET, Christophe JAILLET wrote:
>> If of_platform_populate() fails, some resources need to be freed as already
>> done in the other error handling paths.
>>
>> Fixes: 57eb14779dfd ("interconnect: qcom: icc-rpmh: Support child NoC device probe")
> 
> I believe the same needs to be applied to icc-rpm.c.

I'll give it a look and send a v2.

CJ

> 
> Also there shouldn't be an empty line here between Fixes: and Signed-off-by:
> 
> Regards
> Luca
> 
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/interconnect/qcom/icc-rpmh.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
>> index fd17291c61eb..5168bbf3d92f 100644
>> --- a/drivers/interconnect/qcom/icc-rpmh.c
>> +++ b/drivers/interconnect/qcom/icc-rpmh.c
>> @@ -235,8 +235,11 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>>   	platform_set_drvdata(pdev, qp);
>>   
>>   	/* Populate child NoC devices if any */
>> -	if (of_get_child_count(dev->of_node) > 0)
>> -		return of_platform_populate(dev->of_node, NULL, NULL, dev);
>> +	if (of_get_child_count(dev->of_node) > 0) {
>> +		ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
>> +		if (ret)
>> +			goto err;
>> +	}
>>   
>>   	return 0;
>>   err:
>> -- 
>> 2.34.1
> 
> 

