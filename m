From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c-s3c2410: Add stub runtime power management
Date: Mon, 13 Feb 2012 23:31:39 +0000
Message-ID: <20120213233139.GJ2999@freya.fluff.org>
References: <1327171600-5489-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4F1C082D.2080005@gmail.com>
 <20120122152234.GA2915@opensource.wolfsonmicro.com>
 <4F1C45C6.1040003@gmail.com>
 <CADkCAusScak6gH4BBowrOpveGG=eDjZdj+X8vF4D5+yi8gv5PA@mail.gmail.com>
 <4F1C4BF4.5040409@gmail.com>
 <20120122213952.GA29022@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120122213952.GA29022-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bill Gatliff <bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Sun, Jan 22, 2012 at 09:39:53PM +0000, Mark Brown wrote:
> On Sun, Jan 22, 2012 at 06:48:36PM +0100, Sylwester Nawrocki wrote:
> > On 01/22/2012 06:27 PM, Bill Gatliff wrote:
> 
> > > I for one would rather see in-kernel drivers that require it, and then
> 
> > In fact we have to deal with the opposite now, as some existing drivers
> > have been used for multiple generations of SoC, where almost unchanged
> > device IPs are deployed. Those drivers were originally written for the
> > simplest SoCs.
> 
> TBH I think most of the devices for which people are running these days
> will be able to get some win from the system wide stuff - the WFI modes
> aren't exactly the latest thing in hardware terms, it's just been a long
> road to getting them supported.  Infrastructure like Mark's PM QoS work
> and Raphael's PM domains work has really helped a lot here.

The WFI stuff's been around for ages, and is generally just the core that
is affected. The deep sleep options might be useful, so I don't see any
reason not to do this. I also approve that it might allow people to shut
down I2C units they're not using at the time to save power.

-- 
Ben
