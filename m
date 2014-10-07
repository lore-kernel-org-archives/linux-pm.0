From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Potential cpufreq backports for v3.10 LTS
Date: Tue, 7 Oct 2014 14:58:07 -0700
Message-ID: <20141007215807.GA29188@kroah.com>
References: <20141007114844.GT4609@sirena.org.uk>
 <20141007164643.GA3748@kroah.com>
 <20141007170800.GL4609@sirena.org.uk>
 <20141007200458.GA12028@kroah.com>
 <20141007204505.GL4609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141007204505.GL4609@sirena.org.uk>
Sender: stable-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Xiaoguang Chen <chenxg@marvell.com>, Stratos Karafotis <stratosk@semaphore.gr>, Andreas Schwab <schwab@linux-m68k.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Amit Kucheria <amit.kucheria@linaro.org>, stable@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 07, 2014 at 09:45:05PM +0100, Mark Brown wrote:
> On Tue, Oct 07, 2014 at 01:04:58PM -0700, Greg Kroah-Hartman wrote:
> > On Tue, Oct 07, 2014 at 06:08:00PM +0100, Mark Brown wrote:
> 
> > > > >  - 59a6342203a7a cpufreq: Fix governor start/stop race condition
> 
> > > > >    This looks like a straight race condition fix.
> 
> > > > That is not a commit id in Linus's tree :(
> 
> > > Interesting, I was able to cherry-pick it...  looks like the upstream
> > > version is 95731eb.  In any case at roughly the same time you sent your
> > > mail it's been drawn to my attention off-list that this was subsequently
> > > reverted so please ignore this one.  The others should be fine though.
> 
> > Ok, I've queued the others up now.
> 
> Actually I thinkoed here, as I said in reply to the stable mail the
> problematic patch was "19c763031acb8 cpufreq: serialize calls to
> __cpufreq_governor()" which was reverted in "56d07db cpufreq: Remove
> temporary fix for race between CPU hotplug and sysfs-writes".  The above
> commit ID (95731eb) should be good.
> 
> Sorry about the confusion here.

Ok, I'm still confused.  I've applied 3 patches to the 3.10-stable
queue, in this order:
	19c763031acb831a5ab9c1a701b7fedda073eb3f	cpufreq: serialize calls to __cpufreq_governor()
	a857c0b9e24e39fe5be82451b65377795f9538d8	cpufreq: Fix wrong time unit conversion
	dfa5bb622555d9da0df21b50f46ebdeef390041b	cpufreq: ondemand: Change the calculation of target frequency

Are those correct?  Is there anything else I need to apply?

Note, 95731eb does not apply to 3.10-stable as it is already in there,
it showed up in 3.10.37.

thanks,

greg k-h
