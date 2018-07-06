From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v4 03/12] PM: Introduce an Energy Model management
 framework
Date: Fri, 6 Jul 2018 12:03:53 +0200
Message-ID: <20180706100353.GU2476@hirez.programming.kicks-ass.net>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-4-quentin.perret@arm.com>
 <CAKfTPtCxt-O8uMOYgAjY7daujXwXyZQ-3BYe=DONL7R95T7nmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKfTPtCxt-O8uMOYgAjY7daujXwXyZQ-3BYe=DONL7R95T7nmQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Quentin Perret <quentin.perret@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, viresh kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com, "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.o
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 06, 2018 at 11:57:37AM +0200, Vincent Guittot wrote:
> 
> IIUC the formula above, you consider that all CPUs in a frequency
> domain has the same capacity. This sounds a reasonable assumption but
> it would be good to write that somewhere

Yes, I think there used to be a WARN and kill EM for that, but I cannot
seem to locate that in the current code.
