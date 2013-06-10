From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/2] Run callback of device_prepare/complete
 consistently
Date: Mon, 10 Jun 2013 13:50:08 +0200
Message-ID: <20130610115008.GA28366@amd.pavel.ucw.cz>
References: <1370593232-3602-1-git-send-email-shuox.liu@intel.com>
 <2482951.doztFClhed@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2482951.doztFClhed@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: shuox.liu@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, len.brown@intel.com, gregkh@linuxfoundation.org, yanmin_zhang@linux.intel.com
List-Id: linux-pm@vger.kernel.org

On Fri 2013-06-07 12:36:12, Rafael J. Wysocki wrote:
> On Friday, June 07, 2013 04:20:30 PM shuox.liu@intel.com wrote:
> > dpm_run_callback is used in other stages of power states changing.
> > It provides debug info message and time measurement when call these
> > callback. We also want to benefit ->prepare and ->complete.
> > 
> > [PATCH 1/2] PM: use dpm_run_callback in device_prepare
> > [PATCH 2/2] PM: add dpm_run_callback_void and use it in device_complete
> 
> Is this an "Oh, why don't we do that?" series, or is it useful for anything
> in practice?  I'm asking, because we haven't added that stuff to start with
> since we didn't see why it would be useful to anyone.
> 
> And while patch [1/2] reduces the code size (by 1 line), so I can see some
> (tiny) benefit from applying it, patch [2/2] adds more code and is there any
> paractical reason?

Well, we have android people periodically trying to push suspend
instrumentation; usually the patches are much uglier than this. (Like,
essentially reinventing printk).

So... there is some demand for this.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
