From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V3] thermal: Add cooling device's statistics in sysfs
Date: Fri, 12 Jan 2018 09:25:45 -0800
Message-ID: <20180112172544.GB10243@localhost.localdomain>
References: <087186fecdfd85bead58e110cf8bf7ccdfab517b.1515663078.git.viresh.kumar@linaro.org>
 <20180112110943.GA4020@mordor.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37868 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932859AbeALRZq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jan 2018 12:25:46 -0500
Content-Disposition: inline
In-Reply-To: <20180112110943.GA4020@mordor.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 12, 2018 at 04:39:43PM +0530, Aishwarya Pant wrote:
> On Thu, Jan 11, 2018 at 03:06:09PM +0530, Viresh Kumar wrote:
> > This extends the sysfs interface for thermal cooling devices and exposes
> > some pretty useful statistics. These statistics have proven to be quite
> > useful specially while doing benchmarks related to the task scheduler,
> > where we want to make sure that nothing has disrupted the test,
> > specially the cooling device which may have put constraints on the CPUs.
> > The information exposed here tells us to what extent the CPUs were
> > constrained by the thermal framework.
> > 
> > The read-only "total_trans" file shows the total number of cooling state
> > transitions the device has gone through since the time the cooling
> > device is registered or the time when statistics were reset last.
> > 
> > The read-only "time_in_state_ms" file shows the time spent by the device
> > in the respective cooling states.
> > 
> > The write-only "reset" file is used to reset the statistics.
> > 
> > This is how the directory structure looks like for a single cooling
> > device:
> > 
> > $ ls -R /sys/class/thermal/cooling_device0/
> > /sys/class/thermal/cooling_device0/:
> > cur_state  max_state  power  stats  subsystem  type  uevent
> > 
> > /sys/class/thermal/cooling_device0/power:
> > autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
> > control               runtime_status
> > 
> > /sys/class/thermal/cooling_device0/stats:
> > reset  time_in_state_ms  total_trans
> > 
> > This is tested on ARM 32-bit Hisilicon hikey620 board running Ubuntu and
> > ARM 64-bit Hisilicon hikey960 board running Android.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > V2->V3:
> > - Total number of states is max_level + 1. The earlier version didn't
> >   take that into account and so the stats for the highest state were
> >   missing.
> > 
> > V1->V2:
> > - Move to sysfs from debugfs
> > 
> >  drivers/thermal/thermal_core.c    |   3 +-
> >  drivers/thermal/thermal_core.h    |   3 +
> >  drivers/thermal/thermal_helpers.c |   5 +-
> >  drivers/thermal/thermal_sysfs.c   | 146 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/thermal.h           |   1 +
> >  5 files changed, 156 insertions(+), 2 deletions(-)
> 
> <snip>
> 
> > index 27e3b1df7360..f6eb01e99816 100644
> > --- a/drivers/thermal/thermal_core.h
> > +++ b/drivers/thermal/thermal_core.h
>  +
> > +static DEVICE_ATTR(total_trans, 0444, thermal_cooling_device_total_trans_show,
> > +		   NULL);
> > +static DEVICE_ATTR(time_in_state_ms, 0444,
> > +		   thermal_cooling_device_time_in_state_show, NULL);
> > +static DEVICE_ATTR(reset, 0200, NULL, thermal_cooling_device_reset_store);
> > +
> 
> Hi
> 
> I can see that you have added some files to the sysfs ABI. It would be good to
> have these new interfaces documented in Documentation/ABI.

all thermal sysfs entries are documented here:


Documentation/thermal/sysfs-api.txt

Please update.

> 
> Aishwarya
> 
> <snip>
