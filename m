From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 4/4] PM / devfreq: Handle monitor start/stop in the
 devfreq core
Date: Thu, 14 Feb 2019 16:19:47 -0800
Message-ID: <20190215001947.GF117604@google.com>
References: <20190214013042.254790-1-mka@chromium.org>
 <20190214013042.254790-5-mka@chromium.org>
 <CAGTfZH118diXgKHetWwiNMXHALxXqt=MSh9oVv+nt4-SJkzN2Q@mail.gmail.com>
 <CGME20190214192933epcas5p204c34010accb5e63480abd3ca34991eb@epcas5p2.samsung.com>
 <20190214192855.GD117604@google.com>
 <b28e763d-c3c9-0673-6216-f67561112b60@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b28e763d-c3c9-0673-6216-f67561112b60@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Chanwoo Choi <cwchoi00@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On Fri, Feb 15, 2019 at 08:42:30AM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> On 19. 2. 15. 오전 4:28, Matthias Kaehlcke wrote:
> > Hi Chanwoo,
> > 
> > On Thu, Feb 14, 2019 at 11:17:36PM +0900, Chanwoo Choi wrote:
> >> Hi Matthias,
> >>
> >> As I commented on the first patch, it is not possible to call some codes
> >> according to the intention of each governor between 'devfreq_moniotr_*()'
> >> and some codes which are executed before or after 'devfreq_moniotr_*()'
> >>
> >> For example, if some governor requires the following sequence,
> >> after this patch, it is not possible.
> >>
> >> case DEVFREQ_GOV_xxx:
> >>         /* execute some code before devfreq_monitor_xxx() */
> >>         devfreq_monitor_xxx()
> >>         /* execute some code after devfreq_monitor_xxx() */
> > 
> > As for the suspend/resume case I agree that the patch introduces this
> > limitation, but I'm not convinced that this is an actual problem.
> > 
> > For governor_start(): why can't the governor execute the code
> > before polling started, does it make any difference to the governor
> > that a work is scheduled?
> 
> The some governors might want to do something before starting
> the work and do something after work started. I think that
> the existing style is more flexible.

Could you provide a practical example that answers my question above:

"why can't the governor execute the code before polling started, does
it make any difference to the governor that a work is scheduled?"

> And,
> It has one more problem when changing the governor on the fly
> from simple_ondemand to other governors like performance,
> powersave and so on.
> 
> Even if other governors don't need to monitor the utilization,
> the work timer will be executed continually because the devfreq
> device has the polling_ms value. It is not necessary
> of the other governors such as performance, powersave.
> 
> It means that only specific governor like simple_ondemand
> have to call the devfreq_monitor_start() by itself
> instead of calling it on devfreq core.

yes, I noticed that too, it can be easily fixed with a flag in the
governor.

> > For governor_stop(): why would the governor require polling to be
> > active during stop? If it needs update_devfreq() to run (called by
> > devfreq_monitor()) it can call it directly, instead of waiting for the
> > monitor to run at some later time.
> 
> As I knew, if the current governors are performance/powersave/
> userspace, the monitoring is already stopped and not used.
> Because they don't need to handle the codes related to the work
> like queue_delayed_work(), cancel_delayed_work_sync().
>
> And,
> In case of the existing style for calling devfreq_monitor_*(),
> other governors like performance/powersave/userspace/passice
> don't need to call the devfreq_monitor_stop() because they
> didn't use the work timer.

As per above, the governor could have a flag indicating that it
doesn't need load monitoring.

I think it should be avoided to expect the governors to do the right
thing if certain actions are mandatory and common for all governors
(unless the feature in question is not used). It should be handled in
the core code, unless there are good reasons not to do this.

With thispatch set the amount of code remains essentially the same,
and no new code needs to be added for governors that don't do anything
special in start/stop/suspend/resume.

TBH I think probably the entire event handler multiplexing should go
away and be changed to a struct devfreq_ops with optional callbacks
for start, stop, suspend, resume and update interval. As far as I can
tell the multiplexing isn't needed and separate ops would result in
cleaner code, in both the devfreq core and the governors.

Cheers

Matthias
