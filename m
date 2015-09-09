From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 5/9] clk: qcom: gcc-msm8960: add child devices support.
Date: Wed, 09 Sep 2015 10:11:19 +0100
Message-ID: <55EFF7B7.5050605@linaro.org>
References: <1436348838-22671-1-git-send-email-rnayak@codeaurora.org> <1436348838-22671-6-git-send-email-rnayak@codeaurora.org> <20150811224902.GO2839@codeaurora.org> <55CB0B26.2020105@linaro.org> <55CC1CFE.7000005@codeaurora.org> <20150814004206.GU26614@codeaurora.org> <55CD5BD2.3070907@codeaurora.org> <55E660F6.3020007@codeaurora.org> <20150903172743.GE15099@codeaurora.org> <55ED311E.1070404@codeaurora.org> <20150908192115.GP15099@codeaurora.org> <55EFA876.30708@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34013 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbbIIJLW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 05:11:22 -0400
Received: by wicfx3 with SMTP id fx3so148759043wic.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2015 02:11:21 -0700 (PDT)
In-Reply-To: <55EFA876.30708@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, lina.iyer@linaro.org, nrajan@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org



On 09/09/15 04:33, Rajendra Nayak wrote:
>
> On 09/09/2015 12:51 AM, Stephen Boyd wrote:
>> On 09/07, Rajendra Nayak wrote:
>>>>
>>>> Yeah this might happen though because we've assigned the of_node
>>>> pointer to the tsens device before we register it on the platform
>>>> bus. The other way to pass that data down from gcc to tsens would
>>>> be to not have an of_node assigned to the tsens device, and check
>>>> for that case in the tsens driver. If there isn't an of_node,
>>>> then we look at the parent device's of_node to figure out which
>>>> gcc it is (if this even matters) and parse DT properties.
>>>
>>> Parsing DT properties from parent (in the tsens driver) is fine, but
>>> the nvmem apis still expect an of_node for the tsens device and hence
>>> fail.
>>
>> So pass the parent device to the nvmem APIs? Or adjust the nvmem
>> APIs to look for a parent of_node if there isn't an of_node for
>> the device being passed? Or make the nvmem APIs work without
>> using DT, and copy over the nvmem information from the gcc node
>> to the virtual tsens child device?
>
> Srini, you being the nvmem maintainer, any thoughts?

We could do either one of the below.
1> pass parent device for nvmem_get_cell as suggested by Stephen
2> use of_nvmem_get_cell() api to pass correct of_node

Both of them would work.

--srini
>
