From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Wed, 22 Nov 2017 07:34:10 -0800
Message-ID: <20171122153407.GA24699@localhost.localdomain>
References: <20171116234422.GA6141@localhost.localdomain>
 <878tf5tbfj.fsf@e105922-lin.cambridge.arm.com>
 <35d3751d-f28d-38c2-02b2-c9980f11c52e@arm.com>
 <cab738f4-dbbf-e5d8-af51-14bc3219b53e@linaro.org>
 <5A144CB3.50806@gmail.com>
 <CAKfTPtBBSxV+weYf-9yTf9azc78--8a8x8wNad3OGCYfvEJ4qw@mail.gmail.com>
 <20171121165703.GA2499@localhost.localdomain>
 <20171121180006.GA26638@localhost>
 <20171121181222.GA4075@localhost.localdomain>
 <a9f9e968-c93f-4f84-453c-03914263ac04@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a9f9e968-c93f-4f84-453c-03914263ac04@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Javi Merino <javi.merino@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Lukasz Luba <llu.ker.dev@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 22, 2017 at 10:59:21AM +0000, Sudeep Holla wrote:
> (sorry for chiming in quite late)
> 
> On 21/11/17 18:12, Eduardo Valentin wrote:
> > On Tue, Nov 21, 2017 at 06:00:07PM +0000, Javi Merino wrote:
> >> Hi,
> >>
> >> On Tue, Nov 21, 2017 at 08:57:06AM -0800, Eduardo Valentin wrote:
> >>
> 
> [...]
> 
> >>
> >> In a nutshell, mainline does not want platform specific code, but we
> >> haven't figured out how to calculate static power without platform
> >> specific code.>
> > To, that is still fine to have it as a callback, as long as you have at
> > least one user! I still do not understand why Juno static power cannot
> > go as platform code that register the callback to implement the static
> > power model.
> > 
> 
> 1. It was proved not so useful(anyone can prove otherwise ?)

Can anyone prove it does not have static power?

> 2. I am told static power is negligible compared to dynamic power with
>    new fab processes.

I am told quantum computer is out there :-), does it mean we should drop the
maintenance of everything else?


> 3. It's very hard to even test IPA on Juno as it doesn't reach the
>    required critical temperature easily. So as Juno platform maintainer
>    I want a test case to test regression before we merge anything.
> 
> IMO, if the $subject code is expected to be used on Juno, then my answer
> is no if one can't test it reliably and also prove that static power
> really matters on Juno. So far, I have heard both the above is not
> possible. So please delete the code if Juno is the only user in
> short and mid term. We can get the code back if we find any users in
> longer term.

Yeah, the fact that Juno takes time to reach crit temperature does not
necessarily imply it does not have static power consumption, or that its
static power consumption is negligible. Now, if you want to ignore it,
because it is not the best example to show usefulness of IPA, that is a
different story.

Eduardo

> 
> -- 
> Regards,
> Sudeep
