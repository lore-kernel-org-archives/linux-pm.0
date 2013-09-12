From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq_stats NULL deref on second system suspend
Date: Thu, 12 Sep 2013 11:30:15 +0530
Message-ID: <CAKohpom5eNzn=7X1VUpdjRnfQ4L9Gk+icBvt0BOvAFeFj4Tk8A@mail.gmail.com>
References: <522E1FEF.6080803@wwwdotorg.org>
	<1775778.MeiRhuYy7o@vostro.rjw.lan>
	<522F86AD.6010603@wwwdotorg.org>
	<2521560.SfeNbV74nj@vostro.rjw.lan>
	<52304439.3030301@linux.vnet.ibm.com>
	<523094CD.3000506@wwwdotorg.org>
	<5230B078.3070306@linux.vnet.ibm.com>
	<5230B991.3040702@linux.vnet.ibm.com>
	<5230BE75.7040307@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5230BE75.7040307@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12 September 2013 00:33, Stephen Warren <swarren@wwwdotorg.org> wrote:
> For the record, I'm testing on a 2-CPU system, so I'm not sure whether
> your explanation applies; it talks about CPUs 2 and 3 whereas I only
> have CPUs 0 and 1, but perhaps your explanation applies equally to any
> pair of CPUs?

It does apply to your system as well.. We remove cpu 1 in suspend and so
try to nominate cpu 0 as policy->cpu, which it already is :)
