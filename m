From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v5 4/9] drivers: base cacheinfo: Add support for ACPI
 based firmware tables
Date: Thu, 4 Jan 2018 11:46:49 +0000
Message-ID: <0c7e176a-cdd4-aceb-7f38-cda38acb89c1@arm.com>
References: <20171201222330.18863-1-jeremy.linton@arm.com>
 <20171201222330.18863-5-jeremy.linton@arm.com>
 <2078459.JrYtfXc8fv@aspire.rjw.lan>
 <5024a041-2ef4-3912-994f-b5fcc945e916@arm.com>
 <CAJZ5v0hHdfE3khVvuqQm5JFMgY5R054c8UB9Nixii9ucq0Ecnw@mail.gmail.com>
 <9bb1c58a-8d48-9952-e292-60b2bcb87a51@arm.com>
 <CAJZ5v0gnWn_05XN7r+Mwwgc0ca5vx8wgAQ1A8aAwOPvc9H899Q@mail.gmail.com>
 <fdb60100-3973-b9e3-487a-882836f8751e@arm.com>
 <3c3bf8a4-a13a-ce71-4bd2-71dd11b45521@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3c3bf8a4-a13a-ce71-4bd2-71dd11b45521@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, Al Stone <ahs3@redhat.com>, Jayachandran.Nair@cavium.com
List-Id: linux-pm@vger.kernel.org



On 03/01/18 14:21, Sudeep Holla wrote:
> On 12/12/17 23:37, Jeremy Linton wrote:
>> On 12/12/2017 05:02 PM, Rafael J. Wysocki wrote:
> 
> [...]
> 
>>>
>>> So call this field "token" or similar.  Don't call it "of_node" and
>>> don't introduce another "firmware_node" thing in addition to that.
>>> That just is a mess, sorry.
> 
> I completely agree. Both me and Lorenzo pointed that out in previous
> revisions and fair enough you have a valid concern it's use with PPTT.
> 
>>
>> I sort of agree, I think I can just change the whole of_node to a
>> generic 'void *firmware_unique' which works fine for the PPTT code, it
>> should also work for the DT code in cache_leaves_are_shared().
>>
> 
> Should be fine.
> 

Just to let you know, I don't have much to add. I will wait for the
patches that replace of_node with firmware cookie or something similar.
-- 
Regards,
Sudeep
