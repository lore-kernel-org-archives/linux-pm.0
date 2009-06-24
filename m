From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Introduce core framework for run-time PM
	of I/O devices (rev. 3)
Date: Wed, 24 Jun 2009 02:08:22 +0200
Message-ID: <200906240208.23482.rjw__14117.613194003$1245802244$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906231303390.3209-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906231303390.3209-100000@iolanthe.rowland.org>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 23 June 2009, Alan Stern wrote:
> On Tue, 23 Jun 2009, Rafael J. Wysocki wrote:
> 
> > Hi,
> > 
> > Below is a new revision of the patch introducing the run-time PM framework.
> > 
> > The most visible changes from the last version:
> > 
> > * I realized that if child_count is atomic, we can drop the parent locking from
> >   all of the functions, so I did that.
> > 
> > * Introduced pm_runtime_put() that decrements the resume counter and queues
> >   up an idle notification if the counter went down to 0 (and wasn't 0 previously).
> >   Using asynchronous notification makes it possible to call pm_runtime_put()
> >   from interrupt context, if necessary.
> > 
> > * Changed the meaning of the RPM_WAKE bit slightly (it is now also used for
> >   disabling run-time PM for a device along with the resume counter).
> > 
> > Please let me know if I've overlooked anything. :-)
> 
> This first thing to strike me was that you moved the idle notifications 
> into the workqueue.

Yes, I did.
 
> Is that really needed?  Would we be better off just make the idle
> callbacks directly from pm_runtime_put?  They would run in whatever
> context the driver happened to be in at the time.
> 
> It's not clear exactly how much work the idle callbacks will need to 
> do, but it seems likely that they won't have to do too much more than 
> call pm_request_suspend.  And of course, that can be done in_interrupt.

I just don't want to put any constraints on the implementation of
->runtime_idle().  The requirement that it be suitable for calling from
interrupt context may be quite inconvenient for some drivers and I'm afraid
they may have problems with meeting it.

Best,
Rafael
