From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Introduce core framework for
 run-time PM of I/O devices (rev. 8)
Date: Wed, 8 Jul 2009 17:09:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0907081707090.22618-100000__24214.2547191635$1247087416$gmane$org@iolanthe.rowland.org>
References: <200907082155.40903.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200907082155.40903.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 8 Jul 2009, Rafael J. Wysocki wrote:

> > I thought you wanted to avoid this sort of complication.
> 
> I did, but there might be some benefits.  For example, the timer and the work
> structure provided by dev.power can be used for scheduling such operations
> if they are defined at the core level.
> 
> Suppose your device has 3 low power states D1 - D3 (like PCI) and you want it
> to go into D1 first, then, after a delay, to D2 and finally, again after a
> delay, to D3.  Of course, if there's a resume in the meantime, it should cancel
> whichever transition is in progress.
> 
> pm_runtime_suspend() can be used for the first transition, but the bus type or
> driver will have to provide its own mechanics for going down to D2 and D3,
> which must be synchronized with its ->runtime_resume().  That might be tricky
> and the core already has what's necessary (well, almost).

Maybe we can provide a way for drivers to set up their own timer 
callback or work routine for use while the status is RPM_SUSPENDED.

Alan Stern
