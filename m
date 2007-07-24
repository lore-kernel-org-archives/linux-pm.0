From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Towards eliminating the freezer
Date: Tue, 24 Jul 2007 12:06:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707241155420.14025-100000__48554.5883923352$1185293344$gmane$org@iolanthe.rowland.org>
References: <200707241724.50330.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707241724.50330.rjw@sisk.pl>
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
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 24 Jul 2007, Rafael J. Wysocki wrote:

> > As with Oliver's suggestion, this would create a locking order 
> > violation.  Drivers registering children (and thus acquiring 
> > dpm_list_mtx) will often already hold the parent's sem.  But 
> > device_suspend() needs to acquire device sems while holding 
> > dpm_list_mtx.
> 
> Hmm, but this is done already (ie. device_suspend() acquires device sems
> while holding dpm_list_mtx in the current code).
> 
> What I'm suggesting is not to let device_suspend() release dpm_list_mtx
> when it's finished.  The appended patch illustrates that I mean.

Oh, okay, I see what you mean.

I should have explained earlier that my proposal was meant to be in the 
context of a previous discussion, where I suggested that 
device_suspend() should go through a preliminary step of acquiring all 
the device semaphores.  This would have the beneficial effect of 
blocking all attempts at driver binding or unbinding while a suspend is 
underway.

Still, this isn't a bad approach.  Maybe the following algorithm could 
be used:

 get_more:
	For each device on dpm_list
		Acquire dev->sem
		Move dev from dpm_list to a temporary list
	Lock dpm_list_mutex
	If (!list_empty(dpm_list)) {
		Unlock dpm_list_mutex
		Goto get_more
	}

(The "For each" loop would have to be written carefully to allow for 
device removal.)

The total number of iterations should never be large.  At the end the 
PM core would own all the device semaphores and no more devices could 
be added.  Then it would be safe to call each device's suspend() 
method.

This will remove one of the barriers to eliminating the freezer.

Alan Stern
