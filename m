From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / sleep: cancel the synchronous restriction of
 pm-trace
Date: Wed, 20 May 2015 15:45:05 +0200
Message-ID: <20150520134505.GA1479@amd>
References: <554A297C.2040305@linux.intel.com>
 <3154303.fma7bByNVc@vostro.rjw.lan>
 <555C4AC5.4080901@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <555C4AC5.4080901@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, len.brown@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> >> -#define TRACE_DEVICE(dev) do { \
> >> +#define TRACE_DEVICE_START(dev) do { \
> >>  	if (pm_trace_enabled) \
> >> +		mutex_lock(&pt_mutex); \
> >>  		set_trace_device(dev); \
> >>  	} while(0)
> >>  
> >> +#define TRACE_DEVICE_END() \
> >> +do { \
> >> +	if (pm_trace_enabled) { \
> >> +		mutex_unlock(&pt_mutex); \
> >> +	} \
> >> +} while (0)
> >> +
> > Won't this serialize the whole thing again?
> Yes, this mutex lock will ultimately serialize all PM operations. But, all device's PM operations are asynchronous each other at first. So, the PM operation order of all devices will vary in multiple suspend/resume. This can be similar to real to an extreme, and helpful to debugging.
> 

I believe the tradeoff here is wrong. Just keep PM_TRACE simple, and
use something else for a real tricky failures..
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
