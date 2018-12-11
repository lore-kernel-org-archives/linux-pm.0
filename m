From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 20/20] PM: Switch to use %ptR
Date: Tue, 11 Dec 2018 14:29:20 +0200
Message-ID: <CAHp75Vc_vQE60UQQWGHJ8BvZSCK-VoU6n76pE-=SDKpkz2MU5w@mail.gmail.com>
References: <20181204212330.69515-1-andriy.shevchenko@linux.intel.com>
 <20181204212330.69515-21-andriy.shevchenko@linux.intel.com> <8224399.K2TIF5fxr2@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8224399.K2TIF5fxr2@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>, Mark Salyzyn <salyzyn@android.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 11, 2018 at 2:12 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, December 4, 2018 10:23:30 PM CET Andy Shevchenko wrote:
> > Use %ptR instead of open coded variant to print content of
> > struct rtc_time in human readable format.
> >
> > Cc: linux-pm@vger.kernel.org
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Do you want me to take this patch?

Alexandre took all of them, thanks!

>
> > ---
> >  drivers/base/power/trace.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
> > index 1cda505d6a85..b11f47a1e819 100644
> > --- a/drivers/base/power/trace.c
> > +++ b/drivers/base/power/trace.c
> > @@ -118,9 +118,7 @@ static unsigned int read_magic_time(void)
> >       unsigned int val;
> >
> >       mc146818_get_time(&time);
> > -     pr_info("RTC time: %2d:%02d:%02d, date: %02d/%02d/%02d\n",
> > -             time.tm_hour, time.tm_min, time.tm_sec,
> > -             time.tm_mon + 1, time.tm_mday, time.tm_year % 100);
> > +     pr_info("RTC time: %ptRt, date: %ptRd\n", &time, &time);
> >       val = time.tm_year;                             /* 100 years */
> >       if (val > 100)
> >               val -= 100;
> >
>
>


-- 
With Best Regards,
Andy Shevchenko
