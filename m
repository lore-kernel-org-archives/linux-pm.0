From: Andreas Herrmann <aherrmann@suse.com>
Subject: Re: [PATCH 1/1] cpufreq: pcc-cpufreq: Re-introduce deadband effect
 to reduce number of frequency changes
Date: Wed, 14 Sep 2016 16:56:43 +0200
Message-ID: <20160914145643.GA19982@suselix.suse.de>
References: <20160819121814.GA17296@suselix.suse.de>
 <20160819122101.GB17296@suselix.suse.de>
 <20160829060153.GA5094@vireshk-i7>
 <20160901132140.GA10183@suselix.suse.de>
 <20160907050201.GK27345@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:54861 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756126AbcINO5U (ORCPT
        <rfc822;groupwise-linux-pm@vger.kernel.org:0:0>);
        Wed, 14 Sep 2016 10:57:20 -0400
Content-Disposition: inline
In-Reply-To: <20160907050201.GK27345@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stratos Karafotis <stratosk@semaphore.gr>, Thomas Renninger <trenn@suse.com>

On Wed, Sep 07, 2016 at 10:32:01AM +0530, Viresh Kumar wrote:
> On 01-09-16, 15:21, Andreas Herrmann wrote:

  ---8<---

> > I started with the value return as "nominal latency" for PCC.  This
> > was 300000 ns on the test system and made things worse.  I've tested
> > other values as well unitl I've found a local optimium at 45000ns but
> > performance was lower in comparison to when I've applied my hack.
> 
> Can you try to use kernel tracer (ftrace) and see how the frequencies
> are getting changed and at what frequency.

Below is some trace data. I hope it is of some help.

(A) - sampling 10s period when system is idle
(B) - sampling 10s period when system partially loaded (kernel
      compilation using 2 jobs)

(1) 4.8-rc5
(2) 4.8-rc5 with my patch (reintro of deadband effect within
    pcc-cpufreq)
(3) 4.8-rc5 with reversal of 6393d6a102 (cpufreq: ondemand: Eliminate
    the deadband effect)

Let me know whether you are looking for other trace data wrt this
issue.


Thanks,

Andreas

---

(A)-(1)

 # Total Lost Samples: 0
 # Samples: 41  of event 'power:cpu_frequency'
 # Event count (approx.): 41
 # Overhead  Command       Shared Object     Symbol                       
 # ........  ............  ................  .............................
     39.02%  kworker/14:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
     29.27%  kworker/0:0   [kernel.vmlinux]  [k] cpufreq_notify_transition
     19.51%  kworker/10:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
      7.32%  kworker/5:2   [kernel.vmlinux]  [k] cpufreq_notify_transition
      2.44%  kworker/23:2  [kernel.vmlinux]  [k] cpufreq_notify_transition
      2.44%  kworker/40:1  [kernel.vmlinux]  [k] cpufreq_notify_transition

(A)-(2)

 # Total Lost Samples: 0
 # Samples: 6  of event 'power:cpu_frequency'
 # Event count (approx.): 6
 # Overhead  Command       Shared Object     Symbol                       
 # ........  ............  ................  .............................
     33.33%  kworker/1:2   [kernel.vmlinux]  [k] cpufreq_notify_transition
     16.67%  kworker/16:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
     16.67%  kworker/22:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
     16.67%  kworker/26:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
     16.67%  kworker/33:1  [kernel.vmlinux]  [k] cpufreq_notify_transition

(A)-(3)

 # Total Lost Samples: 0
 # Samples: 7  of event 'power:cpu_frequency'
 # Event count (approx.): 7
 # Overhead  Command       Shared Object     Symbol                       
 # ........  ............  ................  .............................
     28.57%  kworker/58:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
     14.29%  kworker/19:2  [kernel.vmlinux]  [k] cpufreq_notify_transition
     14.29%  kworker/20:2  [kernel.vmlinux]  [k] cpufreq_notify_transition
     14.29%  kworker/22:2  [kernel.vmlinux]  [k] cpufreq_notify_transition
     14.29%  kworker/23:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
     14.29%  kworker/35:1  [kernel.vmlinux]  [k] cpufreq_notify_transition

---

(B)-(1)

 # Total Lost Samples: 0
 # Samples: 2K of event 'power:cpu_frequency'
 # Event count (approx.): 2382
 # Overhead  Command       Shared Object     Symbol                       
 # ........  ............  ................  .............................
      5.75%  kworker/0:0   [kernel.vmlinux]  [k] cpufreq_notify_transition
      4.16%  kworker/12:2  [kernel.vmlinux]  [k] cpufreq_notify_transition
      3.11%  kworker/17:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
      2.94%  kworker/2:1   [kernel.vmlinux]  [k] cpufreq_notify_transition
      2.73%  kworker/19:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
      ...

(B)-(2)

 # Total Lost Samples: 0
 # Samples: 320  of event 'power:cpu_frequency'
 # Event count (approx.): 320
 # Overhead  Command       Shared Object     Symbol                       
 # ........  ............  ................  .............................
      4.69%  kworker/56:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
      4.06%  kworker/12:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
      4.06%  kworker/28:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
      4.06%  kworker/6:2   [kernel.vmlinux]  [k] cpufreq_notify_transition
      3.75%  kworker/32:2  [kernel.vmlinux]  [k] cpufreq_notify_transition
      ...

(B)-(3)

 # Total Lost Samples: 0
 # Samples: 333  of event 'power:cpu_frequency'
 # Event count (approx.): 333
 # Overhead  Command       Shared Object     Symbol                       
 # ........  ............  ................  .............................
      4.80%  kworker/51:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
      4.50%  kworker/39:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
      4.20%  kworker/47:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
      3.90%  kworker/59:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
      3.90%  kworker/7:2   [kernel.vmlinux]  [k] cpufreq_notify_transition
      ...

---

With (1) pcc-cpufreq tries to set pretty much every frequency even if
the system is idle, e.g. here is the start of (perf script output)
from (A)-(1):

     kworker/5:2   904 [005]   255.778343: power:cpu_frequency: state=1216000 cpu_id=5
     kworker/5:2   904 [005]   255.794382: power:cpu_frequency: state=1264000 cpu_id=5
     kworker/5:2   904 [005]   256.102400: power:cpu_frequency: state=1200000 cpu_id=5
    kworker/10:1   171 [010]   258.010362: power:cpu_frequency: state=2224000 cpu_id=10
    kworker/10:1   171 [010]   258.026366: power:cpu_frequency: state=1264000 cpu_id=10
    kworker/10:1   171 [010]   258.594514: power:cpu_frequency: state=1200000 cpu_id=10
    kworker/10:1   171 [010]   258.618417: power:cpu_frequency: state=1232000 cpu_id=10
    kworker/10:1   171 [010]   258.634409: power:cpu_frequency: state=1264000 cpu_id=10
    kworker/10:1   171 [010]   258.674467: power:cpu_frequency: state=1200000 cpu_id=10
    kworker/10:1   171 [010]   258.730486: power:cpu_frequency: state=1216000 cpu_id=10
    kworker/40:1   388 [040]   258.730999: power:cpu_frequency: state=1200000 cpu_id=40
    kworker/23:2   775 [023]   258.731504: power:cpu_frequency: state=1200000 cpu_id=23
    kworker/14:1   178 [014]   258.732013: power:cpu_frequency: state=1216000 cpu_id=14
    kworker/10:1   171 [010]   258.906434: power:cpu_frequency: state=1200000 cpu_id=10
    kworker/14:1   178 [014]   258.970500: power:cpu_frequency: state=1200000 cpu_id=14
    kworker/14:1   178 [014]   258.998440: power:cpu_frequency: state=1232000 cpu_id=14
    kworker/14:1   178 [014]   259.034490: power:cpu_frequency: state=1200000 cpu_id=14
    kworker/14:1   178 [014]   259.095089: power:cpu_frequency: state=1216000 cpu_id=14
    kworker/14:1   178 [014]   259.270470: power:cpu_frequency: state=1200000 cpu_id=14
    ...
