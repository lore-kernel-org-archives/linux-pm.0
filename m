From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/5] ACPI / boot: Correct address space of
 __acpi_map_table()
Date: Tue, 18 Jul 2017 12:23:15 +0300
Message-ID: <1500369795.29303.63.camel@linux.intel.com>
References: <20170717102404.27191-1-andriy.shevchenko@linux.intel.com>
         <20170717102404.27191-3-andriy.shevchenko@linux.intel.com>
         <CAMuHMdVSzWRsEmZRpkLN8RdnwrudyrbQiYT-8g3-BwxiSxrk7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVSzWRsEmZRpkLN8RdnwrudyrbQiYT-8g3-BwxiSxrk7A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2017-07-18 at 11:03 +0200, Geert Uytterhoeven wrote:
> Hi Andy,
> 
> On Mon, Jul 17, 2017 at 12:24 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > Sparse complains about wrong address space used in
> > __acpi_map_table()
> > and in __acpi_unmap_table().
> > 
> > arch/x86/kernel/acpi/boot.c:127:29: warning: incorrect type in
> > return expression (different address spaces)
> > arch/x86/kernel/acpi/boot.c:127:29:    expected char *
> > arch/x86/kernel/acpi/boot.c:127:29:    got void [noderef] <asn:2>*
> > arch/x86/kernel/acpi/boot.c:135:23: warning: incorrect type in
> > argument 1 (different address spaces)
> > arch/x86/kernel/acpi/boot.c:135:23:    expected void [noderef]
> > <asn:2>*addr
> > arch/x86/kernel/acpi/boot.c:135:23:    got char *map
> > 
> > Correct address space to be in align of type of returned and passed
> > parameter.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  arch/arm64/kernel/acpi.c    | 4 ++--
> 
> Thanks for the update!
> I can confirm this fixes the arm64 build for me.

Thanks to you and thanks to kbuild bot to check for ia64!

I will send v3 soon with fixed this part and extended patch 5.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
