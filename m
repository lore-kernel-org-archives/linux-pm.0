From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Date: Mon, 1 Jun 2009 15:31:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906011512020.3972-100000__7747.05255539647$1243884718$gmane$org@iolanthe.rowland.org>
References: <200906012104.49890.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906012104.49890.rjw@sisk.pl>
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
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 1 Jun 2009, Rafael J. Wysocki wrote:

> On Thursday 28 May 2009, Alan Stern wrote:
> > On Thu, 28 May 2009, Rafael J. Wysocki wrote:
> > 
> > > I think we'll need one separate workqueue for run-time PM in general, so that
> > > bus types don't introduce their own workqueues for this purpose.  IMO one
> > > system-wide run-time PM workqueue should be sufficient (it could also be
> > > used for the suspend blockers BTW).
> > > 
> > > So, perhaps it makes sense to implement such a workqueue at the core level?
> > > Thoughts?
> > 
> > That's fine with me.  This new workqueue can take over the job of the 
> > "ksuspend_usbd" workqueue.  But it would have to be marked as 
> > freezable.
> 
> Having considered it for a while I'm not sure if freezing is the right approach
> here.  Namely, the work items put into the workqueue need not be useful after
> the resume any more, so perhaps we should deqeue them during suspend?

With USB at least, this isn't true.  Some work items shouldn't be
dequeued, namely, various sorts of resume requests generated while the
driver is in interrupt context.  If they were dequeued during a system
suspend then the device wouldn't ever be woken up, because usbcore
doesn't pass system-resume messages to an autosuspended device.  The
idea is if a device was autosuspended before the system sleep then it
should remain autosuspended after the system wakes up.

Furthermore, even if the existing work items were dequeued, you'd still 
have to worry about new work items added on by drivers before they get 
suspended.  If the workqueue were allowed to run freely, we might find 
devices being autoresumed in the middle of the sleep transition!

Alan Stern
