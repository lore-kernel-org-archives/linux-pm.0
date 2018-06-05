From: Abhishek <huntbag@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] cpuidle/powernv : Add Description for cpuidle state
Date: Tue, 5 Jun 2018 14:24:39 +0530
Message-ID: <17cd53ec-6bc1-5814-8824-3c6a4f0b90cd@linux.vnet.ibm.com>
References: <20180604081758.104201-1-huntbag@linux.vnet.ibm.com>
 <0a28154deb468669a59c120a90d4aedc1e1e705b.camel@kernel.crashing.org>
 <20180604114500.3rlpuso5aftesnf5@aksadiga.ibm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180604114500.3rlpuso5aftesnf5@aksadiga.ibm>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, paulus@samba.org, mpe@ellerman.id.au, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, stewart@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org



On 06/04/2018 05:15 PM, Akshay Adiga wrote:
> On Mon, Jun 04, 2018 at 07:04:14PM +1000, Benjamin Herrenschmidt wrote:
>> Is this a new property ? I'm not fan of adding yet another of those
>> silly arrays.
>>
>> I would say this is the right time now to switch over to a node per
>> state instead, as we discussed with Vaidy.

It is not a new property. Name was being used for description as 
description was not present in device tree. A skiboot patch adding 
description to device tree have been posted. This patch reads those 
description instead of copying name itself into description. And we fall 
back to reading name into description to not break the comaptibility 
with older firmware.

Thanks
Abhishek

> I posted  the node based device tree here :
> skiboot patch :  https://patchwork.ozlabs.org/patch/923120/
> kernel patch : https://lkml.org/lkml/2018/5/30/1146
>
> Do you have any inputs for this design ?
>
>> Additionally, while doing that, we can provide the versioning mechanism
>> I proposed so we can deal with state specific issues and erratas.
>>
>> Cheers,
>> Ben.
>>
