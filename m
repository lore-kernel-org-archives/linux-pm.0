From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Tue, 8 Dec 2009 16:40:05 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912081633540.3046-100000__13479.4380785481$1260309022$gmane$org@iolanthe.rowland.org>
References: <200912082152.21910.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912082152.21910.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 8 Dec 2009, Rafael J. Wysocki wrote:

> BTW, is there a good reason why completion_done() doesn't use spin_lock_irqsave
> and spin_unlock_irqrestore?  complete() and complete_all() use them, so why not
> here?

And likewise in try_wait_for_completion().  It looks like a bug.  Maybe 
these routines were not intended to be called with interrupts disabled, 
but that requirement doesn't seem to be documented.  And it isn't a 
natural requirement anyway.

Alan Stern
