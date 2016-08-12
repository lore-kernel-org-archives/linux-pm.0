From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH 0/2][RFC] PM / sleep: Expose DPM watchdog timeout to sysfs
Date: Fri, 12 Aug 2016 10:52:25 +0800
Message-ID: <20160812025225.GA12238@sharon>
References: <cover.1470908324.git.yu.c.chen@intel.com>
 <20160811185441.GA15813@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:11826 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbcHLCoe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Aug 2016 22:44:34 -0400
Content-Disposition: inline
In-Reply-To: <20160811185441.GA15813@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux PM List <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, Takashi Iwai <tiwai@suse.de>, Benoit Goby <benoit@android.com>

Hi,
On Thu, Aug 11, 2016 at 08:54:42PM +0200, Pavel Machek wrote:
> Hi!
> 
> > Recently we have a new report that, the harddisk can not
> > resume on time due to firmware issues, and got a kernel
> > panic because of DPM watchdog timeout. Since the default
> > timeout has once been modified from 12 to 60 seconds, we
> > might still encounter new case which requires a longer timeout,
> > so expose the value to sysfs and let the users decide which
> > value is appropriate, meanwhile this can also ease the debugging
> > process.
> > 
> > The first patch is to force DPM watchdog depending on CONFIG_PM_SLEEP,
> > thus the second patch which does the actual work, can use
> > CONFIG_DPM_WATCHDOG safely without checking CONFIG_PM_SLEEP.
> 
> Kernel should just work. User should not have to configure random
> knobs to have working suspend/hibernation.
> 
> We do not want "CONFIG_BREAK_SUSPEND" so I believe we don't want
> "CONFIG_DPM_WATCHDOG". If normal users select it and it breaks their
> system, make it depend on "CONFIG_EXPERT" or hide it in some other
> way or maybe remove it from Kconfig altogether. 
>
> Or maybe CONFIG_DPM_WATCHDOG should contain numeric value that user
> has to select?
> 
Yes, if people select it then they have the risk to break their system,
and the original thought of the patch is to behave like a diagnosis to
make it easier for the users to figure it out, how much time it takes
to suspend/resume a bogus peripheral, without recomping the kernel.
-- currently the timeout value for CONFIG_DPM_WATCHDOG can be adjusted
by menuconfig, but bug reporter might have to recompile the kernel
to confirm, and it takes some time to get a feedback from them, so...

thanks,
Yu
