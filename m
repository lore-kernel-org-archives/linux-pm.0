From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH v2 02/10] CPU hotplug: Provide APIs for "full" atomic
 readers to prevent CPU offline
Date: Wed, 5 Dec 2012 12:57:44 -0800
Message-ID: <20121205205744.GB27465@mtj.dyndns.org>
References: <20121205184041.3750.64945.stgit@srivatsabhat.in.ibm.com>
 <20121205184313.3750.17752.stgit@srivatsabhat.in.ibm.com>
 <50BF99FA.8060109@linux.vnet.ibm.com>
 <50BFAF27.9060203@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50BFAF27.9060203@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, oleg@redhat.com, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

On Thu, Dec 06, 2012 at 02:01:35AM +0530, Srivatsa S. Bhat wrote:
> Yes, that _sounds_ sufficient, but IMHO it won't be, in practice. The
> *number* of call-sites that you need to convert from preempt_disable/enable
> to get/put_online_cpus_atomic() won't be too many, however the *frequency*
> of usage of those call-sites can potentially be very high.

I don't think that will be the case and, even if it is, doing it this
way would make it difficult to tell.  The right thing to do is
replacing stop_machine with finer grained percpu locking first.
Refining it further should happen iff that isn't enough and there
isn't an simpler solution.  So, let's please do the simple conversion
first.

Thanks.

-- 
tejun
