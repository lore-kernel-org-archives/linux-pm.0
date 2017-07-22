From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 5/5] ACPI / boot: Don't handle SCI on HW reduced platforms
Date: Sat, 22 Jul 2017 04:52:15 +0300
Message-ID: <CAHp75VdnQxg81aa6F2hEL6ZKLVybwBZH+NH87dXXrLnjDjzGQg@mail.gmail.com>
References: <20170718150420.61600-1-andriy.shevchenko@linux.intel.com>
 <20170718150420.61600-6-andriy.shevchenko@linux.intel.com> <1887578.qouKrx6t3P@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33823 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbdGVBwQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2017 21:52:16 -0400
In-Reply-To: <1887578.qouKrx6t3P@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Sat, Jul 22, 2017 at 1:28 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, July 18, 2017 06:04:20 PM Andy Shevchenko wrote:
>> As per note in 5.2.9 Fixed ACPI Description Table (FADT) chapter of ACPI
>> specification OSPM will ignore fields related to the ACPI HW register
>> interface, one of which is SCI_INT.
>>
>> Follow the spec and ignore any configuration done for interrupt line
>> defined by SCI_INT if FADT specifies HW reduced platform.

> Can we invalidate acpi_gbl_FADT.sci_interrupt somehow for
> acpi_gbl_reduced_hardware?

At some point there INVALID_ACPI_IRQ is used. There is also helper to
check it acpi_sci_irq_valid().

So, we can use that helper instead.

> The checks added below look somewhat arbitrary and it would be good to
> provide some argumentation on why everything is covered by them as needed.


-- 
With Best Regards,
Andy Shevchenko
