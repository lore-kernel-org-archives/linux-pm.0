From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Skip latency measurements if timekeeping is suspended
Date: Wed, 18 Mar 2015 23:30:08 +0100
Message-ID: <19573969.Pdd3px1nTO@vostro.rjw.lan>
References: <1426695946-21705-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1426695946-21705-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, March 18, 2015 05:25:46 PM Geert Uytterhoeven wrote:
> The PM Domain code uses ktime_get() to perform various latency
> measurements.  However, if ktime_get() is called while timekeeping is
> suspended, the following warning is printed:
> 
>     WARNING: CPU: 0 PID: 1340 at kernel/time/timekeeping.c:576 ktime_get+0x30/0xf4()
> 
> This happens when resuming the PM Domain that contains the clock events
> source. Chain of operations is:
> 
>     timekeeping_resume()
>     {
>         clockevents_resume()
>             sh_cmt_clock_event_resume()
>                 pm_genpd_syscore_poweron()
>                     pm_genpd_sync_poweron()
>                         genpd_power_on()
>                             ktime_get(), but timekeeping_suspended == 1
>         ...
>         timekeeping_suspended = 0;
>     }
> 
> Skip all latency measurements if timekeeping is suspended to fix this.

I don't think that this is where we should fix it.  At least using
timekeeping_suspended outside of the timekeeping core would not be
welcome by its maintainers.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> I'm not sure if this is needed for all latency measurements.
> So far I only encountered it while powering-on a clock domain during
> resume from s2ram.

The problem seems to be that the clock domain is powered on in a
syscore resume routine which happens to be called before timekeeping_resume().
It looks like we either need to force the right ordering somehow or have a
special variant of GENPD_DEV_TIMED_CALLBACK() for syscore suspend/resume that
won't do the latency measurement at all (which doesn't make much sense at
this point, because time is effectively "frozen" then).

Rafael

