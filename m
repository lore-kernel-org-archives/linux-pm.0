From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/2] ACPI / boot: Correct address space of
 __acpi_map_table()
Date: Mon, 17 Jul 2017 13:00:43 +0300
Message-ID: <1500285643.29303.34.camel@linux.intel.com>
References: <20170708155030.12587-1-andriy.shevchenko@linux.intel.com>
         <596C883D.6060503@huawei.com>
         <CAHp75Vc0tCVakHm6oaC5JVM1yZ2oE_8evi2UZm2X98oNXM3k2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vc0tCVakHm6oaC5JVM1yZ2oE_8evi2UZm2X98oNXM3k2A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Hanjun Guo <guohanjun@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 2017-07-17 at 12:57 +0300, Andy Shevchenko wrote:
> On Mon, Jul 17, 2017 at 12:49 PM, Hanjun Guo <guohanjun@huawei.com>
> wrote:
> > On 2017/7/8 23:50, Andy Shevchenko wrote:
> > > Sparse complains about wrong address space used in
> > > __acpi_map_table()
> > > and in __acpi_unmap_table().
> > > 
> > > arch/x86/kernel/acpi/boot.c:127:29: warning: incorrect type in
> > > return expression (different address spaces)
> > > arch/x86/kernel/acpi/boot.c:127:29:    expected char *
> > > arch/x86/kernel/acpi/boot.c:127:29:    got void [noderef] <asn:2>*
> > > arch/x86/kernel/acpi/boot.c:135:23: warning: incorrect type in
> > > argument 1 (different address spaces)
> > > arch/x86/kernel/acpi/boot.c:135:23:    expected void [noderef]
> > > <asn:2>*addr
> > > arch/x86/kernel/acpi/boot.c:135:23:    got char *map
> > > 
> > > Correct address space to be in align of type of returned and
> > > passed
> > > parameter.
> > > -char * __acpi_map_table (unsigned long phys_addr, unsigned long
> > > size);
> > > -void __acpi_unmap_table(char *map, unsigned long size);
> > > +void __iomem *__acpi_map_table(unsigned long phys_addr, unsigned
> > > long size);
> > > +void __acpi_unmap_table(void __iomem *map, unsigned long size);
> > 
> > This breaks ACPI compile on ARM64 as ARM64 has its definition for
> > those
> > two functions,
> 
> Oops, missed that, sorry.
> 
> > I see patches in linux-next already, should I add a patch on top
> > to fix it, or this patch should be respined?
> 
> Whatever Rafael prefers. I'm fine with either.
> I have more patches against that c-file, perhaps better to respin.

I missed ia64 too :-(

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
