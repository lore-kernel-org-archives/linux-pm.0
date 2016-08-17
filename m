From: John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC,v3] timekeeping: Limit the sleep time to avoid overflow
Date: Wed, 17 Aug 2016 12:13:18 -0700
Message-ID: <CALAqxLUU4-zvv6AGTSrOCKuxbdnJWpfUu7yxnCS1_Hiahac2OQ@mail.gmail.com>
References: <1469892465-15853-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33087 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbcHQTNT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Aug 2016 15:13:19 -0400
Received: by mail-oi0-f45.google.com with SMTP id c15so149933015oig.0
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2016 12:13:19 -0700 (PDT)
In-Reply-To: <1469892465-15853-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Stable # 3 . 17+" <stable@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Xunlei Pang <xpang@redhat.com>, Zhang Rui <rui.zhang@intel.com>, lkml <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Sat, Jul 30, 2016 at 8:27 AM, Chen Yu <yu.c.chen@intel.com> wrote:
> It is reported the hibernation fails at 2nd attempt, which
> hangs at hibernate() -> syscore_resume() -> i8237A_resume()
> -> claim_dma_lock(), because the lock has already been taken.
> However there is actually no other process would like to grab
> this lock on that problematic platform.
>
> Further investigation shows that, the problem is triggered by
> setting /sys/power/pm_trace to 1 before the 1st hibernation.
> Since once pm_trace is enabled, the rtc becomes unmeaningful
> after suspend, and meanwhile some BIOSes would like to adjust
> the 'invalid' tsc(e.g, smaller than 1970) to the release date
> of that motherboard during POST stage, thus after resumed, a
> significant long sleep time might be generated due to meaningless
> tsc delta, thus in timekeeping_resume -> tk_debug_account_sleep_time,
> if the bit31 happened to be set to 1, the fls returns 32 and then we
> add 1 to sleep_time_bin[32], which caused a memory overwritten.

Sorry for taking awhile to get to this.

So this bit seems like its actually the problematic thing. If fls()
returns 32, but the max value in sleep_time_bin[] is 31, then that's
the real broken issue, and that's where memory is being corrupted.

Adding a check on the fls() value used, or defining the the
sleep_time_bin[] as 33 entries seems like the proper fix.

And actually looking closer, since its a timespec64, the fls() could
return something as large as 64, so capping it is probably more sane.

> As depicted by System.map:
>
> ffffffff81c9d080 b sleep_time_bin
> ffffffff81c9d100 B dma_spin_lock
>
> the dma_spin_lock.val is set to 1, which caused this problem.
>
> In theory we can avoid the overflow by ignoring the idle injection
> if pm_trace is enabled, but we might still miss other cases which
> might also break the rtc, e.g, buggy clocksoure/rtc driver,
> or even user space tool such as hwclock -- so there is no generic
> method to dertermin whether we should trust the tsc.
>
> A simpler way is to set the threshold for the sleep time, and
> ignore those abnormal ones. This patch sets the upper limit of
> sleep seconds to 0x7fffffff, since no one is likely to sleep
> that long(68 years).

Having validity sanity check is probably a good idea as well, but this
papers over the real problem.

I'll send out a version of the above I think makes the most sense, and
if there's no objections I'll queue it. I am also happy to add a patch
like this one, but the commit message would need to be simplified to
just say out of paranoia we want to cap the maximum valid sleep time
to 68 years.

thanks
-john
