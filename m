From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] checkpatch: Add a --strict test for structs with bool
 member definitions
Date: Thu, 12 Apr 2018 13:50:22 +0200
Message-ID: <20180412115022.GL4043@hirez.programming.kicks-ass.net>
References: <e22fb871b1b7f2fda4b22f3a24e0d7f092eb612c.camel@perches.com>
 <95477c93db187bab6da8a8ba7c57836868446179.camel@perches.com>
 <20180410143950.4b8526073b4e3e34689f68cb@linux-foundation.org>
 <b3d75281c3a7b4b217b612913894b346eaa3288b.camel@perches.com>
 <20180410150011.df9e036f57b5bcac7ac19686@linux-foundation.org>
 <20180411081502.GJ4082@hirez.programming.kicks-ass.net>
 <20180411092959.e666ec443e4d3bb6f43901d7@linux-foundation.org>
 <20180411170049.GR4082@hirez.programming.kicks-ass.net>
 <20180412074719.pmcddramzyikppco@gmail.com>
 <20180412093521.GA6427@andrea>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180412093521.GA6427@andrea>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Andy Whitcroft <apw@canonical.com>, yuankuiz@codeaurora.org, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 12, 2018 at 11:35:21AM +0200, Andrea Parri wrote:
> Is there a better or recommended way to reference posts on LKML in commit
> messages? (I do like the idea of linking to previous discussions, results,
> ...)

Yes:

  https://lkml.kernel.org/r/$MSGID

that has the added benefit that it immediately includes the msg-id, so
even if you don't have tubes, you can search for it in your local
mailboxes.

Also, since we (kernel.org) control the redirection (currently
marc.info) we can always point it to a life archive.
