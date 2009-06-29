From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch update] PM: Introduce core framework for
	run-time PM of I/O devices (rev. 6)
Date: Tue, 30 Jun 2009 00:50:55 +0200
Message-ID: <200906300050.56304.rjw__34775.7920776077$1246315990$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906291752570.18279-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906291752570.18279-100000@iolanthe.rowland.org>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 30 June 2009, Alan Stern wrote:
> On Mon, 29 Jun 2009, Rafael J. Wysocki wrote:
> 
> > > Another possible approach you could take when the call to
> > > cancel_delayed_work fails (which should be rare) is to turn on RPM_WAKE
> > > in addition to RPM_IDLE and leave the suspend request queued.  When
> > > __pm_runtime_suspend sees both flags are set, it should abort and set
> > > the status directly back to RPM_ACTIVE.  At that time the idle
> > > notifications can start up again.
> > > 
> > > Is this any better?  I can't see how drivers would care, though.
> > 
> > There still is the problem that the suspend request is occupying the
> > work_struct which cannot be used for any other purpose.
> 
> What other purpose?  We don't send idle notifications in RPM_IDLE

OK

> and resume requests don't need to be stored since (as described above) they
> just set the RPM_WAKE flag.  Hence nothing else needs to use the
> work_struct.

Good.  I'd go for it, then.  OK?

> >  I don't think this
> > is avoidable, though.  This way or another it is possible to have two requests
> > pending at a time.
> > 
> > Perhaps the simplest thing to do would be to simply ignore pending suspend
> > requests in both pm_request_resume() and pm_runtime_resume() and to allow
> > them to be scheduled at any time.  That shouldn't hurt anything as long as
> > pm_runtime_suspend() is smart enough, but it has to be anyway, because it
> > can be run synchronously at any time.
> > 
> > The only question is what pm_runtime_suspend() should do when it sees a pending
> > suspend request and quite frankly I think it can just ignore it as well,
> > leaving the RPM_IDLE bit set.  In which case the name RPM_IDLE will not really
> > be adequate, so perhaps it can be renamed to RPM_REQUEST or something like
> > this.
> > 
> > Then, we'll need a separate work structure for suspend requests, but I have no
> > problem with that.
> 
> You seem to be thinking about these requests in a very different way
> from me.  They don't form a queue or anything like that.  Instead they
> mean "Change the device's power state to this value as soon as
> possible" -- and they are needed only because sometimes (in atomic or
> interrupt contexts) the change can't be made right away.
> 
> That's why it doesn't make any sense to have both a suspend and a 
> resume request pending at the same time.  It would mean the driver is 
> telling us "Change the device's power state to both low-power and 
> full-power as soon as possible"!
> 
> We should settle on a general policy for how to handle it when a 
> driver makes the mistake of telling us to do contradictory things.  
> There are three natural policies:
> 
> 	The first request takes precedence over the second;
> 
> 	The second request takes precedence over the first;
> 
> 	Resumes take precedence over suspends.
> 
> Any one of those would be acceptable.

IMO resumes should take precedence over suspends, because resume usually means
"there's I/O to process" and we usually we want the I/O to be processed as soon
as possible (deferred wake-up will usually mean deferred I/O and that would
hurt user experience).

Best,
Rafael
