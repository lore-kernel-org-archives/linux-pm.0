From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Skip all governor-related actions for cpufreq_suspended set
Date: Fri, 08 Apr 2016 23:56:25 +0200
Message-ID: <8218019.txzPhLMNil@vostro.rjw.lan>
References: <2044559.GVlD7a2JcO@vostro.rjw.lan> <2346918.2NTGrKGAVB@vostro.rjw.lan> <20160408054414.GE9674@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160408054414.GE9674@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Friday, April 08, 2016 11:14:14 AM Viresh Kumar wrote:
> On 08-04-16, 00:05, Rafael J. Wysocki wrote:
> > On Thursday, April 07, 2016 05:35:03 PM Viresh Kumar wrote:
> 
> > > That's *ugly* and it works by chance, unless I am misreading it
> > > completely.
> > 
> > I'm assuming that what you mean by "ugly" here is "not really straightforward",
> > which I agree with,
> 
> Yeah.
> 
> > but then it is really disappointing to see comments like
> > that from you about the code that you helped to write.
> 
> I was just trying to say that this isn't how I feel it should be done.
> :(

Fair enough.

> > Moreover, runtime CPU offline *also* doesn't have to run the governor exit/init
> > for the same reason why the policy directory doesn't have to be removed on
> > CPU offline: it is just pointless to do that.  The governor has been stopped
> > already and it won't do anything more.  The only problem here is to prevent
> > governor tunable sysfs attributes from triggering actions in that state,
> > but that shouldn't be too difficult to arrange for.  If that's done,
> 
> Isn't that already guaranteed as userspace should have been frozen by
> by the time we reach cpufreq_suspend()?

For the "offline/online during suspend/resume" case it is guaranteed, but for
the "runtime offline/online" case it isn't.

I essentially would like those two cases to be as similar as reasonably
possible, if not identical.

Thanks,
Rafael
