From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: cpufreq_stats NULL deref on second system suspend
Date: Wed, 11 Sep 2013 16:44:37 +0530
Message-ID: <5230509D.6040205@linux.vnet.ibm.com>
References: <522E1FEF.6080803@wwwdotorg.org> <1775778.MeiRhuYy7o@vostro.rjw.lan>	<522F86AD.6010603@wwwdotorg.org> <2521560.SfeNbV74nj@vostro.rjw.lan>	<52304439.3030301@linux.vnet.ibm.com> <CAKohpokTVzikxunqSdUYmLjTOkfhWFJ=N4TTa4rdbj2euCFY-g@mail.gmail.com> <CAKohpomzQ8Yzk+OU0btQM6DGm4xsY1RR9uYFrZD3ZHO-bhrwKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:47159 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017Ab3IKLSf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2013 07:18:35 -0400
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Wed, 11 Sep 2013 16:36:38 +0530
In-Reply-To: <CAKohpomzQ8Yzk+OU0btQM6DGm4xsY1RR9uYFrZD3ZHO-bhrwKQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Stephen Warren <swarren@wwwdotorg.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>

On 09/11/2013 04:15 PM, Viresh Kumar wrote:
> On 11 September 2013 16:14, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> But I would have solved it differently :)
>>
>> We don't really need to call update_policy_cpu() again and again
>> as we don't really need to update policy->cpu...
>>
>> Rather it would be better to just move following inside
>> cpufreq_policy_alloc():
> 
> Half written mail sent :(
> 
> What about moving following to cpufreq_policy_alloc():
> 
> policy->cpu = cpu;
> 
> ??
> 

Hmm? The problem is not about merely updating the policy->cpu field; the
main issue is that the existing code was not letting the cpufreq-stats
code know that we updated the policy->cpu under the hood. It is important
for cpufreq-stats to know this because it maintains the reference to its
stats structure by associating it with the policy->cpu. So if policy->cpu
changes under the hood, it loses track of its reference. So we need to
keep that code informed about changes to policy->cpu. Thus, we need to call
update_policy_cpu() in the CPU online path (during resume). I don't see
how we can skip that.

Regards,
Srivatsa S. Bhat

