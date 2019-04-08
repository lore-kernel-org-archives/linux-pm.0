From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/5] cpufreq: Use QoS layer to manage freq-constraints
Date: Mon, 8 Apr 2019 16:16:38 +0530
Message-ID: <20190408104638.43ttxvxhwbp6ba2u@vireshk-i7>
References: <cover.1550748118.git.viresh.kumar@linaro.org>
 <2575955.AqKVkXLaMl@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2575955.AqKVkXLaMl@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org, juri.lelli@gmail.com, Qais.Yousef@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 21-02-19, 12:30, Rafael J. Wysocki wrote:
> On Thursday, February 21, 2019 12:29:26 PM CET Viresh Kumar wrote:
> > Hello,
> > 
> > This patchset attempts to manage CPU frequency constraints using the PM
> > QoS framework. It only does the basic stuff right now and moves the
> > userspace constraints to use the QoS infrastructure.
> > 
> > Todo:
> > - Migrate all users to the QoS framework and get rid of cpufreq specific
> >   notifiers.
> > - Make PM QoS learn about the relation of CPUs in a policy, so a single
> >   list of constraints is managed for all of them instead of per-cpu
> >   constraints.
> > 
> > V1->V2:
> > - The previous version introduced a completely new framework, this one
> >   moves to PM QoS instead.
> > - Lots of changes because of this.
> 
> Well, thanks for working on this, but I'm rather unlikely to look at it in
> detail before 5.1-rc1 is released.

Ping!

-- 
viresh
