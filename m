From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2 10/12] sched/core: uclamp: use TG's clamps to restrict
 Task's clamps
Date: Tue, 24 Jul 2018 16:49:35 +0100
Message-ID: <20180724154935.GB3275@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-11-patrick.bellasi@arm.com>
 <CAJuCfpFnj2g3+ZpR4fP4yqfxs0zd=c-Zehr2XM7m_C+WdL9jNA@mail.gmail.com>
 <20180723154025.GF2683@e110439-lin>
 <CAJuCfpHJ=O1QVFZZ2dpaDDQe+dX1aGkzWdcd76c9zZpxw2fNtA@mail.gmail.com>
 <20180724095550.GA3162@e110439-lin>
 <CAJuCfpEUsq=LPZgz20jn79CwymQGgfif8j8fzurUDmEJ3G9q5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJuCfpEUsq=LPZgz20jn79CwymQGgfif8j8fzurUDmEJ3G9q5w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

On 24-Jul 08:28, Suren Baghdasaryan wrote:
> Hi Patrick. Thanks for the explanation and links. No more questions
> from me on this one :)

No problems at all!

The important question is instead: does it makes sense for you too?

I think the important bits are that we are all on the same page about
the end goals and features we like to have as well as the interface we use.
This last has to fits best our goals and features while still being
perfectly aligned with the frameworks we are integrating into... and
that's still under discussion with Tejun on PATCH 08/12.

Thanks again for your review!

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
