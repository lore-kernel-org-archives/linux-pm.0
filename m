From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 17/18] cpufreq: add support for CPU DVFS based on SCMI
 message protocol
Date: Wed, 9 Aug 2017 15:36:51 +0530
Message-ID: <20170809100651.GA29383@vireshk-i7>
References: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
 <1501857104-11279-18-git-send-email-sudeep.holla@arm.com>
 <20170809041840.GH28857@vireshk-i7>
 <97497123-2c24-6297-2d12-4f407d101b66@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <97497123-2c24-6297-2d12-4f407d101b66@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: ALKML <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Roy Franz <roy.franz@cavium.com>, Harb Abdulhamid <harba@codeaurora.org>, Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd@arndb.de>, Loc Ho <lho@apm.com>, Alexey Klimov <alexey.klimov@arm.com>, Ryan Harkin <Ryan.Harkin@arm.com>, Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09-08-17, 10:59, Sudeep Holla wrote:
> On 09/08/17 05:18, Viresh Kumar wrote:

> > This stores the same handle pointer which is stored in the global variable
> > below. Right? Why keep a local variable here at all ?
> 
> Yes, you are right. Initially, started with just private pointers and
> then added global. I was thinking of calling devm_scmi_handle_get per
> policy to reflect the refcount correctly and drop global variable. Let
> me know what you think.

A refcount of 1 should be fine as well, i.e. For the cpufreq driver. Why would
SCMI care if we manage multiple policies here ? Unless it makes something within
SCMI core better.

> > This is something special which is used only when we are returning indexes and
> > I am not sure if this will have benefit here. I will rather return 0 here.
> > That's what other drivers are doing.
> 
> Indeed had 0 initially but changed as per Juri's suggestion.

Maybe he suggested doing that in the fast switch routine ? As that's the normal
protocol there. Though I have sent a patch today to propose using 0 there as
well (you cc'd).

> But is 0
> treated as failure and still running at current OPP ?

You have used that in the ->get() routine. So the OPP isn't changing, but we are
just trying to fetch it. cpufreq core doesn't do a lot with the value returned
from here, but at one place we break early if 0 is returned. And so all drivers
are returning that.

> and not 0KHz I assume.

Yeah, 0 KHz is dead CPU really :)

> > I suppose any CPU can change the frequency of any other CPU here, right? You
> > must set policy->dvfs_possible_from_any_cpu = true, from ->init() then.
> > 
> 
> OK, I missed to see something like that exists, will do.

Fairly recent stuff, present in pm/linux-next only.

> >> +	/*
> >> +	 * But we need OPP table to function so if it is not there let's
> >> +	 * give platform code chance to provide it for us.
> >> +	 */
> > 
> > How are we getting the OPPs? DT or non DT ?
> > 
> 
> Non DT :), from the firmware.

I would improve the above comment in that case to clearly say that OPPs are
added by the platform, lets wait for it.

-- 
viresh
