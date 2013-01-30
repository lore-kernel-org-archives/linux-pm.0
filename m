From: Nathan Zimmer <nzimmer@sgi.com>
Subject: cpufreq: cpufreq_driver_lock is quite hot on 512p systems
Date: Wed, 30 Jan 2013 12:07:32 -0600
Message-ID: <20130130180731.GA9449@gulag1.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
Sender: cpufreq-owner@vger.kernel.org
To: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org


I am noticing the cpufreq_driver_lock is quite hot.
Currently on an idle 512 system perf shows me most of the system time is 
spent on this lock.

-  84.18%  [kernel]                 [k] _raw_spin_lock_irqsave
   - _raw_spin_lock_irqsave
      - 99.97% __cpufreq_cpu_get
           cpufreq_cpu_get
           __cpufreq_driver_getavg
           dbs_check_cpu
           od_dbs_timer
           process_one_work
           worker_thread
           kthread
           ret_from_fork
 
The data this lock protects is used in a read mostly situation.
While exprimenting I found turning the lock to a rwlock fixed the problem.
It seems like this might be amenable to using the RCU.

Any other ideas on how to properly resolve the issue?

Thanks,
Nate

