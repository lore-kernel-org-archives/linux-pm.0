From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [update 2] Re: [RFC][PATCH] PM: Avoid losing wakeup
	events during suspend
Date: Fri, 25 Jun 2010 01:06:41 +0200
Message-ID: <201006250106.41855.rjw__5984.88098844445$1277421018$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1006241257410.1654-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006241257410.1654-100000@iolanthe.rowland.org>
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
> > > This is slightly different from the wakelock design.  Each call to
> > > pm_stay_awake() must be paired with a call to pm_relax(), allowing one
> > > device to have multiple concurrent critical sections, whereas calls to
> > > pm_wakeup_event() must not be paired with anything.  With wakelocks,
> > > you couldn't have multiple pending events for the same device.
> > 
> > You could, but you needed to define multiple wakelocks for the same device for
> > this purpose.
> 
> Yeah, okay, but who's going to do that?
> 
> > > I'm not sure which model is better in practice.  No doubt the Android people 
> > > will prefer their way.
> > 
> > I suppose so.
> 
> It may not make a significant difference in the end.  You can always
> emulate the wakelock approach by not calling pm_stay_awake() when you
> know there is an earlier call still pending.
> 
> > > This requires you to define an explicit PCI_WAKEUP_COOLDOWN delay.  I 
> > > think that's okay; I had to do something similar with USB and SCSI.  
> > > (And I still think it would be a good idea to prevent workqueue threads 
> > > from freezing until their queues are empty.)
> > 
> > I guess you mean the freezable ones?
> 
> Yes.  The unfreezable workqueue threads don't have to worry about 
> getting frozen while their queues are non-empty.  :-)
> 
> >  I'm not sure if that helps a lot, because
> > new work items may still be added after the workqueue thread has been frozen.
> 
> That's not the point.  If a wakeup handler queues a work item (for
> example, by calling pm_request_resume) then it wouldn't need to guess a
> timeout.  The work item would be guaranteed to run before the system
> could suspend again.

You seem to be referring to the PM workqueue specifically.  Perhaps it would be
better to special-case it and stop it by adding a barrier work during suspend
instead of just freezing?  Then, it wouldn't need to be singlethread any more.

Still, I think the timeout is necessary anyway in case the driver simply
doesn't handle the event and user space needs time to catch up.  Unfortunately,
the PCI wakeup code doesn't know what happens next in advance.

Rafael
