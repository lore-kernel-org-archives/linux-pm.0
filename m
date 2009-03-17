From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [v3 PATCH 4/4] timers: logic to move non pinned
	timers
Date: Tue, 17 Mar 2009 14:01:00 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0903171350020.29264__4361.16281566701$1237295268$gmane$org@localhost.localdomain>
References: <20090316111045.GA4686@linux.vnet.ibm.com>
	<20090316111548.GE4686@linux.vnet.ibm.com>
	<alpine.LFD.2.00.0903171017590.29264@localhost.localdomain>
	<20090317114557.GA32233@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090317114557.GA32233@linux.vnet.ibm.com>
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
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, linux-pm@lists.linux-foundation.org, mingo@elte.hu, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, 17 Mar 2009, Arun R Bharadwaj wrote:
> * Thomas Gleixner <tglx@linutronix.de> [2009-03-17 11:22:24]:
> >   Let's assume we are on CPU0 and try to enqueue the timer on CPU1,
> >   where the next timer expiry is 5ms away. The timer which we enqueue
> >   is due in 500us. So you introduce 4.5ms latency.
> >
> We are moving timers to the ilb which wakes up every jiffy.
> So we can move the timer to the ilb only if it's expiry
> time is greater than 1 jiffy. Else we can fire on the same CPU.

Please do not start to add some obscure jiffies magic. The correct
check is whether the new timers expiry time is before the first timers
expiry time on the target CPU.

Thanks,

	tglx
