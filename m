From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] Revert "cpufreq: schedutil: Don't restrict kthread to
 related_cpus unnecessarily"
Date: Tue, 8 May 2018 16:23:32 +0530
Message-ID: <20180508105332.rxphnwo4byr42gmy@vireshk-i7>
References: <20180508073340.13114-1-dietmar.eggemann@arm.com>
 <20180508082242.bre6sjfvefhz6xc3@vireshk-i7>
 <8cf21b1a-ca6e-fed7-43c5-94c66ff5986b@arm.com>
 <20180508094526.ajyjrwytguhv4xpe@vireshk-i7>
 <7922d081-0bfb-0e55-7caf-ec9fb5d7bab0@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7922d081-0bfb-0e55-7caf-ec9fb5d7bab0@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Pavan Kondeti <pkondeti@codeaurora.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Quentin Perret <quentin.perret@arm.com>
List-Id: linux-pm@vger.kernel.org

On 08-05-18, 12:36, Dietmar Eggemann wrote:
> That's true but where is the benefit by doing so? (Multiple) per-cluster or
> per-cpu frequency domains, why should the sugov kthread run on a foreign
> cpu?

I am not sure I know the answer, but I have a question which you can
answer :)

Is it possible for a CPU (which already has high priority deadline
activity going on) to be busy enough to be not able to run the
schedutil kthread for sometime ? That would be the only case I believe
where it would be better to let some other CPU go and change the
frequency for this one as we better run faster while we have the high
load going on.

-- 
viresh
