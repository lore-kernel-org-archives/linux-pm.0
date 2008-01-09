From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Acquire device locks on suspend
Date: Thu, 10 Jan 2008 00:29:25 +0100
Message-ID: <200801100029.26465.rjw__9024.88001524962$1199921316$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0801091734180.2856-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0801091734180.2856-100000@iolanthe.rowland.org>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 9 of January 2008, Alan Stern wrote:
> On Wed, 9 Jan 2008, Rafael J. Wysocki wrote:
> 
> > > In dpm_resume() you shouldn't need to use dpm_list_mtx at all, because
> > > the list_move_tail() comes before the resume_device().  It's the same
> > > as in dpm_power_up().
> > 
> > Still, device_pm_schedule_removal() can (in theory) be called concurrently
> > with dpm_resume() by another thread and this might corrupt the list without
> > the locking.
> 
> Any thread doing that would be in violation of the restrictions you're 
> going to add to the kerneldoc for destroy_suspended_device().
> 
> However the overhead for the locking isn't critical.  There won't be
> any contention (if everything is working right) and it isn't a hot path
> anyway.  So you can leave the extra locking in if you want.  But then
> you should put it in all the routines where the lists get manipulated,
> not just some of them.  That is: device_power_down(), dpm_power_up(),
> and even unregister_dropped_devices().

Except for those run on one CPU with interrupts disabled, I think.

> > > Also, the kerneldoc for destroy_suspended_device() should contain an 
> > > extra paragraph warning that the routine should never be called except 
> > > within the scope of a system sleep transition.  In practice this means 
> > > it has to be directly or indirectly invoked by a suspend or resume 
> > > method.
> > 
> > Or by a CPU hotplug notifier (that will be the majority of cases, IMO).
> 
> In your patch the call is made in response to a CPU_UP_CANCELED_FROZEN
> notification.  Isn't it true that this notification is issued only as
> part of a system sleep transition?

Yes, it is.

> We wouldn't want to allow destroy_suspended_device() to be called when an
> arbitrary CPU hotplug notification occurs.

Of course.

Greetings,
Rafael
