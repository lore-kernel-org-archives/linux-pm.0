From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 6/9] ACPI/PPTT: Add topology parsing code
Date: Wed, 13 Dec 2017 23:28:35 +0100
Message-ID: <CAJZ5v0hTcC8D6pJuPK+isntWpckNgNmqLHW98iFXL817VYHHdg@mail.gmail.com>
References: <20171201222330.18863-1-jeremy.linton@arm.com> <20171201222330.18863-7-jeremy.linton@arm.com>
 <9009154.M66RGdQJXA@aspire.rjw.lan> <fc12696c-15e1-cea4-42bf-db4b5daa45f2@arm.com>
 <20171213173851.GA4060@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171213173851.GA4060@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, Al Stone <ahs3@redhat.com>, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, Len Brown <lenb@kernel.o>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 13, 2017 at 6:38 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Tue, Dec 12, 2017 at 10:13:08AM -0600, Jeremy Linton wrote:
>> Hi,
>>
>> First, thanks for taking a look at this.
>>
>> On 12/11/2017 07:12 PM, Rafael J. Wysocki wrote:
>> >On Friday, December 1, 2017 11:23:27 PM CET Jeremy Linton wrote:
>> >>The PPTT can be used to determine the groupings of CPU's at
>> >>given levels in the system. Lets add a few routines to the PPTT
>> >>parsing code to return a unique id for each unique level in the
>> >>processor hierarchy. This can then be matched to build
>> >>thread/core/cluster/die/package/etc mappings for each processing
>> >>element in the system.
>> >>
>> >>Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> >
>> >Why can't this be folded into patch [2/9]?
>>
>> It can, and I will be happy squash it.
>>
>> It was requested that the topology portion of the parser be split
>> out back in v3.
>>
>> https://www.spinics.net/lists/linux-acpi/msg78487.html
>
> I asked to split cache/topology since I am not familiar with cache
> code and Sudeep - who looks after the cache code - won't be able
> to review this series in time for v4.16.

OK, so why do we need it in 4.16?
