From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq_stats NULL deref on second system suspend
Date: Wed, 11 Sep 2013 16:15:31 +0530
Message-ID: <CAKohpomzQ8Yzk+OU0btQM6DGm4xsY1RR9uYFrZD3ZHO-bhrwKQ@mail.gmail.com>
References: <522E1FEF.6080803@wwwdotorg.org>
	<1775778.MeiRhuYy7o@vostro.rjw.lan>
	<522F86AD.6010603@wwwdotorg.org>
	<2521560.SfeNbV74nj@vostro.rjw.lan>
	<52304439.3030301@linux.vnet.ibm.com>
	<CAKohpokTVzikxunqSdUYmLjTOkfhWFJ=N4TTa4rdbj2euCFY-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpokTVzikxunqSdUYmLjTOkfhWFJ=N4TTa4rdbj2euCFY-g@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Stephen Warren <swarren@wwwdotorg.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 11 September 2013 16:14, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> But I would have solved it differently :)
>
> We don't really need to call update_policy_cpu() again and again
> as we don't really need to update policy->cpu...
>
> Rather it would be better to just move following inside
> cpufreq_policy_alloc():

Half written mail sent :(

What about moving following to cpufreq_policy_alloc():

policy->cpu = cpu;

??
