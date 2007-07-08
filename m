From: Marcelo Tosatti <marcelo@kvack.org>
Subject: Re: rtc-cmos not supporting RTC_AIE?
Date: Sun, 8 Jul 2007 15:03:50 -0400
Message-ID: <20070708190350.GB20078__39315.8059953295$1183921492$gmane$org@dmt>
References: <20070330235759.GC4252@cosmic.amd.com>
	<20070402165511.GD5024@cosmic.amd.com> <20070708034633.GA19633@dmt>
	<200707072226.50069.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707072226.50069.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: rtc-linux@googlegroups.com, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, devel@laptop.org
List-Id: linux-pm@vger.kernel.org

On Sat, Jul 07, 2007 at 10:26:49PM -0700, David Brownell wrote:
> On Saturday 07 July 2007, Marcelo Tosatti wrote:
> 
> > 
> > David,
> > 
> > Is there any reason why programs using RTC_AIE/RTC_ALM_SET ioctls are    
> > unable to arm alarm irq's?                                              
> 
> The ALM_SET request never did!  And I'm pretty sure AIE_ON does
> indeed set it ... the test cases use ALM_SET then AIE_ON, which
> is the "traditional" idiom (i.e. legacy drivers/char/rtc.c idiom).

My point is that RTC_ALM_SET after RTC_AIE_ON works with drivers/char/rtc.c
but not rtc-cmos:

        ret = ioctl(fd, RTC_AIE_ON);
        if (ret) {
                perror("ioctl RTC_AIE_ON");
                exit(0);
        }

        ret = ioctl(fd, RTC_ALM_SET, &rtctime);
        if (ret) {
                perror("ioctl RTC_ALM_SET");
                exit(0);
        }

I think its fine to consider such applications broken anyway?

> > I'm aware of the new RTC_WKALM_SET... but shouldnt backward
> > compatibility be kept?
> 
> According to <linux/rtc.h> the ALM_SET ioctl takes an rtc_time,
> while WKALM_SET takes an rtc_wkalm ... which differs from the
> former by including the flag controlling wheter the alarm will
> be enabled (or not) when setting the alarm.  (Model inherited
> from EFI.)

Right.

>  
> > The code seems to imply that its not supported anymore, however ioctl
> > returns success but no alarm is fired (for instance alarm.enabled is set
> > to 0):
> > 
> >         case RTC_ALM_SET:
> >                 if (copy_from_user(&alarm.time, uarg, sizeof(tm)))
> >                         return -EFAULT;
> > 
> >                 alarm.enabled = 0;
> >                 alarm.pending = 0;
> >                 alarm.time.tm_wday = -1;
> >                 alarm.time.tm_yday = -1;
> >                 alarm.time.tm_isdst = -1;
> 
> That code is generic RTC framework code (rtc-dev.c), and not
> code specific to rtc-cmos ... the comment immediately following
> that (2.6.22-rc7 and previous) should clarify many of the issues.
> 
> I think the current manpage does the same.  (If it mentions the
> /dev/rtc0, /dev/rtc1, etc files, it should be current enough.)
> 
> What it does is just stuff the rtc_time into the expanded
> rtc_wkalm.  The idea is that the RTC drivers only support one
> alarm-setting method, but the /dev/rtcN ioctl interface uses
> it in two modes:
> 
>  - "legacy", up to 24 hours in the future, and requiring
>    the alarm to be enabled later with AIE_ON;
> 
>  - "EFI-style", into the arbitrary future, and bundling the
>    flag saying whether to enable the alarm.
> 
> Since ALM_SET is the legacy mode, it requires separate AIE_ON
> (from the RTC driver directly).  But RTC_WKALM_SET doesn't.
> 
> - Dave
> 
