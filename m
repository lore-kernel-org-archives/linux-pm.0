From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RESEND PATCH 1/2] PM / sleep: print function name of callbacks
Date: Tue, 01 Nov 2016 05:27:05 +0100
Message-ID: <1739391.aWGq2sgtym@vostro.rjw.lan>
References: <1476923170-111986-1-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476923170-111986-1-git-send-email-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, linux-pm@vger.kernel.org, Chuansheng Liu <chuansheng.liu@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, October 19, 2016 05:26:09 PM Brian Norris wrote:
> From: Douglas Anderson <dianders@chromium.org>
> 
> The printouts writen to the logs by suspend can be a bit opaque: it can
> be hard to track them down to the actual function called.  You might
> see:
> 
>   calling  rfkill1+ @ 19473, parent: phy0
>   call rfkill1+ returned 0 after 1 usecs
>   calling  phy0+ @ 19473, parent: mmc2:0001:1
>   call phy0+ returned 0 after 19 usecs
> 
> It's a bit hard to know what's actually happening.  Instead, it's nice
> to see:
> 
>   calling  rfkill1+ @ 15793, parent: phy0, cb: rfkill_suspend
>   call rfkill1+ returned 0 after 1 usecs
>   calling  phy0+ @ 15793, parent: mmc2:0001:1, cb: wiphy_suspend [cfg80211]
>   call phy0+ returned 0 after 7 usecs
> 
> That makes it very obvious what's going on.  It also has the nice side
> effect of making the suspend/resume spew a little more obvious, since
> many resume functions have the word "resume" in the name:
> 
>   calling  phy0+ @ 15793, parent: mmc2:0001:1, cb: wiphy_resume [cfg80211]
>   call phy0+ returned 0 after 12 usecs
>   calling  rfkill1+ @ 15793, parent: phy0, cb: rfkill_resume
>   call rfkill1+ returned 0 after 1 usecs
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Any reason why you need to rely on the initcall_debug stuff instead of using
the tracepoints we have there (for exactly the reason why you are pushing this
patch)?

Thanks,
Rafael
