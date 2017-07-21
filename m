From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 0/2] PM / suspend: Messaging updates
Date: Fri, 21 Jul 2017 18:13:45 +0300
Message-ID: <CAHp75VdGUNTU1URWqRW-B1y=2Wrw0YU0U1orC7gcVBuQRYXxZQ@mail.gmail.com>
References: <1714767.SyJDFOT8Lq@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1714767.SyJDFOT8Lq@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 21, 2017 at 3:48 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Hi,
>
> The first patch addresses a potential confusion regarding messages printed by
> the suspend core code to the kernel log and the second one adds a pr_fmt() to
> kernel/power/suspend.c.
>
> The patches are on top of the series I posted yesterday:
>
> http://marc.info/?l=linux-pm&m=150059650805506&w=2

Standardization is what I like.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Thanks,
> Rafael



-- 
With Best Regards,
Andy Shevchenko
