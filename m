Return-Path: <SRS0=QwoY=AE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F86C433E1
	for <linux-pm@archiver.kernel.org>; Tue, 23 Jun 2020 06:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28B72064B
	for <linux-pm@archiver.kernel.org>; Tue, 23 Jun 2020 06:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qCtbnkfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgFWGFh (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:05:37 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1393 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbgFWGFh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 02:05:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef19b830000>; Mon, 22 Jun 2020 23:04:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 23:05:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 22 Jun 2020 23:05:36 -0700
Received: from [10.24.37.103] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jun
 2020 06:05:30 +0000
Subject: Re: [TEGRA194_CPUFREQ Patch v3 1/4] dt-bindings: arm: Add t194 ccplex
 compatible and bpmp property
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rjw@rjwysocki.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bbasu@nvidia.com>,
        <mperttunen@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <1592775274-27513-1-git-send-email-sumitg@nvidia.com>
 <1592775274-27513-2-git-send-email-sumitg@nvidia.com>
 <20200622072247.agrvmw6sl3jwgjkz@vireshk-i7>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <3ef570ec-1a55-5449-58fb-4e0039350299@nvidia.com>
Date:   Tue, 23 Jun 2020 11:35:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200622072247.agrvmw6sl3jwgjkz@vireshk-i7>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592892291; bh=x7pllGVCRVcZl/z7oNpDAAgML8RbNEkRhkrXs3sdRss=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qCtbnkfaHgvl3zipzaZafhR7lVvhAKG8qv/fMpHfK859kAvg4dPHxQeojQOW9d6b3
         cTeJr3AN+fK98HqEPlFq6ZzbBEKm5xSA2lgMtePQ/6shHf4t6UYdPKkW0100JQLSzR
         6EdgrcydReThwiJX9TAlcsKZSRmBaEyHVWqilL+wJYYIt0mxQMAohe4xD1gO6LSghc
         5bjDaPzrcL8iCe4+gl94JXUAP98cUiTPOKeyOHd9gnTAdoHxZBvqsazNBgWNOWAhWD
         jT18qyd5C7ZJvS0GLrR2YM17NJ24DxUJy2KRBp5Ht+qffE2wEEb2tA3cEtSy18ZI//
         U7mMuO8NceS9w==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 22/06/20 12:52 PM, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 22-06-20, 03:04, Sumit Gupta wrote:
>> To do frequency scaling on all CPUs within T194 CPU Complex, we need
>> to query BPMP for data on valid operating points. Document a compatible
>> string under 'cpus' node to represent the CPU Complex for binding drivers
>> like cpufreq which don't have their node or CPU Complex node to bind to.
>> Also, document a property to point to the BPMP device that can be queried
>> for all CPUs.
> 
> You shouldn't be putting how linux is going to use this information and entries
> shouldn't be made just so cpufreq can bind to a driver.
> 
> Though I see that this is a real hardware register which you can use to interact
> with the firmware ? And so it makes sense to have it, maybe in different form
> though.
> 
CPUFREQ driver doesn't communicate directly with BPMP firmware. It uses 
BPMP node's reference to call api's exported by BPMP driver which 
communicates with BPMP firmware.

> I will let Rob explain what would be the right way of doing this though.
> 
This is already discussed by Thierry with Rob.
Please refer https://marc.info/?l=linux-arm-kernel&m=158999171528418&w=2

>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   Documentation/devicetree/bindings/arm/cpus.yaml | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
>> index a018147..737b55e 100644
>> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
>> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
>> @@ -162,6 +162,7 @@ properties:
>>         - nvidia,tegra132-denver
>>         - nvidia,tegra186-denver
>>         - nvidia,tegra194-carmel
>> +      - nvidia,tegra194-ccplex
>>         - qcom,krait
>>         - qcom,kryo
>>         - qcom,kryo260
>> @@ -255,6 +256,14 @@ properties:
>>
>>         where voltage is in V, frequency is in MHz.
>>
>> +  nvidia,bpmp:
>> +    $ref: '/schemas/types.yaml#/definitions/phandle'
>> +    descrption: |
>> +      Specifies the bpmp node that needs to be queried to get
>> +      operating point data for all CPUs.
>> +
>> +      Optional for NVIDIA Tegra194 Carmel CPUs
>> +
>>     power-domains:
>>       $ref: '/schemas/types.yaml#/definitions/phandle-array'
>>       description:
>> --
>> 2.7.4
> 
> --
> viresh
> 
