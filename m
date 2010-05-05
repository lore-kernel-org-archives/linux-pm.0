From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Wed, 5 May 2010 17:12:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005051705200.1885-100000__10459.8442129374$1273095435$gmane$org@iolanthe.rowland.org>
References: <20100505202826.GB7450@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100505202826.GB7450@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mark gross <mgross@linux.intel.com>
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, markgross@thegnar.org, Oleg Nesterov <oleg@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 5 May 2010, mark gross wrote:

> > > True, you need an ack back from user mode for when its ok to allow
> > > suspend to happen.  This ack is device specific and needs to be custom
> > > built per product to its wake up sources.
> > 
> > No and no.  Nothing special is needed.  All userspace needs to do is 
> > remove the condition that led to the blocker being enabled initially -- 
> > which is exactly what userspace would do normally anyway.
> 
> Oh, like tell the modem that user mode has handled the ring event and
> its ok to un-block?

No, that's not how it works.  It would go like this:

	The modem IRQ handler queues its event to the input subsystem.  
	As it does so the input subsystem enables a suspend blocker, 
	causing the system to stay awake after the IRQ is done.

	The user program enables its own suspend blocker before reading
	the input queue.  When the queue is empty, the input subsystem
	releases its suspend blocker.

	When the user program finishes processing the event, it
	releases its suspend blocker.  Now the system can go back to
	sleep.

At no point does the user program have to communicate anything to the 
modem driver, and at no point does it have to do anything out of the 
ordinary except to enable and disable a suspend blocker.

Alan Stern
