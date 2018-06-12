From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle injection
 framework
Date: Tue, 12 Jun 2018 16:46:29 +0200
Message-ID: <7bfb88b6-166b-ef4f-9a2f-03d122faba6b@linaro.org>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
 <20180612142647.GS12217@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612142647.GS12217@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Andrea Parri <andrea.parri@amarulasolutions.com>
List-Id: linux-pm@vger.kernel.org

On 12/06/2018 16:26, Peter Zijlstra wrote:
> On Tue, Jun 12, 2018 at 02:00:11PM +0200, Daniel Lezcano wrote:
>> +void idle_injection_stop(struct idle_injection_device *ii_dev)
>> +{
>> +	pr_debug("Stopping injecting idle cycles on CPUs '%*pbl'\n",
>> +		 cpumask_pr_args(ii_dev->cpumask));
>> +
>> +	idle_injection_set_duration(ii_dev, 0, 0);
>> +
>> +	wait_for_completion_interruptible(&ii_dev->stop_complete);
>> +}
> 
> interruptible?

Right, can be removed.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
