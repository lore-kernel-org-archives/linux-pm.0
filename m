From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 09/19] cpufreq: fix warning for
 show_scaling_available_governors unlocked access to cpufreq_governor_list
Date: Wed, 13 Jan 2016 16:02:51 +0530
Message-ID: <20160113103251.GN6050@ubuntu>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-10-git-send-email-juri.lelli@arm.com>
 <20160112101315.GA1084@ubuntu>
 <20160113102536.GB18603@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160113102536.GB18603@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On 13-01-16, 10:25, Juri Lelli wrote:
> I couldn't really relate this comment with this patch or the backtrace.
> Can you please clarify why you are referring to switching to use
> cpufreq-dt here?

Yeah, sorry about that. One of your previous patches had backtrace
mentioning bL and so I wanted to mention that thing to you. But by
that time, I moved to the new patch and thought of just adding the
point before forgetting it completely.

-- 
viresh
