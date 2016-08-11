From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/2][RFC] PM / sleep: Expose DPM watchdog timeout to sysfs
Date: Thu, 11 Aug 2016 20:54:42 +0200
Message-ID: <20160811185441.GA15813@amd>
References: <cover.1470908324.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54718 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbcHKSyp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Aug 2016 14:54:45 -0400
Content-Disposition: inline
In-Reply-To: <cover.1470908324.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Linux PM List <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, Takashi Iwai <tiwai@suse.de>, Benoit Goby <benoit@android.com>

Hi!

> Recently we have a new report that, the harddisk can not
> resume on time due to firmware issues, and got a kernel
> panic because of DPM watchdog timeout. Since the default
> timeout has once been modified from 12 to 60 seconds, we
> might still encounter new case which requires a longer timeout,
> so expose the value to sysfs and let the users decide which
> value is appropriate, meanwhile this can also ease the debugging
> process.
> 
> The first patch is to force DPM watchdog depending on CONFIG_PM_SLEEP,
> thus the second patch which does the actual work, can use
> CONFIG_DPM_WATCHDOG safely without checking CONFIG_PM_SLEEP.

Kernel should just work. User should not have to configure random
knobs to have working suspend/hibernation.

We do not want "CONFIG_BREAK_SUSPEND" so I believe we don't want
"CONFIG_DPM_WATCHDOG". If normal users select it and it breaks their
system, make it depend on "CONFIG_EXPERT" or hide it in some other
way or maybe remove it from Kconfig altogether. 

Or maybe CONFIG_DPM_WATCHDOG should contain numeric value that user
has to select?

And I'm pretty certain new user interfaces need to be documented.

NAK.
							Pavel

> Chen Yu (2):
>   PM / sleep: Make DPM watchdog depend on PM_SLEEP
>   PM / Sleep: Expose DPM watchdog timeout to sysfs
> 
>  drivers/base/power/main.c    |  4 +++-
>  include/linux/sched/sysctl.h |  4 ++++
>  kernel/power/Kconfig         |  2 +-
>  kernel/sysctl.c              | 16 ++++++++++++++++
>  4 files changed, 24 insertions(+), 2 deletions(-)
> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
