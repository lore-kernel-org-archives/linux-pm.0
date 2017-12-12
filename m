From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 4/9] drivers: base cacheinfo: Add support for ACPI
 based firmware tables
Date: Wed, 13 Dec 2017 00:41:07 +0100
Message-ID: <CAJZ5v0ir7akaMeJFP3HmWgf3aAYLa2Qw-nsEsKth3hpK0vp4UA@mail.gmail.com>
References: <20171201222330.18863-1-jeremy.linton@arm.com> <20171201222330.18863-5-jeremy.linton@arm.com>
 <2078459.JrYtfXc8fv@aspire.rjw.lan> <5024a041-2ef4-3912-994f-b5fcc945e916@arm.com>
 <CAJZ5v0hHdfE3khVvuqQm5JFMgY5R054c8UB9Nixii9ucq0Ecnw@mail.gmail.com>
 <9bb1c58a-8d48-9952-e292-60b2bcb87a51@arm.com> <CAJZ5v0gnWn_05XN7r+Mwwgc0ca5vx8wgAQ1A8aAwOPvc9H899Q@mail.gmail.com>
 <fdb60100-3973-b9e3-487a-882836f8751e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <fdb60100-3973-b9e3-487a-882836f8751e@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, Al Stone <ahs3@redhat.com>, Jayachandran.Nair@cavium.com
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 13, 2017 at 12:37 AM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> On 12/12/2017 05:02 PM, Rafael J. Wysocki wrote:
>>
>> On Tue, Dec 12, 2017 at 11:55 PM, Jeremy Linton <jeremy.linton@arm.com>
>> wrote:
>>>
>>> Hi,
>>>
>>>
>>> On 12/12/2017 11:25 AM, Rafael J. Wysocki wrote:
>>>>
>>>>
>>
>> [cut]
>
>
> (trimming list)
>
>
>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> What about converting this to using struct fwnode instead of adding
>>>>>> fields to it?
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> I didn't really want to add another field here, but I've also pointed
>>>>> out
>>>>> how I thought converting it to a fwnode wasn't a good choice.
>>>>>
>>>>> https://lkml.org/lkml/2017/11/20/502
>>>>>
>>>>> Mostly because IMHO its even more misleading (lacking any
>>>>> fwnode_operations)
>>>>> than misusing the of_node as a void *.
>>>>
>>>>
>>>>
>>>> I'm not sure what you mean.
>>>
>>>
>>>
>>> Converting the DT drivers/cacheinfo.c code to use a fwnode_handle is
>>> straightforward. But IMHO it doesn't solve the readability problem of
>>> either
>>> casting the ACPI/PPTT token directly to the resulting fwnode_handle *, or
>>> alternatively an actual fwnode_handle with bogus fwnode_operations to
>>> wrap
>>> that token.
>>
>>
>> I'm not talking about that at all.
>>
>>>>
>>>> Anyway, the idea is to have one pointer in there instead of two that
>>>> cannot be used at the same time and there's no reason why of_node
>>>> should be special.
>>>
>>>
>>>
>>>          Avoid two pointers for size, or readability? Because the last
>>> version had a union with of_node, which isn't strictly necessary as I can
>>> just cast the pptt token to of_node. There is exactly one line of code
>>> after
>>> that which uses the token and it doesn't care about type.
>>
>>
>> So call this field "token" or similar.  Don't call it "of_node" and
>> don't introduce another "firmware_node" thing in addition to that.
>> That just is a mess, sorry.
>
>
> I sort of agree, I think I can just change the whole of_node to a generic
> 'void *firmware_unique' which works fine for the PPTT code, it should also
> work for the DT code in cache_leaves_are_shared().
>
> The slight gocha is there is a bit of DT code which initially runs earlier
> that uses of_node as an indirect parameter to a couple functions (by just
> passing the cacheinfo). Let me see if I can tweak that a bit.
>
> Frankly, If I understood completely all the *priv cases I suspect it might
> be possible to collapse *of_node into that as well. That is as long as no
> one decides to flush out DT on x86, or PPTT on x86.

I'm not aware of any plans to go in that direction.

Anyway, that would be a worry of whoever wanted to do that.  No need
to worry about it upfront.
