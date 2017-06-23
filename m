From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ACPI / sleep: EC-based wakeup from suspend-to-idle on
 recent systems
Date: Thu, 22 Jun 2017 19:40:39 -0700
Message-ID: <CA+55aFyBfHVyh=TMifF+0KGEVy6JEyDz=gbHdP7nM2roa++X4Q@mail.gmail.com>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan> <3689795.xuIczRHZsl@aspire.rjw.lan>
 <2026371.DVJN39QYJi@aspire.rjw.lan> <2368998.dmCsnrcXZy@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2368998.dmCsnrcXZy@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>, Tom Lanyon <tom@oneshoeco.com>, =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 22, 2017 at 4:56 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Some recent Dell laptops, including the XPS13 model numbers 9360 and
> 9365, cannot be woken up from suspend-to-idle by pressing the power
> button which is unexpected and makes that feature less usable on
> those systems.  [ details removed ]

This looks much more reasonable and more likely to work on future machines too.

Of course, who knows what broken machines it will cause problems on,
but it sounds like the code now does what it's supposed to and what
Win10 does, so maybe it JustWorks(tm). Hah.

Anyway - thanks.

             Linus
