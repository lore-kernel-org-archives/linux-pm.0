From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [Update][PATCH 1/2] cpufreq: intel_pstate: Per CPU P-State
 limits
Date: Wed, 12 Oct 2016 17:45:10 -0700
Message-ID: <1476319510.30002.14.camel@linux.intel.com>
References: <1476299241-87924-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <3832699.WyNH3AWCH1@vostro.rjw.lan>
         <1476314165.59335.137.camel@linux.intel.com>
         <CAJZ5v0gOqjE_FD+AQQ8fpbnnm7cbjaft8Dw1vCjF3r3_Y5wCSQ@mail.gmail.com>
         <CAJZ5v0hWeNwf9ZNmKVo9MebjsFyN-XNQ9oBjuMD6=L=4VTG-Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:26834 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751969AbcJMAsD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Oct 2016 20:48:03 -0400
In-Reply-To: <CAJZ5v0hWeNwf9ZNmKVo9MebjsFyN-XNQ9oBjuMD6=L=4VTG-Yg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>

On Thu, 2016-10-13 at 02:34 +0200, Rafael J. Wysocki wrote:
> On Thu, Oct 13, 2016 at 2:16 AM, Rafael J. Wysocki <rafael@kernel.org
> > wrote:
> > 
> > On Thu, Oct 13, 2016 at 1:16 AM, Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > > 
> > > Hi,
> > > 
> > > On Thu, 2016-10-13 at 00:26 +0200, Rafael J. Wysocki wrote:
> > > 
> > > [...]
> > > 
> > > > 
> > > > 
> > > > I have a couple of comments to the details, but let me start
> > > > with a
> > > > high-level view.
> > > > I would do this quite differently.  There is quite a bit of a
> > > > headache with
> > > > keeping the global settings (intel_pstate/max(min)_perf_pct)
> > > > and the
> > > > per-policy
> > > > scaling_max(min)_freq in sync and I'm not sure this really is
> > > > necessary.
> > > > Moreover, all of these updates are asynchronous with respect to
> > > > the
> > > > scheduler
> > > > callback anyway, so there are races this synchronization
> > > > between the
> > > > settings
> > > > doesn't cover.  IMO, it would be sufficient to combine the two
> > > > in
> > > > intel_pstate_get_min_max() only where the limits to apply for
> > > > the
> > > > given CPU are
> > > > computed.
> > > > 
> > > > So if limits->max_sysfs_perf is there (in addition to or even
> > > > instead
> > > > of
> > > > limits->max_sysfs_pct), intel_pstate_get_min_max() can be
> > > > something
> > > > like:
> > > Idea is to preserve current functionality.
> > > 
> > > The problem with approach is that limits are changed via cpufreq
> > > sysfs,
> > > the intel_pstate sysfs doesn't reflect that. This is the value it
> > > is
> > > displaying currently so keeping the same functionality.
> > > 
> > > Currently we know from Intel P-state sysfs the limited
> > > performance
> > > value irrespective of which sysfs did. So I don't want to break
> > > this
> > > behavior (There are tools reading intel_pstate sysfs for current
> > > limits
> > > to get to next quickly to meet thermal deadline, also cpufreq
> > > sysfs
> > > limits can change without tools knowledge by say thermal or _PPC,
> > > so
> > > the intel P-state sysfs is a common place now).
> > Sigh.  OK
> > 
> > Why don't we update the effective min and max (stored in static
> > variables) when (a) the global sysfs is written to and (b) on
> > updates
> > via ->set_policy()?
> Bad idea.
> 
> But it looks like the effective min and max only need to be computed
> in the "show" routines before returning them.
The other place is just to check error during set max/min_perf_pct via
sysfs. Want to avoid store bad limits stored.

Thanks,
Srinivas

