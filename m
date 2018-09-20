From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 02/12][RFC v3] PM / hibernate: Check the success of
 generating md5 digest before hibernation
Date: Fri, 21 Sep 2018 00:05:10 +0200
Message-ID: <20180920220510.GE27468@xo-6d-61-c0.localdomain>
References: <cover.1537275915.git.yu.c.chen@intel.com>
 <f50baa939e550d4c6e09fd15ed2c0ddb0b23b023.1537275915.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f50baa939e550d4c6e09fd15ed2c0ddb0b23b023.1537275915.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed 2018-09-19 15:38:17, Chen Yu wrote:
> Currently if get_e820_md5() fails, then it will hibernate nevertheless.
> Actually the error code should be propagated to upper caller so that
> the hibernation could be aware of the result and terminates the process
> if md5 digest fails.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  arch/x86/power/hibernate_64.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
