From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [v4 RFC PATCH 1/4] timers: Framework for identifying
	pinned timers
Date: Wed, 1 Apr 2009 13:41:46 +0200
Message-ID: <20090401114146.GS11935__29642.3350148418$1238586687$gmane$org@one.firstfloor.org>
References: <20090401113128.GA22478@linux.vnet.ibm.com>
	<20090401113258.GB22478@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090401113258.GB22478@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Cc: a.p.zijlstra@chello.nl, mingo@elte.hu, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 01, 2009 at 05:02:58PM +0530, Arun R Bharadwaj wrote:
> * Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-04-01 17:01:28]:
> 
> This patch creates a new framework for identifying cpu-pinned timers
> and hrtimers.
> 
> 
> This framework is needed because pinned timers are expected to fire on
> the same CPU on which they are queued. So it is essential to identify
> these and not migrate them, in case there are any.

How would that interact with add_timer_on()? You currently only
support the current CPU, don't you?

e.g. the new tip x86 machine check polling code relies on add_timer_on
staying on that CPU.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
