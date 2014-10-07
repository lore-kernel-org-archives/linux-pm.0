From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Potential cpufreq backports for v3.10 LTS
Date: Tue, 7 Oct 2014 15:56:24 -0700
Message-ID: <20141007225624.GA8171@kroah.com>
References: <20141007114844.GT4609@sirena.org.uk>
 <20141007164643.GA3748@kroah.com>
 <20141007170800.GL4609@sirena.org.uk>
 <20141007200458.GA12028@kroah.com>
 <20141007204505.GL4609@sirena.org.uk>
 <20141007215807.GA29188@kroah.com>
 <20141007225006.GM4609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:39368 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbaJGW4Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Oct 2014 18:56:24 -0400
Content-Disposition: inline
In-Reply-To: <20141007225006.GM4609@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Xiaoguang Chen <chenxg@marvell.com>, Stratos Karafotis <stratosk@semaphore.gr>, Andreas Schwab <schwab@linux-m68k.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Amit Kucheria <amit.kucheria@linaro.org>, stable@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Oct 07, 2014 at 11:50:06PM +0100, Mark Brown wrote:
> On Tue, Oct 07, 2014 at 02:58:07PM -0700, Greg Kroah-Hartman wrote:
> > On Tue, Oct 07, 2014 at 09:45:05PM +0100, Mark Brown wrote:
> 
> > > Actually I thinkoed here, as I said in reply to the stable mail the
> > > problematic patch was "19c763031acb8 cpufreq: serialize calls to
> > > __cpufreq_governor()" which was reverted in "56d07db cpufreq: Remove
> > > temporary fix for race between CPU hotplug and sysfs-writes".  The above
> > > commit ID (95731eb) should be good.
> 
> > > Sorry about the confusion here.
> 
> > Ok, I'm still confused.  I've applied 3 patches to the 3.10-stable
> > queue, in this order:
> 
> To the best of my ability to assess:
> 
> > 	19c763031acb831a5ab9c1a701b7fedda073eb3f	cpufreq: serialize calls to __cpufreq_governor()
> 
> This one is bad.

Ok, now deleted, thanks for letting me know.

greg k-h
