From: Chen Yu <yu.c.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2][RFC v6] timekeeping: Ignore the bogus
 sleep time if pm_trace is enabled
Date: Tue, 8 Nov 2016 20:50:06 +0800
Message-ID: <20161108125006.GD7191@yu-desktop-1.sh.intel.com>
References: <cover.1478589736.git.yu.c.chen@intel.com>
 <e0ed3331627184f3da6243b00cfa69dd78e85514.1478589736.git.yu.c.chen@intel.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBDFLXENW3AORBCEQQ7AQKGQEGRZEPJY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <e0ed3331627184f3da6243b00cfa69dd78e85514.1478589736.git.yu.c.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 08, 2016 at 05:01:35PM +0800, Chen Yu wrote:
> From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> 
> Previously we encountered some memory overflow issues due to
> the bogus sleep time brought by inconsistent rtc, which is
> triggered when pm_trace is enabled, and we have fixed it
> in recent kernel. However it's improper in the first place
> to call __timekeeping_inject_sleeptime() in case that pm_trace
> is enabled simply because that "hash" time value will wreckage
> the timekeeping subsystem.
> 
> This patch is to bypass the bogus rtc interval when pm_trace is enabled.
> 
> Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
> Cc: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Chen Yu <yu.c.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>
[cut]
Will resend another version. Thanks. 

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
