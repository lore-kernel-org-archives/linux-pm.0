From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH V2 0/7] cpufreq: governors: Fix ABBA lockups
Date: Wed, 3 Feb 2016 17:20:09 +0000
Message-ID: <20160203172009.GC12132@e106622-lin>
References: <cover.1454507872.git.viresh.kumar@linaro.org>
 <20160203155428.GY3947@e106622-lin>
 <20160203161059.GH3469@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160203161059.GH3469@vireshk>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03/02/16 21:40, Viresh Kumar wrote:
> On 03-02-16, 15:54, Juri Lelli wrote:
> > Ouch, I've just got this executing -f basic on Juno. :(
> > It happens with the hotplug_1_by_1 test.
> > 

[...]

> 
> Urg..
> 
> I failed to understand it for now though. Please test only the first 4
> patches and leave the bottom three. AFAICT, this is caused by the 6th
> patch.
> 
> The first 4 are important for 4.5 and must be tested soonish.
> 

First 4 look ok from a testing viewpoint.

Best,

- Juri
