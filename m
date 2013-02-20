From: Miklos Szeredi <miklos-sUDqSbJrdHQHWmgEVkV9KA@public.gmane.org>
Subject: Re: Getting rid of freezer for suspend [was Re:
 [PATCH] fuse: make fuse daemon frozen along with kernel threads]
Date: Wed, 20 Feb 2013 14:13:54 +0100
Message-ID: <CAJfpegvmrFywtwS5giuCgVc5Cr3G1+fXKTPYiCZsV5P1jinxXA@mail.gmail.com>
References: <1360113112.17267.1.camel@fli24-HP-Compaq-8100-Elite-CMT-PC>
	<6332427.iqPUMjtDaQ@vostro.rjw.lan>
	<BEC9F67575FA1E429CA7CF5AE9BE3634400F30@SHSMSX102.ccr.corp.intel.com>
	<3321530.AgvEeduuPx@vostro.rjw.lan>
	<20130219104633.GA23279@xo-6d-61-c0.localdomain>
	<BEC9F67575FA1E429CA7CF5AE9BE3634403505@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <fuse-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BEC9F67575FA1E429CA7CF5AE9BE3634403505-0J0gbvR4kTiiAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/fuse-devel>,
	<mailto:fuse-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=fuse-devel>
List-Post: <mailto:fuse-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:fuse-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/fuse-devel>,
	<mailto:fuse-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: fuse-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Li, Fei" <fei.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Wang, Biao" <biao.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, "fuse-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <fuse-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "Liu,
	Chuansheng" <chuansheng.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 20, 2013 at 3:54 AM, Li, Fei <fei.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

>> From: Pavel Machek [mailto:pavel-+ZI9xUNit7I@public.gmane.org]
>>
>> freeze_priority?
>>
>> I _hope_ we will not need more than three priorities, (user, fused, kernel), but
>> I hoped not no need more than two before, so...

>
> IMHO, we still use two priorities, with the exception that user space process such
> as fuse daemon can be configured to be frozen in kernel threads frozen phase
> instead of user space processes frozen phase.

I'm not sure that will work.  Fuse processes are in fact ordinary
userspace processes, and so should be frozen before kernel threads.

Thanks,
Miklos

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
