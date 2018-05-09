From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] Revert "cpufreq: schedutil: Don't restrict kthread to
 related_cpus unnecessarily"
Date: Wed, 9 May 2018 10:25:04 +0530
Message-ID: <20180509045504.nmvrobtcdy7tfz7r@vireshk-i7>
References: <20180508073340.13114-1-dietmar.eggemann@arm.com>
 <20180508082242.bre6sjfvefhz6xc3@vireshk-i7>
 <8cf21b1a-ca6e-fed7-43c5-94c66ff5986b@arm.com>
 <20180508094526.ajyjrwytguhv4xpe@vireshk-i7>
 <20180508100227.GB3752@e108498-lin.cambridge.arm.com>
 <20180508103427.w2rq3vz3f66y4cxh@vireshk-i7>
 <CAJZ5v0iN0msbi=ad34nS8eVfGGS1UD-qUeHPeAvq=yW3-4HKCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iN0msbi=ad34nS8eVfGGS1UD-qUeHPeAvq=yW3-4HKCQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Pavan Kondeti <pkondeti@codeaurora.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, Patrick Bellasi <patrick.bellasi@arm.com>
List-Id: linux-pm@vger.kernel.org

On 08-05-18, 22:36, Rafael J. Wysocki wrote:
> Because that makes things more complex and harder to debug in general.
> 
> What's the exact reason why non-policy CPUs should ever run the sugov
> kthread for the given policy?

The only benefit was to let the scheduler run the kthread on the best
CPU (according to the scheduler), which may help reducing the delay in
running the kthread. But given the way deadline scheduler works, I
don't see a reason why this should be done anymore.

-- 
viresh
