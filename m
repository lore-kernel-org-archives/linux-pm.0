From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 22:35:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005142233070.11498-100000__46050.6384297789$1273891069$gmane$org@netrider.rowland.org>
References: <201005140028.49443.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005140028.49443.rjw@sisk.pl>
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
Cc: linux-omap@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 14 May 2010, Rafael J. Wysocki wrote:

> > > How do you handle situations where the CPU is currently idle but an 
> > > event (such as I/O completion) is expected to occur in the near future?  
> > > You don't want to power-off and reboot then, do you?
> > 
> > The idle code looks at next_timer_interrupt() value, then if the
> > next timer event if far enough ahead, the system powers down and
> > wakes to the timer interrupt. It also wakes to device interrupts.
> 
> For the record, waking to interrupts doesn't work on quite some systems
> (like ACPI-based PCs for one example).

Ironically, it appears that ACPI-based PCs are in a position to benefit 
more from opportunistic suspend and suspend blockers than are embedded 
systems -- and yet they are being proposed for use on cell phones 
rather than on desktops.

Alan Stern
