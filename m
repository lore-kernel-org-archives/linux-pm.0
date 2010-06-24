From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [update 2] Re: [RFC][PATCH] PM: Avoid losing wakeup
	events during suspend
Date: Thu, 24 Jun 2010 18:19:24 +0200
Message-ID: <201006241819.25055.rjw__17298.757346771$1277396615$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1006241111110.1654-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006241111110.1654-100000@iolanthe.rowland.org>
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
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, June 24, 2010, Alan Stern wrote:
> On Thu, 24 Jun 2010, Rafael J. Wysocki wrote:
> 
> > > > And what happens if the device gets a second wakeup event before the timer
> > > > for the first one expires?
> > > 
> > > Good question.  I don't have an answer to it at the moment, but it seems to
> > > arise from using a single timer for all events.
> > > 
> > > It looks like it's simpler to make pm_wakeup_event() allocate a timer for each
> > > event and make the timer function remove it.  That would cause suspend to
> > > be blocked until the timer expires without a way to cancel it earlier, though.
> > 
> > So, I decided to try this after all.
> > 
> > Below is a new version of the patch.  It introduces pm_stay_awake(dev) and
> > pm_relax() that play the roles of the "old" pm_wakeup_begin() and
> > pm_wakeup_end().
> > 
> > pm_wakeup_event() now takes an extra timeout argument and uses it for
> > deferred execution of pm_relax().  So, one can either use the
> > pm_stay_awake(dev) / pm_relax() pair, or use pm_wakeup_event(dev, timeout)
> > if the ending is under someone else's control.
> > 
> > In addition to that, pm_get_wakeup_count() blocks until events_in_progress is
> > zero.
> > 
> > Please tell me what you think.
> 
> This is slightly different from the wakelock design.  Each call to
> pm_stay_awake() must be paired with a call to pm_relax(), allowing one
> device to have multiple concurrent critical sections, whereas calls to
> pm_wakeup_event() must not be paired with anything.  With wakelocks,
> you couldn't have multiple pending events for the same device.

You could, but you needed to define multiple wakelocks for the same device for
this purpose.

> I'm not sure which model is better in practice.  No doubt the Android people 
> will prefer their way.

I suppose so.

> This requires you to define an explicit PCI_WAKEUP_COOLDOWN delay.  I 
> think that's okay; I had to do something similar with USB and SCSI.  
> (And I still think it would be a good idea to prevent workqueue threads 
> from freezing until their queues are empty.)

I guess you mean the freezable ones?  I'm not sure if that helps a lot, because
new work items may still be added after the workqueue thread has been frozen.

> Instead of allocating the work structures dynamically, would you be 
> better off using a memory pool?

Well, it would be kind of equivalent to defining my own slab cache for that,
wouldn't it?

Rafael
