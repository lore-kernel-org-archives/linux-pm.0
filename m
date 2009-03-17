From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [v3 PATCH 3/4] timers: /proc/sys sysctl hook to
	enable timer	migration
Date: Tue, 17 Mar 2009 11:13:56 +0100
Message-ID: <20090317101356.GF6477__37002.9652062387$1237285203$gmane$org@elte.hu>
References: <20090316111045.GA4686@linux.vnet.ibm.com>
	<20090316111444.GD4686@linux.vnet.ibm.com>
	<20090316152956.GA2344@x200.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090316152956.GA2344@x200.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, Arun R Bharadwaj <arun@linux.vnet.ibm.com>, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org


* Alexey Dobriyan <adobriyan@gmail.com> wrote:

> On Mon, Mar 16, 2009 at 04:44:44PM +0530, Arun R Bharadwaj wrote:
> > echo 0 > /proc/sys/kernel/timer_migration
> 
> There should be no sysctl for this.
> 
> Timer migration should be good enough to be always enabled.

It's in the CONFIG_SCHED_DEBUG section - i.e. only available 
under scheduler debugging. (and it's a fair flag for that case)

	Ingo
