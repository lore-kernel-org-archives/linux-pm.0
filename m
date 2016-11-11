From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH][RFC v7] timekeeping: Ignore the bogus sleep
 time if pm_trace is enabled
Date: Fri, 11 Nov 2016 02:27:13 +0100
Message-ID: <2641376.PTl7Fxfrgz@vostro.rjw.lan>
References: <1478753753-24650-1-git-send-email-yu.c.chen@intel.com> <CALAqxLXVaVWBTNs2w-4t6wNsPukQu40wgVcM9B9zudv2KL682Q@mail.gmail.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBDDNDZNP7UOBBO5ZSTAQKGQEEGVLV6Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CALAqxLXVaVWBTNs2w-4t6wNsPukQu40wgVcM9B9zudv2KL682Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chen Yu <yu.c.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, November 10, 2016 10:26:09 AM John Stultz wrote:
> On Wed, Nov 9, 2016 at 8:55 PM, Chen Yu <yu.c.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > Previously we encountered some memory overflow issues due to
> > the bogus sleep time brought by inconsistent rtc, which is
> > triggered when pm_trace is enabled, and we have fixed it
> > in recent kernel. However it's improper in the first place
> > to call __timekeeping_inject_sleeptime() in case that pm_trace
> > is enabled simply because that "hash" time value will wreckage
> > the timekeeping subsystem.
> >
> > This patch is originally written by Thomas, which would bypass
> > the bogus rtc interval when pm_trace is enabled.
> > Meanwhile, if system succeed to resume back with pm_trace set, the
> > users are warned to adjust the bogus rtc either by ntp-date or rdate,
> > by resetting pm_trace_rtc_abused to false, otherwise above tools might
> > not work as expected.
> >
> > Originally-from: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> > Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
> > Cc: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > Cc: Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > Cc: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Cc: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
> > Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> > Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> > Signed-off-by: Chen Yu <yu.c.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> 
> Looks ok to me. I'm queueing it up for testing.  If no one objects
> (and I don't see any issues) I'll merge it to my tree and push it to
> -tip through Thomas.

No objections here, thanks John!

Cheers,
Rafael

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
