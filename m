From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 0/7] PM: Asynchronous suspend and resume
	(updated)
Date: Thu, 20 Aug 2009 17:56:36 +0200
Message-ID: <200908201756.36801.rjw__2356.393778655$1250783801$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908191829510.26174-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908191829510.26174-100000@iolanthe.rowland.org>
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
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 20 August 2009, Alan Stern wrote:
> On Wed, 19 Aug 2009, Rafael J. Wysocki wrote:
> 
> > On Wednesday 19 August 2009, Alan Stern wrote:
> > > On Wed, 19 Aug 2009, Rafael J. Wysocki wrote:
> > > 
> > > > There's a problem that for safety reasons I maintain the ordering of dpm_list
> > > > and the callbacks are scheduled for async execution in the same order in
> > > > which they would have been executed synchronously.  If were to change this,
> > > > we'd have to be _very_ careful.
> > > 
> > > Why?  The order in which jobs are scheduled for async execution doesn't 
> > > bear any particular relation to the order in which they get run.
> > 
> > Yes, it does, if all of the async threads are busy and we add more async jobs
> > to the queue.  We must ensure that none of the jobs being executed will wait
> > for any jobs in the queue.
> 
> That's part of the reason for the dependencies: to make sure that where
> it matters, things don't run in the wrong order.
> 
> > Also, if any devices are handled synchronously, they must not wait for any
> > "async" devices that haven't been scheduled yet.
> 
> I'm not sure what you mean.  If a device is handled synchronously, it 
> must wait for all the devices preceding it on the list, regardless of 
> whether those devices are handled asynchronously.

Not really, IMO.  Namely, setting async_suspend for a device is a declaration
that all of its dependencies are known, whether they are on "async" or on
"sync" devices.  Hence, "sync" devices don't need to wait for the "async"
devices they don't depend on in a known way, because otherwise it would be
invalid to set async_suspend for those "async" devices.

Nevertheless, "sync" devices have to wait for all of the other "sync" devices
that are "in front" of them in dpm_list, because dependencies between different
"sync" devices need not be known (the direct dependencies betwee them are
known, but there may be other unknown dependencies satisfied only because the
the ordering of dpm_list is preserved).

Obviously "sync" devices have to wait for the "async" devices they depend on
in a known way.  In turn, "async" devices have to wait for all of the devices
they depend on in a known way, "sync" as well as "async".

Thanks,
Rafael
