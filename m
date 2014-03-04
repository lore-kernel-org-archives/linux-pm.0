From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: add maintainers for arm64 acpi
Date: Tue, 4 Mar 2014 18:59:46 +0800
Message-ID: <CACxGe6tD3mQshDSoEQaPXAnXG_siUdiFoAWhjmO2gDY7ZzkjUw@mail.gmail.com>
References: <1393899345-7397-1-git-send-email-graeme.gregory@linaro.org>
 <1393899345-7397-2-git-send-email-graeme.gregory@linaro.org>
 <1393899715.20435.8.camel@joe-AO722> <53153A4C.9050602@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <53153A4C.9050602@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Joe Perches <joe@perches.com>, Graeme Gregory <graeme.gregory@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 4, 2014 at 10:28 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 03/03/2014 06:21 PM, Joe Perches wrote:
>> On Tue, 2014-03-04 at 10:15 +0800, Graeme Gregory wrote:
>>> Add maintainers for the arm-core file for arm64 ACPI support
>>
>> Shouldn't something have to be in the kernel
>> tree before there's a MAINTAINERS entry?
>
> or in linux-next and the patch can be added to linux-next (some git tree).

Sure, it makes sense to merge this file along with the rest of the
series, but I certainly appreciate that Graeme and Hanjun are willing
to volunteer to do this work.

On Tue, Mar 4, 2014 at 6:23 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, Mar 04, 2014 at 02:15:45AM +0000, Graeme Gregory wrote:
>> +ACPI ARM64
>
> That's a pretty broad statement for a single file. Is it core support,
> architected peripherals, SoC?

That's a good point. Graeme, it would be good if you could put some
text in the patch describing how you propose the maintainership to
work. Unfortunately the maintainers file doesn't have any kind of
comments field, otherwise I'd suggest you make those comments directly
there.

Given that ACPI can touch a lot of subsystems I would expect you and
Hanjun not to be merging much code directly, but being listed in
maintainers means that you will be kept in the loop when it comes to
merging ARM ACPI changes. I would also expect that anything that does
go through you (instead of merely acked) would be merged via Rafael
and Len's tree.

>
>> +M:   Hanjun Guo <hanjun.guo@linaro.org>
>> +M:   Graeme Gregory <graeme.gregory@linaro.org>
>> +S:   Supported
>> +L:   linux-acpi@vger.kernel.org
>> +F:   drivers/acpi/plat/arm-core.c
>
> This patch should be part of the series introducing the arm-core.c file
> and it will be ACKed (or NAKed) following review. We can't really commit
> maintainers to a file which does not exist in mainline and while there is
> still feedback to be addressed. It's like a blank cheque.

I agree with merging it with the rest of the series, but comparing it
to a blank cheque is not appropriate. Merely having an entry in
MAINTAINERS doesn't immediately confer trust or ability to merge code,
but it does tell people who to talk to when looking at ACPI on ARM.
You can bet that neither Linus, Len or Rafael will merge ARM ACPI
trees from them if you disagree. (And even if they did, you would
yell, and Linus would revert it).

>
> --
> Catalin

Graeme, you can add my a-b line:

Acked-by: Grant Likely <grant.likely@linaro.org>
