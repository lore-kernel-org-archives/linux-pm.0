From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 11/19] cpufreq: assert policy->rwsem is held in
 __cpufreq_governor
Date: Tue, 2 Feb 2016 12:06:02 +0530
Message-ID: <20160202063602.GG31828@vireshk>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <20160112102025.GC1084@ubuntu>
 <56AC04E3.8090900@codeaurora.org>
 <1703921.2AHaiQoggk@vostro.rjw.lan>
 <20160201060943.GH13476@vireshk>
 <CAJZ5v0gzKkoKsbv_KG0qL-7=j4a3DU-nOTCG71fZcoumQ0UZUw@mail.gmail.com>
 <56AFBEE5.70501@codeaurora.org>
 <CAJZ5v0iTZqk-Rokiq_C0bmwYEy+mPxZCGS6MarEPFp=A=wuchg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iTZqk-Rokiq_C0bmwYEy+mPxZCGS6MarEPFp=A=wuchg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saravana Kannan <skannan@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On 01-02-16, 22:00, Rafael J. Wysocki wrote:
> I'm not sure what you mean by "the sysfs lock" here?  The policy rwsem
> or something else?

He perhaps referred to the s_active.lock that we see in traces.

-- 
viresh
