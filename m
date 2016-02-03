From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/5] cpufreq: Don't drop rwsem before calling
 CPUFREQ_GOV_POLICY_EXIT
Date: Wed, 3 Feb 2016 18:39:28 +0530
Message-ID: <20160203130928.GD3469@vireshk>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
 <3d58d4f0bec5e8e941cf96e159c8c21e68956cad.1454410226.git.viresh.kumar@linaro.org>
 <CAJZ5v0hMp7XLP2gnAY=9qkj_yE9hDUwyzJ+4H1H6eadZuYDokw@mail.gmail.com>
 <20160203055126.GR31828@vireshk>
 <CAJZ5v0j5aXvyZ8kwHCwuABot14piN=tHiODBzqkERDtcUb_+9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j5aXvyZ8kwHCwuABot14piN=tHiODBzqkERDtcUb_+9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 03-02-16, 13:24, Rafael J. Wysocki wrote:
> I guess this was supposed to be "I am not ...".

Urg..

-- 
viresh
