From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/2][UPDATE] PM / OPP: add non-OF versions of
 dev_pm_opp_{cpumask_,}remove_table
Date: Fri, 29 Apr 2016 15:02:13 +0530
Message-ID: <20160429093213.GA2927@vireshk-i7>
References: <1461863237-12928-1-git-send-email-sudeep.holla@arm.com>
 <1461921756-15109-1-git-send-email-sudeep.holla@arm.com>
 <20160429092825.GA17472@vireshk-i7>
 <572329DF.2060209@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <572329DF.2060209@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 29-04-16, 10:31, Sudeep Holla wrote:
> 
> 
> On 29/04/16 10:28, Viresh Kumar wrote:
> >This isn't V2, but V3
> >
> >On 29-04-16, 10:22, Sudeep Holla wrote:
> >>Functions dev_pm_opp_of_{cpumask_,}remove_table removes/frees all the
> >>static OPP entries associated with the device and/or all cpus(in case
> >>of cpumask) that are created from DT.
> >>
> >>However the OPP entries are populated reading from the firmware or some
> >>different method using dev_pm_opp_add are marked dynamic and can't be
> >>removed using above functions.
> >>
> >>This patch adds non DT/OF versions of dev_pm_opp_{cpumask_,}remove_table
> >>to support the above mentioned usecase.
> >>
> >>This is in preparation to make use of the same in scpi-cpufreq.c
> >>
> >>Cc: Viresh Kumar <vireshk@kernel.org>
> >>Cc: Nishanth Menon <nm@ti.com>
> >>CC: Stephen Boyd <sboyd@codeaurora.org>
> >>Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >>Cc: linux-pm@vger.kernel.org
> >>Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >>---
> >>  drivers/base/power/opp/core.c | 56 ++++++++++++++++++++++++++++++----------
> >>  drivers/base/power/opp/cpu.c  | 59 ++++++++++++++++++++++++++++++++-----------
> >>  include/linux/pm_opp.h        | 10 ++++++++
> >>  3 files changed, 96 insertions(+), 29 deletions(-)
> >>
> >>v1->v2:
> >>	- Instead of renaming OF versions, created non-OF versions of
> >>	  dev_pm_opp_{cpumask_,}remove_table as suggested by Viresh
> >>
> >
> >You should have added v2->v3 here
> >
> 
> No, thought I will post v3 of both the patches with your ACK so that
> it's easy for Rafael to pick up if he has no comments :)

Whatever you do, this was v3 unquestionably.

-- 
viresh
