From: Ram Chandrasekar <rkumbako@codeaurora.org>
Subject: Re: [PATCH] drivers: thermal: do not clobber cooling dev state from
 userspace
Date: Wed, 22 Aug 2018 10:48:27 -0600
Message-ID: <1fa9d64d-0f52-dba2-8777-799fa9272581@codeaurora.org>
References: <20180507175505.2389-1-ilina@codeaurora.org>
 <1532595308.2358.45.camel@intel.com> <20180814180447.GJ5081@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180814180447.GJ5081@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lina Iyer <ilina@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>
Cc: edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 8/14/2018 12:04 PM, Lina Iyer wrote:
> Adding Ram, so he can respond.
> -- Lina
> 
> On Thu, Jul 26 2018 at 02:55 -0600, Zhang Rui wrote:
>> On 一, 2018-05-07 at 11:55 -0600, Lina Iyer wrote:
>>> From: Ram Chandrasekar <rkumbako@codeaurora.org>
>>>
>>> Let userspace be another voter for cooling device state instead of
>>> the
>>> overriding authority. It is possible that the thermal governor may
>>> find
>>> a higher cooling state desirable than what is recommended by the
>>> userspace. Separate out the current cooling device state from the
>>> userspace request and aggregate the userspace request with the
>>> governors' recommendation.
>>>
>>
>> hmmm, I don't understand this.
>> If the governor does not work well, we should either improve the
>> governor or use userspace governor instead.
>> do you have any examples that the kernel governor chooses improper
>> cooling state?
>>
Userspace governor and kernel governor could monitor different thermal 
zones for different thermal conditions and mitigate the same cooling 
device. In this case, the cooling device state request from userspace 
governor shouldn’t overwrite the request from kernel governor, rather it 
needs to be aggregated. This change is to aggregate the cooling device 
state requests between the userspace and kernel governors.

Thanks,
Ram
