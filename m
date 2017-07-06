From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH v1 0/8] SCHED_DEADLINE freq/cpu invariance and OPP
 selection
Date: Thu, 6 Jul 2017 17:08:22 +0100
Message-ID: <20170706160822.rl7cayn7ovzlncj6@e106622-lin>
References: <20170705085905.6558-1-juri.lelli@arm.com>
 <20170706115715.6154d823@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170706115715.6154d823@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com
List-Id: linux-pm@vger.kernel.org

On 06/07/17 11:57, Steven Rostedt wrote:
> On Wed,  5 Jul 2017 09:58:57 +0100
> Juri Lelli <juri.lelli@arm.com> wrote:
> 
> > Hi,
> > 
> > v1 of the RFC set implementing frequency/cpu invariance and OPP selection for
> 
> It would be nice if you specify what "OPP" stands for. A quick google
> search shows "Other Peoples Privates", which isn't the type of
> selection I would be looking for.
> 

Not something we could influence from the scheduler anyway. :)

Just to clarify, OPP in this context stands for "Operating Performance
Point": (frequency, voltage) tuple [1], used in this context as a
synonym of clock frequency.

I'll add in next version.

Thanks,

- Juri

[1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0024a/CHDGICAJ.html
