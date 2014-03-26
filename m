From: Yuyang du <yuyang.du@intel.com>
Subject: [RFC II] Splitting scheduler into two halves
Date: Thu, 27 Mar 2014 02:37:21 +0800
Message-ID: <20140326183721.GC24116@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46033 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240AbaC0Cgp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 26 Mar 2014 22:36:45 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: morten.rasmussen@arm.com, arjan.van.de.ven@intel.com, len.brown@intel.com, rafael.j.wysocki@intel.com, alan.cox@intel.com

Hi all,

This is continued after the first RFC about splitting the scheduler. Still
work-in-progress, and call for feedback.

The question addressed here is how load balance should be changed. And I think
the question then goes to how to *reuse* common code as much as possible and
meanwhile be able to serve various objectives.

So these are the basic semantics needed in current load balance:

1. [ At balance point ] on this_cpu push task on that_cpu to [ third_cpu ]

Examples are fork/exec/wakeup. Task is determined by the balance point in
question. And that_cpu is determined by task.

2. [ At balance point ] on this_cpu pull [ task/tasks ] on [ that_cpu ] to
this_cpu

Examples are other idle/periodic/nohz balance, and active_load_balance in
ASYM_PACKING (pull first and then a push).

3. [ At balance point ] on this_cpu kick [ that_cpu/those_cpus ] to do [ what
] balance

Examples are nohz idle balance and active balance.

To make the above more general, we need to abstract more:

1. [ At balance point ] on this_cpu push task on that_cpu to [ third_cpu ] in
[ cpu_mask ]

2. [ At balance point ] on this_cpu [ do | skip ] pull [task/tasks ] on [
that_cpu ] in [ cpu_mask ] to this_cpu

3. [ At balance point ] on this_cpu kick [ that_cpu/those_cpus ] in [ cpu_mask
] to do nohz idle balance

So essentially, we give them choice or restrict the scope for them.

Then instead of an all-in-one load_balance class, we define pull or push
classes:

struct push_class:
int (*which_third_cpu);
struct cpumask * (*which_cpu_mask);

struct pull_class:
int (*skip);
int (*which_that_cpu);
struct task_struct * (*which_task);
struct cpumask* (*which_cpu_mask);

Last but not least, currently we configure domain by flags/parameters, how
about attaching push/pull classes directly to them as struct members? So those
classes are responsible specially for its riding domain's "well-being".

Thanks,
Yuyang
