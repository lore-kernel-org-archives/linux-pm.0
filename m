From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH ver. 2] PM: add synchronous runtime interface
 for interrupt handlers
Date: Wed, 24 Nov 2010 11:43:57 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1011241141010.1513-100000__16904.6948584311$1290617290$gmane$org@iolanthe.rowland.org>
References: <87mxozd1ho.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87mxozd1ho.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Partha Basak <p-basak2@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 23 Nov 2010, Kevin Hilman wrote:

> While I like the idea of the symmetry of having both _get_sync() and
> _put_sync() callable from an interrupt handler, I can't currently think
> of a situation where we would need to _put_sync() in the ISR.  A
> standard _put() should suffice for all cases I can imagine.

It's wasteful to go through the context switch to the workqueue process
if you don't need to.  And it's time consuming; you want to power down 
the device as soon as possible once the interrupt handler is finished, 
right?

What do you think of the pm_runtime_put_sync_suspend() proposal?

Alan Stern
