From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 4/4] PM / devfreq: Handle monitor start/stop in the
 devfreq core
Date: Fri, 15 Feb 2019 14:56:21 -0800
Message-ID: <20190215225621.GG117604@google.com>
References: <20190214013042.254790-1-mka@chromium.org>
 <20190214013042.254790-5-mka@chromium.org>
 <CAGTfZH118diXgKHetWwiNMXHALxXqt=MSh9oVv+nt4-SJkzN2Q@mail.gmail.com>
 <CGME20190214192933epcas5p204c34010accb5e63480abd3ca34991eb@epcas5p2.samsung.com>
 <20190214192855.GD117604@google.com>
 <b28e763d-c3c9-0673-6216-f67561112b60@samsung.com>
 <20190215001947.GF117604@google.com>
 <1671c5fa-5414-8a83-b372-99f7f057a2ac@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1671c5fa-5414-8a83-b372-99f7f057a2ac@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Chanwoo Choi <cwchoi00@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On Fri, Feb 15, 2019 at 09:33:05AM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> On 19. 2. 15. 오전 9:19, Matthias Kaehlcke wrote:
> > Hi Chanwoo,
> > 
> > On Fri, Feb 15, 2019 at 08:42:30AM +0900, Chanwoo Choi wrote:
> >> Hi Matthias,
> >>
> >> On 19. 2. 15. 오전 4:28, Matthias Kaehlcke wrote:
> >>> Hi Chanwoo,
> >>>
> >>> On Thu, Feb 14, 2019 at 11:17:36PM +0900, Chanwoo Choi wrote:
> >>>> Hi Matthias,
> >>>>
> >>>> As I commented on the first patch, it is not possible to call some codes
> >>>> according to the intention of each governor between 'devfreq_moniotr_*()'
> >>>> and some codes which are executed before or after 'devfreq_moniotr_*()'
> >>>>
> >>>> For example, if some governor requires the following sequence,
> >>>> after this patch, it is not possible.
> >>>>
> >>>> case DEVFREQ_GOV_xxx:
> >>>>         /* execute some code before devfreq_monitor_xxx() */
> >>>>         devfreq_monitor_xxx()
> >>>>         /* execute some code after devfreq_monitor_xxx() */
> >>>
> >>> As for the suspend/resume case I agree that the patch introduces this
> >>> limitation, but I'm not convinced that this is an actual problem.
> >>>
> >>> For governor_start(): why can't the governor execute the code
> >>> before polling started, does it make any difference to the governor
> >>> that a work is scheduled?
> >>
> >> The some governors might want to do something before starting
> >> the work and do something after work started. I think that
> >> the existing style is more flexible.
> > 
> > Could you provide a practical example that answers my question above:
> > 
> > "why can't the governor execute the code before polling started, does
> > it make any difference to the governor that a work is scheduled?"
> 
> Actually, as for now, I don't know the correct practice and now.
> I want to say that the existing style is more flexible for the
> new governor in the future.

If you try submitting 'flexible' code in other parts of the kernel
without users of this flexibility and no solid arguments why this
flexibility is needed it would most likely be rejected.

Unnecessary flexibility can be a burden, rather than an advantage.

> If there are no any special benefits I think we don't need to harm
> the flexibility.

There are multiple benefits, the following shortcomings of the current
approach are eliminated:

- it is error prone and allows governors to do the wrong thing, e.g.
  - start monitoring before the governor is fully ready
  - keep monitoring when the governor is partially 'stopped'
  - omit mandatory calls
- delegates tasks to the governors which are responsibility of the
  core
- code is harder to read
  - switch from common code to governor code and back
- unecessary boilerplate code in governors
- option to replace ->event_handler() with ->start(), ->stop(), etc,
  which is cleaner

I'm easily convinced if the flexibility is really needed. I'm not even
expecting a real world example, just be creative and make something
up that sounds reasonable.

start/resume()
{
	// prepare governor

	// start polling

=>	what needs to be done here that couldn't have been done
=>	before polling was started?
}

stop/suspend()
{
=>	what needs to be done here that couldn't be done after polling
=>	is stopped?

	// stop polling

	// 'unprepare' governor
}

> >> And,
> >> It has one more problem when changing the governor on the fly
> >> from simple_ondemand to other governors like performance,
> >> powersave and so on.
> >>
> >> Even if other governors don't need to monitor the utilization,
> >> the work timer will be executed continually because the devfreq
> >> device has the polling_ms value. It is not necessary
> >> of the other governors such as performance, powersave.
> >>
> >> It means that only specific governor like simple_ondemand
> >> have to call the devfreq_monitor_start() by itself
> >> instead of calling it on devfreq core.
> > 
> > yes, I noticed that too, it can be easily fixed with a flag in the
> > governor.
> 
> Right, If we add some codes like flag, it is easy.
> Actually, it is just difference how to support them.
> 
> I think that the existing style has not any problem and is not
> complicated to develop the new governor. If there are no
> some benefits, IMO, we better to keep the flexibility.
> It can give the flexibility to the developer of governor.

I listed several benefits, please comment on the specific items if you
disagree, instead of just saying there are no benefits.

OTOH so far we haven't seen an even hypothetical example that shows
that the flexibility *could* be needed.

And even if such a rare case that we currently can't imagine came up,
it could be easily addressed with notifiers, a standard mechanism in
the kernel to inform drivers about events they are interested in.

Cheers

Matthias
