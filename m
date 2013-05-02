From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH] drivers: power: Add watchdog timer to catch
 drivers which lockup during suspend.
Date: Thu, 2 May 2013 14:30:33 +0200
Message-ID: <20130502123033.GC22618@amd.pavel.ucw.cz>
References: <1367360914-23389-1-git-send-email-zoran.markovic@linaro.org>
 <20130501003058.GB20042@amd.pavel.ucw.cz>
 <CAMbhsRQkYFvOzDDn4zmbZAEsVs6iSy4mPVq5w=MzQ7p9STBDew@mail.gmail.com>
 <20130501105630.GA22552@amd.pavel.ucw.cz>
 <CAMbhsRTtYSLpAmB0hsanBH3ez4bm8BgbcH1xEBQsZSj4dc069g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMbhsRTtYSLpAmB0hsanBH3ez4bm8BgbcH1xEBQsZSj4dc069g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: Zoran Markovic <zoran.markovic@linaro.org>, lkml <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Benoit Goby <benoit@android.com>, Android Kernel Team <kernel-team@android.com>, Todd Poynor <toddpoynor@google.com>, San Mehat <san@google.com>, John Stultz <john.stultz@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> >> > do BUG which
> >> >    dumps stack of current task
> >> >    kills current task
> >> >
> >> > Current task may very well be idle task; in such case you kill the
> >> > machine. Sounds like you should be doing something else, like kill -9
> >> > instead of BUG()?
> >>
> >> Not much else you can do, you are stuck part way into suspend with a
> >> driver's suspend callback half executed.  All userspace tasks are
> >> frozen, and the suspend task is blocked indefinitely.
> >
> > Yes, there's better option. Attempt killing the [a]suspend task,
> > instead of killing the current task.
> 
> That will leave you in a completely undefined state.  If you just kill
> the task, you are likely to kill the synchronous suspend task, which
> is the task that would resume your drivers and unfreeze tasks.  That
> will leave you with no userspace tasks running, and much of your
> hardware suspended.  How is that a useful result?  If you somehow

So instead you kill random task? (BUG() from timer kills pretty much
random task, right?)

If you want to do panic(), do panic().
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
