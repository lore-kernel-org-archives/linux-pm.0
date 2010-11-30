From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Prevent dpm_prepare() from returning
 errors unnecessarily
Date: Tue, 30 Nov 2010 10:13:43 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1011301008110.1686-100000__3977.15575895763$1291130253$gmane$org@iolanthe.rowland.org>
References: <201011292304.11856.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201011292304.11856.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 29 Nov 2010, Rafael J. Wysocki wrote:

> > Oh, I see.  This is a tricky issue.  Every driver for a device that can
> > have wakeup-enabled children needs to worry about the race between
> > suspending the device and receiving a wakeup request from a child.  
> > For example, in drivers/usb/core/hcd-pci.c, the suspend_common()
> > routine goes out of its way to return -EBUSY if device_may_wakeup() is
> > true and the controller's root hub has a pending wakeup request.
> > 
> > How should drivers handle this in general?  Should we make an effort to
> > convert them to use the wakeup framework so they they can let the PM
> > core take care of these races?
> 
> I think so.
> 
> We also need to put a pm_check_wakeup_events() check into dpm_suspend() IMO,
> so that we abort the suspending of devices as soon as a wakeup event is
> reported.

You might as well add that into this patch.

> > Do we have to consider similar races during runtime suspend?
> 
> Ideally, yes, but I'm not sure if that's generally possible.  IMO, it won't be
> a big deal if a parent device is suspended and immediately resumed occasionally
> due to a pending wakeup signal from one of its children.  It may be a problem
> if that happens too often, though.

Okay.

> Does it mean you're fine with the patch?

Provided you repair the error that Lei Ming pointed out.  That's the 
problem with functions that return Boolean values -- you have to name 
them very carefully.  Ideally the name should be a predicate or a
question.

Alan Stern
