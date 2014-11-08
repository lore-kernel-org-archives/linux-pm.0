From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Hibernate: Migrate to ktime_t
Date: Sat, 08 Nov 2014 02:47:29 +0100
Message-ID: <2442680.y0UEcXlDY6@vostro.rjw.lan>
References: <20141030180453.GA55907@localhost> <3436721.isgG5Fql2m@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3436721.isgG5Fql2m@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Tina Ruchandani <ruchandani.tina@gmail.com>
Cc: pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, opw-kernel@googlegroups.com
List-Id: linux-pm@vger.kernel.org

On Thursday, October 30, 2014 08:08:17 PM Arnd Bergmann wrote:
> On Thursday 30 October 2014 11:04:53 Tina Ruchandani wrote:
> > This patch migrates swsusp_show_speed and its callers to using ktime_t instead
> > of 'struct timeval' which suffers from the y2038 problem.
> > 
> > Changes to swsusp_show_speed:
> >         - use ktime_t for start and stop times
> >         - pass start and stop times by value
> > Calling functions affected:
> >         - load_image
> >         - load_image_lzo
> >         - save_image
> >         - save_image_lzo
> >         - hibernate_preallocate_memory
> > Design decisions:
> >         - use ktime_t to preserve same granularity of reporting as before
> >         - use centisecs logic as before to avoid 'div by zero' issues caused by
> >           using seconds and nanoseconds directly
> >         - use monotonic time (ktime_get()) since we only care about elapsed time.
> > 
> > Signed-off-by: Tina Ruchandani <ruchandani.tina@gmail.com>
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Patch queued up for 3.19-rc1, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
