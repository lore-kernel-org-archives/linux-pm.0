From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [update 2] Re: [RFC][PATCH] PM: Avoid losing wakeup
 events during suspend
Date: Thu, 24 Jun 2010 13:09:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006241257410.1654-100000__8717.15275939113$1277399553$gmane$org@iolanthe.rowland.org>
References: <201006241819.25055.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006241819.25055.rjw@sisk.pl>
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

> > This is slightly different from the wakelock design.  Each call to
> > pm_stay_awake() must be paired with a call to pm_relax(), allowing one
> > device to have multiple concurrent critical sections, whereas calls to
> > pm_wakeup_event() must not be paired with anything.  With wakelocks,
> > you couldn't have multiple pending events for the same device.
> 
> You could, but you needed to define multiple wakelocks for the same device for
> this purpose.

Yeah, okay, but who's going to do that?

> > I'm not sure which model is better in practice.  No doubt the Android people 
> > will prefer their way.
> 
> I suppose so.

It may not make a significant difference in the end.  You can always
emulate the wakelock approach by not calling pm_stay_awake() when you
know there is an earlier call still pending.

> > This requires you to define an explicit PCI_WAKEUP_COOLDOWN delay.  I 
> > think that's okay; I had to do something similar with USB and SCSI.  
> > (And I still think it would be a good idea to prevent workqueue threads 
> > from freezing until their queues are empty.)
> 
> I guess you mean the freezable ones?

Yes.  The unfreezable workqueue threads don't have to worry about 
getting frozen while their queues are non-empty.  :-)

>  I'm not sure if that helps a lot, because
> new work items may still be added after the workqueue thread has been frozen.

That's not the point.  If a wakeup handler queues a work item (for
example, by calling pm_request_resume) then it wouldn't need to guess a
timeout.  The work item would be guaranteed to run before the system
could suspend again.

> > Instead of allocating the work structures dynamically, would you be 
> > better off using a memory pool?
> 
> Well, it would be kind of equivalent to defining my own slab cache for that,
> wouldn't it?

I suppose so.  It would make the GFP_ATOMIC allocations a little more 
reliable.

Alan Stern
