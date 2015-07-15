From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1] suspend: make sync() on suspend-to-RAM optional
Date: Wed, 15 Jul 2015 08:43:21 +0200
Message-ID: <20150715064320.GA23713@amd>
References: <1436927091-32520-1-git-send-email-lenb@kernel.org>
 <505338dbbcdce9416ac05f67288b10442fbda179.1436926113.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <505338dbbcdce9416ac05f67288b10442fbda179.1436926113.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue 2015-07-14 22:24:51, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> The Linux kernel suspend path has traditionally invoked sys_sync().
> 
> But sys_sync() can be expensive, and some systems do not want
> to pay the cost of sys_sync() on every suspend.

Have you measured how expesive it can be, and why it is expensive?

> So make sys_sync on suspend optional.
> 
> Create sysfs attribute /sys/power/pm_suspend_do_sync.
> When set to 1, the kernel will sys_sync() on suspend,
> When set to 0, it will not.
> 
> This attribute can be changed by root at run-time.
> Kernel build parameter CONFIG_PM_SUSPEND_DO_SYNC_DEFAULT.
> As this is 1, by default, this patch does not change
> default behavior.

Why do you need CONFIG parameter?


									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
