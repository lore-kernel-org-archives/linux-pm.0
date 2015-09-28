From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH 1/3] Thermal: initialize thermal zone device correctly
Date: Mon, 28 Sep 2015 18:47:08 +0100
Message-ID: <20150928174708.GC2823@e104805>
References: <1443332908-13948-1-git-send-email-yu.c.chen@intel.com>
 <20150928142812.GA8359@e104805>
 <36DF59CE26D8EE47B0655C516E9CE64026F225EA@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE64026F225EA@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 28, 2015 at 06:30:30PM +0100, Chen, Yu C wrote:
> Hi, Javi,
> 
> > -----Original Message-----
> > From: Javi Merino [mailto:javi.merino@arm.com]
> > Sent: Monday, September 28, 2015 10:28 PM
> > To: Chen, Yu C
> > Cc: linux-pm@vger.kernel.org; edubezval@gmail.com; Zhang, Rui; linux-
> > kernel@vger.kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH 1/3] Thermal: initialize thermal zone device correctly
> > 
> > On Sun, Sep 27, 2015 at 06:48:28AM +0100, Chen Yu wrote:
> > > From: Zhang Rui <rui.zhang@intel.com>
> > >
> > > After thermal zone device registered, as we have not read any
> > > temperature before, thus tz->temperature should not be 0, which
> > > actually means 0C, and thermal trend is not available.
> > > In this case, we need specially handling for the first
> > > thermal_zone_device_update().
> > >
> > > Both thermal core framework and step_wise governor is enhanced to
> > > handle this.
> > 
> > It may be worth pointing out that the step_wise governor is the only one
> > that uses trends, so it's the only thermal governor that needs to be updated.
> > 
> OK, will add.
> > 
> > > -		if (old_target == instance->target)
> > > +		if (instance->initialized &&
> > > +		    old_target == instance->target)
> > 
> > nit: it fits in one line,
> > 
> > 		if (instance->initialized && old_target == instance->target)
> > 
> > is 77 characters.
> > 
> Not sure if the limit for one line is 75 in checkpatch.pl, I'll have a try.

The limit is 80:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/CodingStyle#n79
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/scripts/checkpatch.pl#n47

Cheers,
Javi
