From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH] checkpatch: Add a --strict test for structs with bool
 member definitions
Date: Thu, 12 Apr 2018 11:35:21 +0200
Message-ID: <20180412093521.GA6427@andrea>
References: <20180410123305.GF4082@hirez.programming.kicks-ass.net>
 <e22fb871b1b7f2fda4b22f3a24e0d7f092eb612c.camel@perches.com>
 <95477c93db187bab6da8a8ba7c57836868446179.camel@perches.com>
 <20180410143950.4b8526073b4e3e34689f68cb@linux-foundation.org>
 <b3d75281c3a7b4b217b612913894b346eaa3288b.camel@perches.com>
 <20180410150011.df9e036f57b5bcac7ac19686@linux-foundation.org>
 <20180411081502.GJ4082@hirez.programming.kicks-ass.net>
 <20180411092959.e666ec443e4d3bb6f43901d7@linux-foundation.org>
 <20180411170049.GR4082@hirez.programming.kicks-ass.net>
 <20180412074719.pmcddramzyikppco@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180412074719.pmcddramzyikppco@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Andy Whitcroft <apw@canonical.com>, yuankuiz@codeaurora.org, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, Apr 12, 2018 at 09:47:19AM +0200, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > I still have room in my /dev/null mailbox for pure checkpatch patches.
> > 
> > > (ooh, https://lkml.org/lkml/2017/11/21/384 is working this morning)
> > 
> > Yes, we really should not use lkml.org for references. Sadly google
> > displays it very prominently when you search for something.
> 
> lkml.org is nice in emails that have a short expected life time and relevance - 
> but it probably shouldn't be used for permanent references such as kernel 
> messages, code comments and Git log entries.

Is there a better or recommended way to reference posts on LKML in commit
messages? (I do like the idea of linking to previous discussions, results,
...)

  Andrea


> 
> Thanks,
> 
> 	Ingo
