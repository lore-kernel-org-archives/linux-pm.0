From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: cpufreq_stats NULL deref on second system suspend
Date: Wed, 11 Sep 2013 13:03:17 -0600
Message-ID: <5230BE75.7040307@wwwdotorg.org>
References: <522E1FEF.6080803@wwwdotorg.org> <1775778.MeiRhuYy7o@vostro.rjw.lan> <522F86AD.6010603@wwwdotorg.org> <2521560.SfeNbV74nj@vostro.rjw.lan> <52304439.3030301@linux.vnet.ibm.com> <523094CD.3000506@wwwdotorg.org> <5230B078.3070306@linux.vnet.ibm.com> <5230B991.3040702@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <5230B991.3040702@linux.vnet.ibm.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 09/11/2013 12:42 PM, Srivatsa S. Bhat wrote:
...
> OK, I took a second look at the code, and I suspect that applying the
> second patch might help. So can you try by applying both the patches
> please[1][2]?
> 
...
> [1]. http://marc.info/?l=linux-kernel&m=137889516210816&w=2
> [2]. http://marc.info/?l=linux-kernel&m=137889800511940&w=2

Yes, with both of those patches applies, the problem is solved:-)

I was going to test the second patch originally, but it sounded like it
was more of a cleanup rather than a fix for my issue, so I didn't bother
when I found the problem wasn't solved by patch 1. Sorry!

For the record, I'm testing on a 2-CPU system, so I'm not sure whether
your explanation applies; it talks about CPUs 2 and 3 whereas I only
have CPUs 0 and 1, but perhaps your explanation applies equally to any
pair of CPUs?

For the record, here's the information you requested in the other email:

# cat /sys/devices/system/cpu/cpu*/cpufreq/related_cpus
0 1
0 1

