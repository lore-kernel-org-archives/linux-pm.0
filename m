From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch update 3] PM: Introduce core framework for
	run-time PM of I/O devices
Date: Tue, 23 Jun 2009 01:02:27 +0200
Message-ID: <200906230102.29318.rjw__36495.8266764463$1245711789$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906221222490.15425-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906221222490.15425-100000@iolanthe.rowland.org>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Monday 22 June 2009, Alan Stern wrote:
> On Mon, 22 Jun 2009, Rafael J. Wysocki wrote:
> 
> > > Again, this boils down to how drivers decide to use the async 
> > > interface.  I can see justifications for both pm_request_resume_get 
> > > (which would always increment the counter) and pm_request_resume (which 
> > > would increment the counter only if a work item had to be queued).
> > 
> > OK, so this means we should provide both at the core level and let the drivers
> > decide which one to use.
> > 
> > I think in both cases the caller would be responsible for decrementing the
> > counter?
> 
> Sure.  They could call pm_runtime_put just once at the end of their
> runtime_resume method (assuming they used pm_request_resume), or they
> could call it at every place where some deferred work was finished 
> (assuming they used pm_request_resume_get).
> 
> > > Okay, we don't need it then.  I forgot to mention in the previous
> > > message that there also has to be a pm_runtime_del() routine, which
> > > should cancel pending workqueue items and set the counter to some high
> > > value so that no new items are added.
> > 
> > Should that be called by device_pm_remove()?  I think so.
> 
> Yes.  I suppose it could be named pm_runtime_remove.  Either would be 
> okay.

OK

I'm sending a new version of the $subject patch, containing these changes
among other things, in a new thread.

Best,
Rafael
