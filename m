From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 3/4] cpufreq: schedutil: Don't pass flags to
 sugov_set_iowait_boost()
Date: Wed, 13 Dec 2017 12:28:31 +0100
Message-ID: <20171213112831.GE30887@localhost.localdomain>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
 <4ec5562b1a87e146ebab11fb5dde1ca9c763a7fb.1513158452.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4ec5562b1a87e146ebab11fb5dde1ca9c763a7fb.1513158452.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, tkjos@android.com, joelaf@google.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 13/12/17 15:23, Viresh Kumar wrote:
> We are already passing sg_cpu as argument to sugov_set_iowait_boost()
> helper and the same can be used to retrieve the flags value. Get rid of
> the redundant argument.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Best,

- Juri
