From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM / Domains: Skip timings during syscore suspend/resume
Date: Tue, 16 Jun 2015 01:41:05 +0200
Message-ID: <3117326.C9gLKzzTZ1@vostro.rjw.lan>
References: <1432913063-26691-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1432913063-26691-1-git-send-email-geert@linux-m68k.org>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

On Friday, May 29, 2015 05:24:23 PM Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> The PM Domain code uses ktime_get() to perform various latency
> measurements.  However, if ktime_get() is called while timekeeping is
> suspended, the following warning is printed:
> 
>     WARNING: CPU: 0 PID: 1340 at kernel/time/timekeeping.c:576 ktime_get+0x3
> 
> This happens when resuming the PM Domain that contains the clock events
> source, which calls pm_genpd_syscore_poweron(). Chain of operations is:
> 
>     timekeeping_resume()
>     {
> 	clockevents_resume()
> 	    sh_cmt_clock_event_resume()
> 		pm_genpd_syscore_poweron()
> 		    pm_genpd_sync_poweron()
> 			genpd_syscore_switch()
> 			    genpd_power_on()
> 				ktime_get(), but timekeeping_suspended == 1
> 	...
> 	timekeeping_suspended = 0;
>     }
> 
> Fix this by adding a "timed" parameter to genpd_power_{on,off}() and
> pm_genpd_sync_power{off,on}(), to indicate whether latency measurements
> are allowed.  This parameter is passed as false in
> genpd_syscore_switch() (i.e. during syscore suspend/resume), and true in
> all other cases.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Queued up for 4.2, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
