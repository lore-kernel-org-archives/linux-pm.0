From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH 0/2] thermal, OPP: move the CPU power estimation to the
 OPP library
Date: Thu, 11 Jan 2018 09:42:57 +0000
Message-ID: <20180111094257.GA6603@e108498-lin.cambridge.arm.com>
References: <20180109110252.13557-1-quentin.perret@arm.com>
 <20180110193431.GE3837@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753568AbeAKJnF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 11 Jan 2018 04:43:05 -0500
Content-Disposition: inline
In-Reply-To: <20180110193431.GE3837@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com

Hi Eduardo,

On Wednesday 10 Jan 2018 at 11:34:33 (-0800), Eduardo Valentin wrote:
> On Tue, Jan 09, 2018 at 11:02:50AM +0000, Quentin Perret wrote:
> > Currently, IPA estimates the power dissipated by a CPU at each available OPP
> > using its capacitance (the dynamic-power-coefficient DT binding). This series
> > relocates this feature into the OPP library as a preparation for future
> > changes. More specifically:
> > 
> >    1. The current DT-based approach for power estimation will need deep
> >       changes to support SCMI-provided power values. While the thermal
> >       subsystem is not necessarily the best place to hide multiple power
> >       estimation methods, the OPP library appears to be a good candidate to
> >       implement the required platform abstraction.
> >    2. The energy models of CPUs will be needed by other clients in the future
> >       (such as the task scheduler or CPUFreq governors for example) in order
> >       to make energy-aware decisions. The relocation to the OPP library will
> >       enable code re-use and all clients will benefit form the platform
> >       abstraction mentioned previously.
> 
> To be quite frank, I am happy to see this leaving thermal subsystem.
> However, a few concerns with the patch set as it is. First, I am not
> convinced PM OPP is the right place to put this, nor I see a good
> explanation put in the patch set why it must be part of PM OPP.

IPA already uses the OPP library to build its power model (to retrieve
the voltage and frequency). The power model itself is a per-OPP
data-structure. As such, moving it to the OPP library felt like a
natural extension of the framework. That said, if you have any
suggestions of better places to put it, please do let me know -- I'm just
hopping to make the power model available to other clients, but it
doesn't necessarily have to be through the OPP library. In the meantime,
I'll rework the cover letter to better explain the choice of PM OPP.

> Second, looks like we are following ARM "good" practice of fixing
> problems of the future. I would only really sign off for this series
> when we see real "other future users"

The first reason behind this posting is that I actually have scheduler
patches depending on this infrastructure that I intend to send on the
list in the coming weeks. I would appreciate to keep the two postings
separated because:
   1. I'd like to avoid sending a patch-bomb to the task scheduler
      maintainers that also touches a number of different sub-systems.
      The purpose of those scheduler patches is to introduce some form
      of energy awareness inside the scheduler, and I'm trying to make
      sure this message won't be lost in the middle of too many
      infrastructure patches.
   2. This infrastructure is not tied only to the aforementioned
      scheduler patches as it can also help another user, namely the
      transition to SCMI (which is currently being discussed on the list).

> otherwise we end up with the
> infamous static power scenario in 2-3 years down the row. If we
> currently do not have users of this IN MAINLINE KERNEL, then the series
> is not for upstream.

Again, this patchset is the first step of an upstreaming work, and as such,
and I hope it can make its way to getting merged.

Thank you very much,
Quentin
