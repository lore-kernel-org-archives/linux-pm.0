From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH ver. 2] PM: add synchronous runtime interface
	for interrupt handlers
Date: Wed, 24 Nov 2010 10:03:24 -0800
Message-ID: <871v6aa9ar.fsf__18660.3336981081$1290621886$gmane$org@deeprootsystems.com>
References: <Pine.LNX.4.44L0.1011241141010.1513-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1011241141010.1513-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Wed, 24 Nov 2010 11:43:57 -0500 (EST)")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Partha Basak <p-basak2@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Tue, 23 Nov 2010, Kevin Hilman wrote:
>
>> While I like the idea of the symmetry of having both _get_sync() and
>> _put_sync() callable from an interrupt handler, I can't currently think
>> of a situation where we would need to _put_sync() in the ISR.  A
>> standard _put() should suffice for all cases I can imagine.
>
> It's wasteful to go through the context switch to the workqueue process
> if you don't need to.  And it's time consuming; you want to power down 
> the device as soon as possible once the interrupt handler is finished, 
> right?
>
> What do you think of the pm_runtime_put_sync_suspend() proposal?

That should be fine.

Thinking of this some more, I don't have any use cases currently where
we would any sort of put in the ISR, since the ISR is usually an
indicator that something else will be accessing the device shortly after
the ISR is finished.

Kevin
