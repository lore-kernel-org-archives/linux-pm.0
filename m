From: Juri Lelli <Juri.Lelli@arm.com>
Subject: Re: [PATCH] cpufreq: schedutil: Update last_update from
 sugov_set_iowait_boost()
Date: Tue, 18 Jul 2017 12:35:52 +0100
Message-ID: <20170718113552.v7fzhghp6oxwfoq4@e106622-lin>
References: <4927469221fa6b2ea7efffb2da923dac930ab313.1500353473.git.viresh.kumar@linaro.org>
 <20170718112025.iujrikdrf2sechtp@e106622-lin>
 <20170718112550.GZ352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170718112550.GZ352@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, joelaf@google.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 18/07/17 16:55, Viresh Kumar wrote:
> On 18-07-17, 12:20, Juri Lelli wrote:
> > Hi Viresh,
> > 
> > On 18/07/17 10:24, Viresh Kumar wrote:

[...]

> > 
> > It actually belongs here, IMHO. We update other fields (util, max,
> > flags)
> 
> Yeah, because they have bigger roles and aren't specific to iowait
> boost.
> 
> > before looking at iowait. Why hiding the time update into a
> > function dealing with only one of such fields?
> 
> But last_update is very much specific to iowait_boost only and so it
> should be updated from sugov_set_iowait_boost() IMHO.
> 

Huh, I see you point. However, I'm using it also to deal with stale CFS
util values in my patches [1]. Sure, not mainline yet, but I guess I'll
have to sort of revert your proposed change for my next version. Or
think of a better idea. :)

Thanks,

- Juri

[1] http://marc.info/?l=linux-kernel&m=149924526528298&w=2
