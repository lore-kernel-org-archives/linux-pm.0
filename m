From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/7] sched/core: uclamp: add utilization clamping to the
 CPU controller
Date: Thu, 26 Apr 2018 11:58:45 -0700
Message-ID: <20180426185845.GO1911913@devbig577.frc2.facebook.com>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
 <20180409165615.2326-5-patrick.bellasi@arm.com>
 <20180409222417.GK3126663@devbig577.frc2.facebook.com>
 <20180410171612.GJ14248@e110439-lin>
 <20180410200514.GA793541@devbig577.frc2.facebook.com>
 <CAEi0qNmwT0h0R5GM0X71CzYyd_VmykxgrT0rPZgnGBw3pSQJNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEi0qNmwT0h0R5GM0X71CzYyd_VmykxgrT0rPZgnGBw3pSQJNQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joel.opensrc@gmail.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Todd Kjos <tkjos@google.com>
List-Id: linux-pm@vger.kernel.org

Hello, Joel.

On Sat, Apr 21, 2018 at 02:08:30PM -0700, Joel Fernandes wrote:
> Actually no, its not about overloading them. What's Patrick is
> defining here is a property/attribute. What that attribute is used for
> (the algorithms that use it) are a different topic. Like, it can be
> used by the frequency selection algorithms or the task placement
> algorithm. There are multiple algorithms that can use the property. To
> me, this part of the patch makes sense. Maybe it should really be
> called "task_size" or something, since that's what it really is.

I understand that the interface can encode certain intentions and then
there can be different strategies to implement that, but the two
things mentioned here seem fundamentally different to declare them to
be two different implementations of the same intention.

> > Yeah, I think we want to stick to that semantics.  That's what memory
> > controller does and it'd be really confusing to flip the directions on
> > different controllers.
> 
> What about the .high ? I think there was some confusion about how to
> define that for subgroups. It could perhaps be such that the .high of
> parent is the lower bound of the .high on child but then I'm not sure
> if that fits well with the delegation policies...

The basic rule is simple.  A child can never obtain more than its
ancestors.

Thanks.

-- 
tejun
