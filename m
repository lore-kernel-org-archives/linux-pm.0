From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 0/5] cpufreq: Use QoS layer to manage freq-constraints
Date: Thu, 21 Feb 2019 12:30:47 +0100
Message-ID: <2575955.AqKVkXLaMl@aspire.rjw.lan>
References: <cover.1550748118.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1550748118.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org, juri.lelli@gmail.com, Qais.Yousef@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, February 21, 2019 12:29:26 PM CET Viresh Kumar wrote:
> Hello,
> 
> This patchset attempts to manage CPU frequency constraints using the PM
> QoS framework. It only does the basic stuff right now and moves the
> userspace constraints to use the QoS infrastructure.
> 
> Todo:
> - Migrate all users to the QoS framework and get rid of cpufreq specific
>   notifiers.
> - Make PM QoS learn about the relation of CPUs in a policy, so a single
>   list of constraints is managed for all of them instead of per-cpu
>   constraints.
> 
> V1->V2:
> - The previous version introduced a completely new framework, this one
>   moves to PM QoS instead.
> - Lots of changes because of this.

Well, thanks for working on this, but I'm rather unlikely to look at it in
detail before 5.1-rc1 is released.

Cheers,
Rafael
