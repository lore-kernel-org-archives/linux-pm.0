From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Help needed: Resume problems in 2.6.32-rc,
 perhaps related to preempt_count leakage in keventd
Date: Mon, 9 Nov 2009 15:31:46 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911091527390.2858-100000__39691.1181779162$1257798769$gmane$org@iolanthe.rowland.org>
References: <200911092100.58187.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911092100.58187.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Mon, 9 Nov 2009, Rafael J. Wysocki wrote:

> Still, RIP always points to list_del_init(cwq->worklist.next); in
> run_workqueue().

Use a big hammer: Create a new global variable, set it to 1 while
resuming and back to 0 after the tasks have been thawed.  While the
variable is nonzero, print in the log the list pointers in
cwq->worklist just before executing the list_del_init().  Maybe also 
print some other interesting information about cwq.

Alan Stern
