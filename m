From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] ACPI / sleep: EC-based wakeup from suspend-to-idle on
 recent systems
Date: Tue, 27 Jun 2017 09:47:45 +0300
Message-ID: <CAHp75VeYkh4hHtLbjWwVZjT=wGp0wrq_k6XiLuFF62L2MiRVxg@mail.gmail.com>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan> <3689795.xuIczRHZsl@aspire.rjw.lan>
 <2026371.DVJN39QYJi@aspire.rjw.lan> <2368998.dmCsnrcXZy@aspire.rjw.lan>
 <CA+55aFyBfHVyh=TMifF+0KGEVy6JEyDz=gbHdP7nM2roa++X4Q@mail.gmail.com> <CA+b4Kqd9qV0Pc7wJ2eHKcA-7+a23tY9gfe2Abm4=Bd08SKkh8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34163 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbdF0Grr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jun 2017 02:47:47 -0400
In-Reply-To: <CA+b4Kqd9qV0Pc7wJ2eHKcA-7+a23tY9gfe2Abm4=Bd08SKkh8w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tom Lanyon <tom@oneshoeco.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>, =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, Jun 27, 2017 at 8:50 AM, Tom Lanyon <tom@oneshoeco.com> wrote:
> On 23 June 2017 at 12:40, Linus Torvalds <torvalds@linux-foundation.org> wrote:

>     Linux during s2idle => 6% battery drain per hour.
>     Win10 during sleep => 1% battery drain per hour.
>
> where Linux = 4.12-rc6 + the latest patch from your acpi-pm-test branch.
>
> So whilst s2idle halves the battery drain compared to the machine
> staying powered on, it's still significantly more draining than Win10.
> Let me know if there's any more useful analysis I can do.

Tom, thanks for this.
I would speculate that the problem might be in the certain device
drivers. It would be nice to get statistics which wakeup source
generates more hits.


-- 
With Best Regards,
Andy Shevchenko
