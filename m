From: Tom Lanyon <tom@oneshoeco.com>
Subject: Re: [PATCH] ACPI / sleep: EC-based wakeup from suspend-to-idle on
 recent systems
Date: Tue, 27 Jun 2017 20:54:08 +1000
Message-ID: <CA+b4Kqdq2z6Z23P+SGQ1GYg+VMBmKG=MXL-EPZ6PfugtgB6ENQ@mail.gmail.com>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan> <3689795.xuIczRHZsl@aspire.rjw.lan>
 <2026371.DVJN39QYJi@aspire.rjw.lan> <2368998.dmCsnrcXZy@aspire.rjw.lan>
 <CA+55aFyBfHVyh=TMifF+0KGEVy6JEyDz=gbHdP7nM2roa++X4Q@mail.gmail.com>
 <CA+b4Kqd9qV0Pc7wJ2eHKcA-7+a23tY9gfe2Abm4=Bd08SKkh8w@mail.gmail.com> <CAHp75VeYkh4hHtLbjWwVZjT=wGp0wrq_k6XiLuFF62L2MiRVxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeYkh4hHtLbjWwVZjT=wGp0wrq_k6XiLuFF62L2MiRVxg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>, =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 27 June 2017 at 16:47, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> Tom, thanks for this.
> I would speculate that the problem might be in the certain device
> drivers. It would be nice to get statistics which wakeup source
> generates more hits.

Is this something I can determine without CONFIG_ACPI_DEBUG being enabled?

I don't get anything in dmesg other than indications that it's
resuming and then sleeping again every second or so.

[   45.463907] PM: Suspending system (freeze)
[   47.703216] PM: suspend of devices complete after 2028.170 msecs
[   47.721329] PM: late suspend of devices complete after 18.108 msecs
[   47.723153] ACPI : EC: interrupt blocked
[   47.757801] PM: noirq suspend of devices complete after 35.746 msecs
[   47.757802] PM: suspend-to-idle
[   48.944708] Suspended for 0.779 seconds
[   48.945030] ACPI : EC: interrupt unblocked
[   48.980728] PM: noirq resume of devices complete after 35.924 msecs
[   48.982265] ACPI : EC: interrupt blocked
[   49.027946] PM: noirq suspend of devices complete after 47.016 msecs
