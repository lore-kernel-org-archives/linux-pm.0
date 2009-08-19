From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 0/7] PM: Asynchronous suspend and resume
	(updated)
Date: Wed, 19 Aug 2009 18:34:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908191829510.26174-100000__45126.7169592485$1250721310$gmane$org@iolanthe.rowland.org>
References: <200908192317.41253.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908192317.41253.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 19 Aug 2009, Rafael J. Wysocki wrote:

> On Wednesday 19 August 2009, Alan Stern wrote:
> > On Wed, 19 Aug 2009, Rafael J. Wysocki wrote:
> > 
> > > There's a problem that for safety reasons I maintain the ordering of dpm_list
> > > and the callbacks are scheduled for async execution in the same order in
> > > which they would have been executed synchronously.  If were to change this,
> > > we'd have to be _very_ careful.
> > 
> > Why?  The order in which jobs are scheduled for async execution doesn't 
> > bear any particular relation to the order in which they get run.
> 
> Yes, it does, if all of the async threads are busy and we add more async jobs
> to the queue.  We must ensure that none of the jobs being executed will wait
> for any jobs in the queue.

That's part of the reason for the dependencies: to make sure that where
it matters, things don't run in the wrong order.

> Also, if any devices are handled synchronously, they must not wait for any
> "async" devices that haven't been scheduled yet.

I'm not sure what you mean.  If a device is handled synchronously, it 
must wait for all the devices preceding it on the list, regardless of 
whether those devices are handled asynchronously.

> With a master thread that would do all the waiting that wouldn't be a problem
> any more, but I'm not sure how to implement such a thread efficiently.  The
> problem is that each device may depend on multiple other devices, so even
> if one callback finishes, there's no guarantee there will be any device with
> satisfied dependencies, so it looks like the master thread would have to
> browse dpm_list continuously searching it for devices that are ready for
> suspending.
> 
> Also I don't think we can change the ordering of dpm_list as a result of
> asynchronous execution.

Okay, so I'll try to write something.  We'll see how it comes out.

Alan Stern
