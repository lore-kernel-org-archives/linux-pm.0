From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Introduce core framework for
	run-time PM of I/O devices (rev. 8)
Date: Wed, 8 Jul 2009 23:29:50 +0200
Message-ID: <200907082329.51795.rjw__47135.6610338718$1247088720$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0907081707090.22618-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0907081707090.22618-100000@iolanthe.rowland.org>
Content-Disposition: inline
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 08 July 2009, Alan Stern wrote:
> On Wed, 8 Jul 2009, Rafael J. Wysocki wrote:
> 
> > > I thought you wanted to avoid this sort of complication.
> > 
> > I did, but there might be some benefits.  For example, the timer and the work
> > structure provided by dev.power can be used for scheduling such operations
> > if they are defined at the core level.
> > 
> > Suppose your device has 3 low power states D1 - D3 (like PCI) and you want it
> > to go into D1 first, then, after a delay, to D2 and finally, again after a
> > delay, to D3.  Of course, if there's a resume in the meantime, it should cancel
> > whichever transition is in progress.
> > 
> > pm_runtime_suspend() can be used for the first transition, but the bus type or
> > driver will have to provide its own mechanics for going down to D2 and D3,
> > which must be synchronized with its ->runtime_resume().  That might be tricky
> > and the core already has what's necessary (well, almost).
> 
> Maybe we can provide a way for drivers to set up their own timer 
> callback or work routine for use while the status is RPM_SUSPENDED.

Agreed.

Anyway, I don't think it's really necessary in the Magnus' usage case, as
you pointed out earlier in this thread, so I think we can consider it as
something to add in future.

The current patch is already more that 1200 lines and there's some
documentation to add, so I wouldn't like to make it any bigger. :-)

Best,
Rafael
