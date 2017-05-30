From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH v4 8/8] arm,arm64,drivers: add a prefix to drivers
 arch_topology interfaces
Date: Tue, 30 May 2017 15:59:46 +0100
Message-ID: <20170530145946.v3n44cx56flhbi5l@e106622-lin>
References: <20170420144316.15632-1-juri.lelli@arm.com>
 <20170420144316.15632-9-juri.lelli@arm.com>
 <20170525131802.GE16244@kroah.com>
 <20170526101032.2t2xn5wrfenimu5w@e106622-lin>
 <20170526183610.GB16490@kroah.com>
 <bcc2f8f1-e953-9f32-2aa2-e660b0351e0a@arm.com>
 <20170529095818.GA9892@kroah.com>
 <b5071e53-f9fa-cffe-e13d-731549382d56@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751082AbdE3O7w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 May 2017 10:59:52 -0400
Content-Disposition: inline
In-Reply-To: <b5071e53-f9fa-cffe-e13d-731549382d56@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, broonie@kernel.org

On 29/05/17 12:46, Dietmar Eggemann wrote:
> On 05/29/2017 11:58 AM, Greg KH wrote:
> > On Mon, May 29, 2017 at 11:20:24AM +0200, Dietmar Eggemann wrote:
> > > Hi Greg,
> > > 
> > > On 05/26/2017 08:36 PM, Greg KH wrote:
> > > > On Fri, May 26, 2017 at 11:10:32AM +0100, Juri Lelli wrote:
> > > > > Hi,
> > > > > 
> > > > > On 25/05/17 15:18, Greg KH wrote:
> > > > > > On Thu, Apr 20, 2017 at 03:43:16PM +0100, Juri Lelli wrote:
> > > 
> > > [...]
> > > 
> > > > > > But this is all really topology stuff, right?  Why use "capacity" at
> > > > > > all:
> > > > > > 	topology_normalize_cpu()
> > > > > > 	topology_parse_cpu()
> > > > > > 	topology_scale_cpu()
> > > > > > 	topology_set_scale()
> > > > > > ?
> > > > > > 
> > > > > > It's always best to put the "subsystem" name first, we have a bad
> > > > > > history of getting this wrong in the past by putting the verb first, not
> > > > > > the noun.
> > > > > > 
> > > > > 

[...]

> > > > 
> > > > Oh, and drop "capacity" please :)
> > > 

[...]

> > 
> > I think that if you are creating an api that the scheduler will use, you
> > need to ask the scheduler maintainers/developers what they want to see
> > here, as that would be up to them, not me...
> 
> The scheduler API exists already. It is arch_scale_cpu_capacity() and
> arch_scale_freq_capacity() in kernel/sched/sched.h. An arch is able to
> overwrite these two functions by defining them (since commit 8cd5601c5060
> and dfbca41f3479):
> 
> #define arch_scale_cpu_capacity 'arch implementation of capacity scaling by
> micro-architectural + max frequency (OPPmax)'
> 
> #define arch_scale_freq_capacity 'arch implementation of capacity scaling by
> 'frequency ((OPPmin..OPPmax)'
> 
> There is no naming convention from the scheduler side on these functions
> though. They should just express what they're doing, scaling capacity by
> something.
> 

So, discussing this naming with Morten off-line we seemed actually to
agree that the following might adhere even better to what the functions
actually do:

 topology_parse_cpu_capacity() - it parses the raw capacity-dmips-mhz
 values from DT; so it seems OK to leave capacity in the name here

 topology_set_cpu_scale() - it sets the per_cpu cpu_scale variable; so
 this name seems saner that the one with "_capacity"

 topology_get_cpu_scale() - dual of the previous one

 topology_normalize_cpu_scale() - it normalizes cpu_scale variables
 across the system CPUs (and calls topology_set_cpu_scale() to set the
 normalized values)

Greg, does this approack look saner to you as well?
If yes, I'll send a new version of the set shortly.

And, as I already said on IRC, apologies for this naming fight. :)

Thanks,

- Juri
