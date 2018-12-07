From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpuidle: Add 'above' and 'below' idle state metrics
Date: Fri, 07 Dec 2018 13:20:13 +0100
Message-ID: <2696247.uWQGDES4iU@aspire.rjw.lan>
References: <1688146.Dmze7u1T7F@aspire.rjw.lan> <20181207120203.ohc7icj5wf3gbwi3@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181207120203.ohc7icj5wf3gbwi3@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, LKML <linux-kernel@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Giovanni Gherdovich <ggherdovich@suse.cz>
List-Id: linux-pm@vger.kernel.org

On Friday, December 7, 2018 1:02:05 PM CET Quentin Perret wrote:
> Hi Rafael,
> 
> On Friday 07 Dec 2018 at 12:57:00 (+0100), Rafael J. Wysocki wrote:
> > --- linux-pm.orig/Documentation/ABI/testing/sysfs-devices-system-cpu
> > +++ linux-pm/Documentation/ABI/testing/sysfs-devices-system-cpu
> > @@ -145,6 +145,8 @@ What:		/sys/devices/system/cpu/cpuX/cpui
> >  		/sys/devices/system/cpu/cpuX/cpuidle/stateN/power
> >  		/sys/devices/system/cpu/cpuX/cpuidle/stateN/time
> >  		/sys/devices/system/cpu/cpuX/cpuidle/stateN/usage
> > +		/sys/devices/system/cpu/cpuX/cpuidle/stateN/high
> 
> That should be s/high/above I suppose.

Right, thanks for spotting this. :-)

> > +		/sys/devices/system/cpu/cpuX/cpuidle/stateN/below
> 
> Other than that this seems really useful :-)

Thanks!
