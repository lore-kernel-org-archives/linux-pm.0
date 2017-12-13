From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v2 0/4] Utilization estimation (util_est) for FAIR tasks
Date: Wed, 13 Dec 2017 18:56:33 +0100
Message-ID: <1513187793.7297.26.camel@gmx.de>
References: <20171205171018.9203-1-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:54846 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752434AbdLMR5g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Dec 2017 12:57:36 -0500
In-Reply-To: <20171205171018.9203-1-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On Tue, 2017-12-05 at 17:10 +0000, Patrick Bellasi wrote:
> This is a respin of:
>    https://lkml.org/lkml/2017/11/9/546
> which has been rebased on v4.15-rc2 to have util_est now working on top
> of the recent PeterZ's:
>    [PATCH -v2 00/18] sched/fair: A bit of a cgroup/PELT overhaul
> 
> The aim of this series is to improve some PELT behaviors to make it a
> better fit for the scheduling of tasks common in embedded mobile
> use-cases, without affecting other classes of workloads.

I thought perhaps this patch set would improve the below behavior, but
alas it does not.  That's 3 instances of firefox playing youtube clips
being shoved into a corner by hogs sitting on 7 of 8 runqueues.  PELT
serializes the threaded desktop, making that threading kinda pointless,
and CFS not all that fair.

 6569 root      20   0    4048    704    628 R 100.0 0.004   5:10.48 7 cpuhog                                                                                                                                                                
 6573 root      20   0    4048    712    636 R 100.0 0.004   5:07.47 5 cpuhog                                                                                                                                                                
 6581 root      20   0    4048    696    620 R 100.0 0.004   5:07.36 1 cpuhog                                                                                                                                                                
 6585 root      20   0    4048    812    736 R 100.0 0.005   5:08.14 4 cpuhog                                                                                                                                                                
 6589 root      20   0    4048    712    636 R 100.0 0.004   5:06.42 6 cpuhog                                                                                                                                                                
 6577 root      20   0    4048    720    644 R 99.80 0.005   5:06.52 3 cpuhog                                                                                                                                                                
 6593 root      20   0    4048    728    652 R 99.60 0.005   5:04.25 0 cpuhog                                                                                                                                                                
 6755 mikeg     20   0 2714788 885324 179196 S 19.96 5.544   2:14.36 2 Web Content                                                                                                                                                           
 6620 mikeg     20   0 2318348 312336 145044 S 8.383 1.956   0:51.51 2 firefox                                                                                                                                                               
 3190 root      20   0  323944  71704  42368 S 3.194 0.449   0:11.90 2 Xorg                                                                                                                                                                  
 3718 root      20   0 3009580  67112  49256 S 0.599 0.420   0:02.89 2 kwin_x11                                                                                                                                                              
 3761 root      20   0  769760  90740  62048 S 0.399 0.568   0:03.46 2 konsole                                                                                                                                                               
 3845 root       9 -11  791224  20132  14236 S 0.399 0.126   0:03.00 2 pulseaudio                                                                                                                                                            
 3722 root      20   0 3722308 172568  88088 S 0.200 1.081   0:04.35 2 plasmashel

 ------------------------------------------------------------------------------------------------------------------------------------
  Task                  |   Runtime ms  | Switches | Average delay ms | Maximum delay ms | Sum     delay ms | Maximum delay at      |
 ------------------------------------------------------------------------------------------------------------------------------------
  Web Content:6755      |   2864.862 ms |     7314 | avg:    0.299 ms | max:   40.374 ms | sum: 2189.472 ms | max at:    375.769240 |
  Compositor:6680       |   1889.847 ms |     4672 | avg:    0.531 ms | max:   29.092 ms | sum: 2478.559 ms | max at:    375.759405 |
  MediaPl~back #3:(13)  |   3269.777 ms |     7853 | avg:    0.218 ms | max:   19.451 ms | sum: 1711.635 ms | max at:    391.123970 |
  MediaPl~back #4:(10)  |   1472.986 ms |     8189 | avg:    0.236 ms | max:   18.653 ms | sum: 1933.886 ms | max at:    376.124211 |
  MediaPl~back #1:(9)   |    601.788 ms |     6598 | avg:    0.247 ms | max:   17.823 ms | sum: 1627.852 ms | max at:    401.122567 |
  firefox:6620          |    303.181 ms |     6232 | avg:    0.111 ms | max:   15.602 ms | sum:  691.865 ms | max at:    385.078558 |
  Socket Thread:6639    |    667.537 ms |     4806 | avg:    0.069 ms | max:   12.638 ms | sum:  329.387 ms | max at:    380.827323 |
  MediaPD~oder #1:6835  |    154.737 ms |     1592 | avg:    0.700 ms | max:   10.139 ms | sum: 1113.688 ms | max at:    392.575370 |
  MediaTimer #1:6828    |     42.660 ms |     5250 | avg:    0.575 ms | max:    9.845 ms | sum: 3018.994 ms | max at:    380.823677 |
  MediaPD~oder #2:6840  |    150.822 ms |     1583 | avg:    0.703 ms | max:    9.639 ms | sum: 1112.962 ms | max at:    380.823741 |
...
