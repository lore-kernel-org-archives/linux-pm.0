From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update 3] PM: Introduce core framework for
 run-time PM of I/O devices
Date: Tue, 23 Jun 2009 14:26:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906231408370.3209-100000__23291.617880068$1245781646$gmane$org@iolanthe.rowland.org>
References: <200906231945.35074.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906231945.35074.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Tue, 23 Jun 2009, Rafael J. Wysocki wrote:

> In short, I think suspending (or queuing a suspend request) should fail if the
> usage counter is nonzero, but the resuming (or queuing up a resume request)
> should be possible regardless of its value.  The reason is that multiple
> threads may in theory attempt to resume the device at the same time.

Agreed.  Suspends and resumes aren't symmetrical -- a single resume 
request must outweigh numerous suspend requests.

> However, I'm not sure if the core should manipulate the usage counter by
> itself, because it's sort of problematic (there's no good approach to decide
> when to decrement the counter).

Yes.  The idea behind my previous message was that it's not really so
easy for the core to decide when to _increment_ the counter either.

> So, I'd let the callers use pm_runtime_get() to increment the counter
> and pm_runtime_put() to decrement it, possibly queuing up an idle notification
> if the counter happens to reach 0.  Also, I'm not sure if unbalanced
> pm_runtime_put() should be regarded as a bug.

It should be.  Once the counter is messed up, runtime PM wouldn't be
able to work properly.  But maybe you should add a pm_set_counter call
so that drivers can recover from imbalances.

One question still remains: If the counter is 0 at the end of a
successful pm_runtime_resume, should the core then call pm_notify_idle?  
Or should we make the driver responsible for that too?

> At the same time, I'd like the core to use runtime_status and the other
> fields in dev_pm_info, except for the usage counter, to ensure that all
> operations are only carried out when it makes sense.

Yes.  In fact, I'd say that when the counter is positive it doesn't
make sense to allow a runtime suspend -- so you don't need that
exception in your statement above.  :-)

Alan Stern
