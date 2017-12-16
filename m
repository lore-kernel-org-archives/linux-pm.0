From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v2 0/4] Utilization estimation (util_est) for FAIR tasks
Date: Sat, 16 Dec 2017 07:37:52 +0100
Message-ID: <1513406272.7101.9.camel@gmx.de>
References: <20171205171018.9203-1-patrick.bellasi@arm.com>
         <1513187793.7297.26.camel@gmx.de> <20171215161309.GF19821@e110439-lin>
         <1513369387.11185.127.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:53131 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750730AbdLPGij (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 16 Dec 2017 01:38:39 -0500
In-Reply-To: <1513369387.11185.127.camel@gmx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On Fri, 2017-12-15 at 21:23 +0100, Mike Galbraith wrote:
> 
> Point: if you think it's OK to serialize these firefox threads, would
> you still think so if those were kernel threads instead?  Serializing
> your kernel is a clear fail, but unpinned kthreads can be stacked up
> just as effectively as those browser threads are, eat needless wakeup
> latency and pass it on.

FWIW, somewhat cheezy example of that below.

(later, /me returns to [apparently endless] squabble w. PELT/SIS;)

bonnie in nfs mount of own box competing with 7 hogs:
 ------------------------------------------------------------------------------------------------------------------------------------
  Task                  |   Runtime ms  | Switches | Average delay ms | Maximum delay ms | Sum     delay ms | Maximum delay at      |
 ------------------------------------------------------------------------------------------------------------------------------------
  kworker/3:0:29        |    630.078 ms |    89669 | avg:    0.011 ms | max:  102.340 ms | sum:  962.919 ms | max at:    310.501277 |
  kworker/3:1H:464      |   1179.868 ms |   101944 | avg:    0.005 ms | max:  102.232 ms | sum:  480.915 ms | max at:    310.501273 |
  kswapd0:78            |   2662.230 ms |     1661 | avg:    0.128 ms | max:   93.935 ms | sum:  213.258 ms | max at:    310.503419 |
  nfsd:2039             |   3257.143 ms |    78448 | avg:    0.112 ms | max:   86.039 ms | sum: 8795.767 ms | max at:    258.847140 |
  nfsd:2038             |   3185.730 ms |    76253 | avg:    0.113 ms | max:   78.348 ms | sum: 8580.676 ms | max at:    258.831370 |
  nfsd:2042             |   3256.554 ms |    81423 | avg:    0.110 ms | max:   74.941 ms | sum: 8929.015 ms | max at:    288.397203 |
  nfsd:2040             |   3314.826 ms |    80396 | avg:    0.105 ms | max:   51.039 ms | sum: 8471.816 ms | max at:    363.870078 |
  nfsd:2036             |   3058.867 ms |    70460 | avg:    0.115 ms | max:   44.629 ms | sum: 8092.319 ms | max at:    250.074253 |
  nfsd:2037             |   3113.592 ms |    74276 | avg:    0.115 ms | max:   43.294 ms | sum: 8556.110 ms | max at:    310.443722 |
  konsole:4013          |    402.509 ms |      894 | avg:    0.148 ms | max:   38.129 ms | sum:  132.050 ms | max at:    332.156495 |
  haveged:497           |     11.831 ms |     1224 | avg:    0.104 ms | max:   37.575 ms | sum:  127.706 ms | max at:    350.669645 |
  nfsd:2043             |   3316.033 ms |    78303 | avg:    0.115 ms | max:   36.511 ms | sum: 8995.138 ms | max at:    248.576108 |
  nfsd:2035             |   3064.108 ms |    67413 | avg:    0.115 ms | max:   28.221 ms | sum: 7746.306 ms | max at:    313.785682 |
  bash:7022             |      0.342 ms |        1 | avg:   22.959 ms | max:   22.959 ms | sum:   22.959 ms | max at:    262.258960 |
  kworker/u16:4:354     |   2073.383 ms |     1550 | avg:    0.050 ms | max:   21.203 ms | sum:   77.185 ms | max at:    332.220678 |
  kworker/4:3:6975      |   1189.868 ms |   115776 | avg:    0.018 ms | max:   20.856 ms | sum: 2071.894 ms | max at:    348.142757 |
  kworker/2:4:6981      |    335.895 ms |    26617 | avg:    0.023 ms | max:   20.726 ms | sum:  625.102 ms | max at:    248.522083 |
  bash:7021             |      0.517 ms |        2 | avg:   10.363 ms | max:   20.726 ms | sum:   20.727 ms | max at:    262.235708 |
  ksoftirqd/2:22        |     65.718 ms |      998 | avg:    0.138 ms | max:   19.072 ms | sum:  137.827 ms | max at:    332.221676 |
  kworker/7:3:6969      |    625.724 ms |    84153 | avg:    0.010 ms | max:   18.838 ms | sum:  876.603 ms | max at:    264.188983 |
  bonnie:6965           |  79637.998 ms |    35434 | avg:    0.007 ms | max:   18.719 ms | sum:  256.748 ms | max at:    331.299867 | 
