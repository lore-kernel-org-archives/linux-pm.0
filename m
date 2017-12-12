From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v5 6/9] ACPI/PPTT: Add topology parsing code
Date: Tue, 12 Dec 2017 10:13:08 -0600
Message-ID: <fc12696c-15e1-cea4-42bf-db4b5daa45f2@arm.com>
References: <20171201222330.18863-1-jeremy.linton@arm.com>
 <20171201222330.18863-7-jeremy.linton@arm.com>
 <9009154.M66RGdQJXA@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <9009154.M66RGdQJXA@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

First, thanks for taking a look at this.

On 12/11/2017 07:12 PM, Rafael J. Wysocki wrote:
> On Friday, December 1, 2017 11:23:27 PM CET Jeremy Linton wrote:
>> The PPTT can be used to determine the groupings of CPU's at
>> given levels in the system. Lets add a few routines to the PPTT
>> parsing code to return a unique id for each unique level in the
>> processor hierarchy. This can then be matched to build
>> thread/core/cluster/die/package/etc mappings for each processing
>> element in the system.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> 
> Why can't this be folded into patch [2/9]?

It can, and I will be happy squash it.

It was requested that the topology portion of the parser be split out 
back in v3.

https://www.spinics.net/lists/linux-acpi/msg78487.html



