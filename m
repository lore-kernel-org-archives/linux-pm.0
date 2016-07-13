From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / hibernate: Introduce snapshot test mode for
 hibernation
Date: Wed, 13 Jul 2016 11:50:05 +0200
Message-ID: <20160713095005.GA27870@amd>
References: <1467873658-31986-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467873658-31986-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu 2016-07-07 14:40:58, Chen Yu wrote:
> This mode is to verify if the snapshot data written to
> swap device can be successfully restored to memory. It
> is useful to ease the debugging process on hibernation,
> since this mode can not only bypass the BIOSen/bootloader,
> but also the system re-initialization.
> 
> For example:
> $ sudo echo snapshot > /sys/power/disk
> $ sudo echo disk > /sys/power/state
> 
> /* manual resume.*/
> $ sudo echo 8:3 > /sys/power/resume

Your examples will not work, will they?

This is also quite tricky/dangerous. If you do this with filesystems
mounted R/W, it is "good bye, filesystems".

I guess updating documentation would be welcome from my side,
otherwise it should be ok.

Acked-by: Pavel Machek <pavel@ucw.cz>

Best regards,
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
