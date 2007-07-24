From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Towards eliminating the freezer
Date: Tue, 24 Jul 2007 21:20:21 +0200
Message-ID: <200707242120.22529.rjw__40442.4958084293$1185304569$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0707241155420.14025-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707241155420.14025-100000@iolanthe.rowland.org>
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
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 24 July 2007 18:06, Alan Stern wrote:
> On Tue, 24 Jul 2007, Rafael J. Wysocki wrote:
> 
> > > As with Oliver's suggestion, this would create a locking order 
> > > violation.  Drivers registering children (and thus acquiring 
> > > dpm_list_mtx) will often already hold the parent's sem.  But 
> > > device_suspend() needs to acquire device sems while holding 
> > > dpm_list_mtx.
> > 
> > Hmm, but this is done already (ie. device_suspend() acquires device sems
> > while holding dpm_list_mtx in the current code).
> > 
> > What I'm suggesting is not to let device_suspend() release dpm_list_mtx
> > when it's finished.  The appended patch illustrates that I mean.
> 
> Oh, okay, I see what you mean.
> 
> I should have explained earlier that my proposal was meant to be in the 
> context of a previous discussion, where I suggested that 
> device_suspend() should go through a preliminary step of acquiring all 
> the device semaphores.  This would have the beneficial effect of 
> blocking all attempts at driver binding or unbinding while a suspend is 
> underway.
> 
> Still, this isn't a bad approach.  Maybe the following algorithm could 
> be used:
> 
>  get_more:
> 	For each device on dpm_list
> 		Acquire dev->sem
> 		Move dev from dpm_list to a temporary list
> 	Lock dpm_list_mutex
> 	If (!list_empty(dpm_list)) {
> 		Unlock dpm_list_mutex
> 		Goto get_more
> 	}
> 
> (The "For each" loop would have to be written carefully to allow for 
> device removal.)

Hmm, I still don't understand why we can't lock dpm_list_mutex before the
"For each" loop (we already do something like this in device_suspend() and
device_resume()) and that would simplify things.

It seems that we can do something like this:

device_suspend:
	Lock dpm_list_mutex (from now on, new devices cannot be added)
	For each device on dpm_active, reverse
		acquire dev->sem (from now on, no new drivers can bind to dev)
		suspend(dev)
		move dev to dpm_off

device_resume:
	For each device on dpm_off
		move dev to dpm_active
		resume(dev) (this cannot fail)
		release dev->sem (allow new drivers to bind to dev)
	Unlock dpm_list_mutex (allow new devices to be added)

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
