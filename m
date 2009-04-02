From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: Re: [v4 RFC PATCH 1/4] timers: Framework for identifying
	pinned	timers
Date: Thu, 2 Apr 2009 10:39:19 +0530
Message-ID: <20090402050919.GA8813__32162.9658611075$1238649345$gmane$org@linux.vnet.ibm.com>
References: <20090401113128.GA22478@linux.vnet.ibm.com>
	<20090401113258.GB22478@linux.vnet.ibm.com>
	<20090401114146.GS11935@one.firstfloor.org>
Reply-To: arun@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090401114146.GS11935@one.firstfloor.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@firstfloor.org>
Cc: a.p.zijlstra@chello.nl, mingo@elte.hu, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, Arun Bharadwaj <arun@linux.vnet.ibm.com>, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

* Andi Kleen <andi@firstfloor.org> [2009-04-01 13:41:46]:

> On Wed, Apr 01, 2009 at 05:02:58PM +0530, Arun R Bharadwaj wrote:
> > * Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-04-01 17:01:28]:
> > 
> > This patch creates a new framework for identifying cpu-pinned timers
> > and hrtimers.
> > 
> > 
> > This framework is needed because pinned timers are expected to fire on
> > the same CPU on which they are queued. So it is essential to identify
> > these and not migrate them, in case there are any.
> 
> How would that interact with add_timer_on()? You currently only
> support the current CPU, don't you?
> 
> e.g. the new tip x86 machine check polling code relies on add_timer_on
> staying on that CPU.
>

Pinned timers are directly related to add_timer_on().
So I assume that whatever timer is queued using add_timer_on() is
supposed to be a pinned timer.
Currently, we can stay on one CPU and still queue a pinned timer on
some other CPU. We can mark those timers as 'pinned' to that
particular CPU.

--arun

> -Andi
> 
> -- 
> ak@linux.intel.com -- Speaking for myself only.
