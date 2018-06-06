From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle
 injection framework
Date: Wed, 6 Jun 2018 14:05:39 +0200
Message-ID: <20180606120539.GA13130@andrea>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
 <20180605103917.pyhhcobdvaivqv6g@vireshk-i7>
 <57d769f8-46ea-512e-8f89-a0439c9d053f@linaro.org>
 <20180606042708.mtwd66ecy2cnjp7a@vireshk-i7>
 <2bebd1bc-e1ad-6d22-ad1e-aee2cf8ba878@linaro.org>
 <20180606104528.nhwcd2qnxeouk6il@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180606104528.nhwcd2qnxeouk6il@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Daniel, Viresh,

On Wed, Jun 06, 2018 at 04:15:28PM +0530, Viresh Kumar wrote:
> On 06-06-18, 12:22, Daniel Lezcano wrote:
> > (mb() are done in the atomic operations AFAICT).

To do my bit, not all atomic ops do/imply memory barriers; e.g.,

  [from Documentation/atomic_t.txt]

  - non-RMW operations [e.g., atomic_set()] are unordered

  - RMW operations that have no return value [e.g., atomic_inc()] are unordered


> 
> AFAIU, it is required to make sure the operations are seen in a particular order
> on another CPU and the compiler doesn't reorganize code to optimize it.
> 
> For example, in our case what if the compiler reorganizes the atomic-set
> operation after wakeup-process ? But maybe that wouldn't happen across function
> calls and we should be safe then.

IIUC, wake_up_process() implies a full memory barrier and a compiler barrier,
due to:

  raw_spin_lock_irqsave(&p->pi_lock, flags);
  smp_mb__after_spinlock();

The pattern under discussion isn't clear to me, but if you'll end up relying
on this "implicit" barrier I'd suggest documenting it with a comment.

  Andrea
