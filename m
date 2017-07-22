From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 4/5] ACPI / boot: Not all platform require acpi_reduced_hw_init()
Date: Sat, 22 Jul 2017 04:53:52 +0300
Message-ID: <CAHp75VejtJC87eWhxKcT_yWKR2kOWLOARGmhiK7S9WO4bCHYRg@mail.gmail.com>
References: <20170718150420.61600-1-andriy.shevchenko@linux.intel.com>
 <20170718150420.61600-5-andriy.shevchenko@linux.intel.com> <1535497.HrG5Hi31l1@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1535497.HrG5Hi31l1@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Jul 22, 2017 at 1:25 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, July 18, 2017 06:04:19 PM Andy Shevchenko wrote:
>> Some platform might take care of legacy devices on theirs own.
>> Let's allow them to do that by exporting a weak function.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> I'd rather do it at the time when acpi_reduced_hw_init() actually needs to be
> overridden by at least one platform.

Do you mean as folded into some other patch or just as a preparatory
patch in some future series?

-- 
With Best Regards,
Andy Shevchenko
