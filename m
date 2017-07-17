From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 1/2] ACPI / boot: Correct address space of __acpi_map_table()
Date: Mon, 17 Jul 2017 12:57:14 +0300
Message-ID: <CAHp75Vc0tCVakHm6oaC5JVM1yZ2oE_8evi2UZm2X98oNXM3k2A@mail.gmail.com>
References: <20170708155030.12587-1-andriy.shevchenko@linux.intel.com> <596C883D.6060503@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34878 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbdGQJ5P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jul 2017 05:57:15 -0400
In-Reply-To: <596C883D.6060503@huawei.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On Mon, Jul 17, 2017 at 12:49 PM, Hanjun Guo <guohanjun@huawei.com> wrote:
> On 2017/7/8 23:50, Andy Shevchenko wrote:
>> Sparse complains about wrong address space used in __acpi_map_table()
>> and in __acpi_unmap_table().
>>
>> arch/x86/kernel/acpi/boot.c:127:29: warning: incorrect type in return expression (different address spaces)
>> arch/x86/kernel/acpi/boot.c:127:29:    expected char *
>> arch/x86/kernel/acpi/boot.c:127:29:    got void [noderef] <asn:2>*
>> arch/x86/kernel/acpi/boot.c:135:23: warning: incorrect type in argument 1 (different address spaces)
>> arch/x86/kernel/acpi/boot.c:135:23:    expected void [noderef] <asn:2>*addr
>> arch/x86/kernel/acpi/boot.c:135:23:    got char *map
>>
>> Correct address space to be in align of type of returned and passed
>> parameter.

>> -char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
>> -void __acpi_unmap_table(char *map, unsigned long size);
>> +void __iomem *__acpi_map_table(unsigned long phys_addr, unsigned long size);
>> +void __acpi_unmap_table(void __iomem *map, unsigned long size);
>
> This breaks ACPI compile on ARM64 as ARM64 has its definition for those
> two functions,

Oops, missed that, sorry.

> I see patches in linux-next already, should I add a patch on top
> to fix it, or this patch should be respined?

Whatever Rafael prefers. I'm fine with either.
I have more patches against that c-file, perhaps better to respin.

-- 
With Best Regards,
Andy Shevchenko
