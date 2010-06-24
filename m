From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [update 2] Re: [RFC][PATCH] PM: Avoid losing wakeup
 events during suspend
Date: Thu, 24 Jun 2010 11:44:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006241111110.1654-100000__15246.3221144446$1277394430$gmane$org@iolanthe.rowland.org>
References: <201006241513.06116.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006241513.06116.rjw@sisk.pl>
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
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 24 Jun 2010, Rafael J. Wysocki wrote:

> > > And what happens if the device gets a second wakeup event before the timer
> > > for the first one expires?
> > 
> > Good question.  I don't have an answer to it at the moment, but it seems to
> > arise from using a single timer for all events.
> > 
> > It looks like it's simpler to make pm_wakeup_event() allocate a timer for each
> > event and make the timer function remove it.  That would cause suspend to
> > be blocked until the timer expires without a way to cancel it earlier, though.
> 
> So, I decided to try this after all.
> 
> Below is a new version of the patch.  It introduces pm_stay_awake(dev) and
> pm_relax() that play the roles of the "old" pm_wakeup_begin() and
> pm_wakeup_end().
> 
> pm_wakeup_event() now takes an extra timeout argument and uses it for
> deferred execution of pm_relax().  So, one can either use the
> pm_stay_awake(dev) / pm_relax() pair, or use pm_wakeup_event(dev, timeout)
> if the ending is under someone else's control.
> 
> In addition to that, pm_get_wakeup_count() blocks until events_in_progress is
> zero.
> 
> Please tell me what you think.

This is slightly different from the wakelock design.  Each call to
pm_stay_awake() must be paired with a call to pm_relax(), allowing one
device to have multiple concurrent critical sections, whereas calls to
pm_wakeup_event() must not be paired with anything.  With wakelocks,
you couldn't have multiple pending events for the same device.  I'm not
sure which model is better in practice.  No doubt the Android people 
will prefer their way.

This requires you to define an explicit PCI_WAKEUP_COOLDOWN delay.  I 
think that's okay; I had to do something similar with USB and SCSI.  
(And I still think it would be a good idea to prevent workqueue threads 
from freezing until their queues are empty.)

Instead of allocating the work structures dynamically, would you be 
better off using a memory pool?

Alan Stern
