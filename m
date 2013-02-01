From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: Remove unnecessary use of policy->shared_type
Date: Fri, 1 Feb 2013 13:32:47 +0530
Message-ID: <CAKohpomxi91kXR+th2BbruKigmLPmrDQf1s_Mf11C3Bs53aB3A@mail.gmail.com>
References: <1bf82454ab1f16b13212548d7c9605067c8b7a0d.1359700705.git.viresh.kumar@linaro.org>
	<902bed453159832925df76e24806f3b919fdfc74.1359700706.git.viresh.kumar@linaro.org>
	<510B6510.6060608@ti.com>
	<CAKohponEsSrwLWbi4WJ19i8XkzEiL0De2ShLePBdygunmGEo5g@mail.gmail.com>
	<510B6FC5.8030309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <510B6FC5.8030309@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linaro-dev@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, rjw@sisk.pl, Steve.Bannister@arm.com, Stephen Warren <swarren@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On 1 February 2013 13:03, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> I am not talking about just notifiers. This is for external users who
> has subscribed for notifiers. The point is whether the core CPUFReq
> gets updated without that flag for all affected CPU.

Yes, its safe. Follow this thread, yesterday i explained this to Tomasz Figa:

http://www.spinics.net/lists/arm-kernel/msg221629.html
