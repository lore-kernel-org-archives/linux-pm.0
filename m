From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: qoriq: optimize the CPU frequency switching time
Date: Thu, 4 Jun 2015 12:06:36 +0530
Message-ID: <20150604063636.GH11325@linux>
References: <1433399142-18324-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433399142-18324-1-git-send-email-Yuantian.Tang@freescale.com>
Sender: cpufreq-owner@vger.kernel.org
To: Yuantian.Tang@freescale.com
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

On 04-06-15, 14:25, Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <Yuantian.Tang@freescale.com>
> 
> Each time the CPU switches its frequency, the clock nodes in
> DTS are walked through to find proper clock source. This is
> very time-consuming, for example, it is up to 500+ us on T4240.
> Besides, switching time varies from clock to clock.
> To optimize this, each input clock of CPU is buffered, so that
> it can be picked up instantly when needed.
> 
> Since for each CPU each input clock is stored in a pointer
> which takes 4 or 8 bytes memory and normally there are several
> input clocks per CPU, that will not take much memory as well.

Not sure how it got included in this form in the first place. :)

> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
>  drivers/cpufreq/qoriq-cpufreq.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
