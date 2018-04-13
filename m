From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v2 2/6] sched: Introduce energy models of CPUs
Date: Fri, 13 Apr 2018 09:37:31 +0100
Message-ID: <20180413083730.GA3470@e108498-lin.cambridge.arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-3-dietmar.eggemann@arm.com>
 <20180413040253.GW7671@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180413040253.GW7671@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Friday 13 Apr 2018 at 09:32:53 (+0530), Viresh Kumar wrote:
[...]
> And for the whole OPP discussion, perhaps we should have another
> architecture specific callback which the scheduler can call to get a
> ready-made energy model with all the structures filled in. That way
> the OPP specific stuff will move to the architecture specific
> callback.

Yes, that's another possible solution indeed. Actually, it's already on
the list of ideas to be dicussed in OSPM ;-)

Thanks,
Quentin
