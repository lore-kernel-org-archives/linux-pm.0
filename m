From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpuidle: New timer events oriented governor for tickless systems
Date: Tue, 18 Dec 2018 16:38:11 +0100
Message-ID: <CAJZ5v0jWzzVJ1ZsY588Z=y6r+-us7Jx3kYHUbRjTrZJRU=ywpA@mail.gmail.com>
References: <000001d496e6$e968c8f0$bc3a5ad0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000001d496e6$e968c8f0$bc3a5ad0$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Giovanni Gherdovich <ggherdovich@suse.cz>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, hu1.chen@intel.com, Quentin Perret <quentin.perret@arm.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Doug,

On Tue, Dec 18, 2018 at 4:32 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Rafael,
>
> Just typos, not already pointed out by Quentin:
>
> On 2018.12.18 03:09 Rafael J. Wysocki wrote:
>
> > The venerable menu governor does some thigns that are quite
>
> s/thigns/things
>
> > time frame in which no timer wakeups are possible (becuase it knows
>
> s/because/because
>
> > +obtain the the *sleep length*, which is the time until the closest timer event
>
> s/the the/the
>
> > +increased when when the given idle state "matches" the sleep length only and the
>
> s/when when/when

Thank you!
