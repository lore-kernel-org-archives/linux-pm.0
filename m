From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Acquire device locks on suspend
Date: Mon, 7 Jan 2008 19:01:23 +0100
Message-ID: <200801071901.24926.rjw__34083.4756767892$1199728980$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0801071207090.2748-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0801071207090.2748-100000@iolanthe.rowland.org>
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

On Monday, 7 of January 2008, Alan Stern wrote:
> On Mon, 7 Jan 2008, Rafael J. Wysocki wrote:
> 
> > Please see the patch at: http://lkml.org/lkml/2008/1/6/298 .  It represents my
> > current idea about how to do that.
> 
> It has some problems.
> 
> First, note that the list manipulations in dpm_suspend(), 
> device_power_down(), and so on aren't protected by dpm_list_mtx.  So 
> your patch could corrupt the list pointers.

Yes, they need the locking.  I have overlooked that, mostly because the locking
was removed by gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch
too (because you assumed there woundn't be any need to remove a device during
a suspend, right?).

> Are you assuming that no other threads can be running at this time?

No, I'm not.

> Note also that device_pm_destroy_suspended() does up(&dev->sem), but it 
> doesn't know whether or not dev->sem was locked to begin with.

Do you mean it might have been released already by another thread
calling device_pm_destroy_suspended() on the same device?

> Do you want to rule out the possibility of a driver's suspend or remove 
> methods calling destroy_suspended_device() on its own device?  With 
> your synchronous approach, this would mean that the suspend/resume 
> method would indirectly end up calling the remove method.  This is 
> dangerous at best; with USB it would be a lockdep violation.  With an 
> asynchronous approach, on the other hand, this wouldn't be a problem.

Well, the asynchronous apprach has the problem that the device may end up
on a wrong list when removed by one of the .suspend() callbacks (and I don't
see how to avoid that without extra complexity).  Perhaps that's something we
can live with, though.

One more question: is there any particular reason not to call
device_pm_remove() at the beginning of device_del()?

Rafael
