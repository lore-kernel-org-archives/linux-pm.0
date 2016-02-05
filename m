From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/7] cpufreq: governors: Fix ABBA lockups
Date: Fri, 5 Feb 2016 08:14:28 +0530
Message-ID: <20160205024428.GB3068@vireshk>
References: <20160203155428.GY3947@e106622-lin>
 <20160203161059.GH3469@vireshk>
 <20160203172009.GC12132@e106622-lin>
 <CAJZ5v0hdn6bM8J97O_GFrvi2O7LfuGv0oaZu7KH+cj1TJy+4CQ@mail.gmail.com>
 <CAMSceqiFG47G=mvzY8-tUL=sHdkkjVQaWzEA1aN+-ym0F_n6Gw@mail.gmail.com>
 <CAJZ5v0hbhoS+1AaU12SFxz=r1-TOWq10yJ+ST7mVWcUubTbxFw@mail.gmail.com>
 <20160204110907.GE3469@vireshk>
 <56B38DC8.8060606@codeaurora.org>
 <56B38E14.5060705@codeaurora.org>
 <CAJZ5v0hG2CickrbnTn8qJdFHJZ4cuZg1nxJ=8OXN8YFuw=qSFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hG2CickrbnTn8qJdFHJZ4cuZg1nxJ=8OXN8YFuw=qSFQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saravana Kannan <skannan@codeaurora.org>, Shilpa Bhat <shilpabhatppc@gmail.com>, Juri Lelli <juri.lelli@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 04-02-16, 19:18, Rafael J. Wysocki wrote:
> On Thu, Feb 4, 2016 at 6:44 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
> > On 02/04/2016 09:43 AM, Saravana Kannan wrote:

> >> No no no no! Let's not open up this can of worms of queuing up the work
> >> to handle a write to a sysfs file. It *MIGHT* work for this specific
> >> tunable (I haven't bothered to analyze), but this makes it impossible to
> >> return a useful/proper error value.
> >
> >
> > Sent too soon. Not only that, but it can also cause the writes to the sysfs
> > files to get processed in a different order and I don't know what other
> > issues/races THAT will open up.
> 
> Well, I don't like this too.

I expected similar responses only, so no surprises for me :)

Though there are few things I would like to tell here:
- There wouldn't be any race for updating the file, as that is done
  directly from store_sampling_rate(). It updates the *real* file we
  wanted to.

- What's offloaded to the work-handler is something very special about
  ondemand governor and sampling rate. The same is not done for
  conservative governor as well, don't know why though.

- After updating the sampling rate, we assess if we need to reschedule
  the timers/workqueue to a different time for better efficiency. I
  don't think there can be a race there and it can be safely done in a
  work..

> I actually do have an idea about how to fix these deadlocks, but it is
> on top of my cleanup series.

I would like to hear that, if you can, to save your time. I have tried
so many different ways of fixing this yesterday and found issue
everywhere :(

-- 
viresh
