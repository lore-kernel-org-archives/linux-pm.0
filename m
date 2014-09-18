From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/2] sched: let the scheduler see CPU idle states
Date: Fri, 19 Sep 2014 01:15:44 +0200
Message-ID: <20140918231544.GN2848@worktop.localdomain>
References: <1409844730-12273-1-git-send-email-nicolas.pitre@linaro.org>
 <1409844730-12273-2-git-send-email-nicolas.pitre@linaro.org>
 <20140918173733.GQ4723@linux.vnet.ibm.com>
 <20140918173925.GA7337@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140918173925.GA7337@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Ingo Molnar <mingo@redhat.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 18, 2014 at 10:39:25AM -0700, Paul E. McKenney wrote:
> On Thu, Sep 18, 2014 at 10:37:33AM -0700, Paul E. McKenney wrote:

> > A stop_cpus() will force a context switch on all CPUs, though it is
> > a rather big hammer.
> 
> And I was reminded by the very next email that kick_all_cpus_sync() is
> another possibility -- it forces an interrupt on all online CPUs, idle
> or not.

I actually have a patch
http://lkml.kernel.org/r/1409815075-4180-2-git-send-email-chuansheng.liu@intel.com
that changes that, because apparently there are idle loops that don't
actually exit on interrupt :-)

But yes, something like the wake_up_all_idle_cpus() should do.
