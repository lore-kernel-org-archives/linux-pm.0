From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even
 when kthread kicked
Date: Mon, 21 May 2018 11:57:51 +0200
Message-ID: <20180521095751.GA11235@localhost.localdomain>
References: <20180518185501.173552-1-joel@joelfernandes.org>
 <20180521051424.mljwmisvrvi6yyc4@vireshk-i7>
 <CAJZ5v0jbJ3HfLyP6VZ2PuG0q1n=faX3G98ruwK-o1ro+gv7B9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jbJ3HfLyP6VZ2PuG0q1n=faX3G98ruwK-o1ro+gv7B9w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Joel Fernandes (Google.)" <joelaf@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>, Claudio Scordino <claudio@evidence.eu.com>, kernel-team@android.com, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 21/05/18 10:29, Rafael J. Wysocki wrote:
> On Mon, May 21, 2018 at 7:14 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 18-05-18, 11:55, Joel Fernandes (Google.) wrote:
> >> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> >>
> >> Currently there is a chance of a schedutil cpufreq update request to be
> >> dropped if there is a pending update request. This pending request can
> >> be delayed if there is a scheduling delay of the irq_work and the wake
> >> up of the schedutil governor kthread.
> >>
> >> A very bad scenario is when a schedutil request was already just made,
> >> such as to reduce the CPU frequency, then a newer request to increase
> >> CPU frequency (even sched deadline urgent frequency increase requests)
> >> can be dropped, even though the rate limits suggest that its Ok to
> >> process a request. This is because of the way the work_in_progress flag
> >> is used.
> >>
> >> This patch improves the situation by allowing new requests to happen
> >> even though the old one is still being processed. Note that in this
> >> approach, if an irq_work was already issued, we just update next_freq
> >> and don't bother to queue another request so there's no extra work being
> >> done to make this happen.
> >
> > Now that this isn't an RFC anymore, you shouldn't have added below
> > paragraph here. It could go to the comments section though.
> >
> >> I had brought up this issue at the OSPM conference and Claudio had a
> >> discussion RFC with an alternate approach [1]. I prefer the approach as
> >> done in the patch below since it doesn't need any new flags and doesn't
> >> cause any other extra overhead.
> >>
> >> [1] https://patchwork.kernel.org/patch/10384261/
> >>
> >> LGTMed-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> LGTMed-by: Juri Lelli <juri.lelli@redhat.com>
> >
> > Looks like a Tag you just invented ? :)
> 
> Yeah.
> 
> The LGTM from Juri can be converned into an ACK silently IMO.  That

Sure! :)

Thanks,

- Juri
