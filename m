From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point
 indicator
Date: Mon, 6 Aug 2018 12:02:13 +0100
Message-ID: <20180806110211.kvibet576unwaowl@queper01-lin>
References: <20180802161027.v2ctgscuc4uxbb7u@queper01-lin>
 <CAKfTPtDtaF9Qs4NWkKWUSr8Ryi-ScYNmPyacocPQUPxT00XAYg@mail.gmail.com>
 <20180802165924.7ywgoxj2jwftxycz@queper01-lin>
 <CAKfTPtDsG4FJy5xBO8+6pJzehEM668=SZ4yQ-szVTduofN3QZg@mail.gmail.com>
 <20180803081850.hj7bp5ognuywapmd@queper01-lin>
 <CAKfTPtDkJY=JYicZk8sM9_mJ-iq+Jwse0oVRbW=wpxXKKnEoeQ@mail.gmail.com>
 <20180803155547.sxlhxpmhwcoappit@queper01-lin>
 <CAKfTPtBT-p-Z0EneirfOTwUw=5jEeDGa+4_EE4ogi2Ht7GU9Bg@mail.gmail.com>
 <20180806094342.lonjz4g3lspcatcy@queper01-lin>
 <CAKfTPtBh2Z8Lc28avBOzOtz72eN-6vyuQZ1=5Wgbj4kJ=yn8FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKfTPtBh2Z8Lc28avBOzOtz72eN-6vyuQZ1=5Wgbj4kJ=yn8FA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, viresh kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com, "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Monday 06 Aug 2018 at 12:45:44 (+0200), Vincent Guittot wrote:
> On Mon, 6 Aug 2018 at 11:43, Quentin Perret <quentin.perret@arm.com> wrote:
> I would have preferred to have a full power policy for all task when
> EAS is in used by default and then see if there is any performance
> problem instead of letting some UC unclear but that's a personal
> opinion.

Understood. I'd say let's keep things simple for now unless there is a
consensus that this is must-have form the start.

> so IMO, the minimum is to add a comment in the code that describes
> this behavior for fork tasks so people will understand why EAS puts
> newly created task on not "EAS friendly" cpus when they will look at
> the code trying to understand the behavior

Agreed, that really needs to be documented. I'll add a comment somewhere
in v6.

Thanks,
Quentin
