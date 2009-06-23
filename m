From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch update 3] PM: Introduce core framework for
	run-time PM of I/O devices
Date: Tue, 23 Jun 2009 19:45:33 +0200
Message-ID: <200906231945.35074.rjw__32054.5763163411$1245779247$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906231043290.3209-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906231043290.3209-100000@iolanthe.rowland.org>
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

On Tuesday 23 June 2009, Alan Stern wrote:
> On Mon, 22 Jun 2009, Rafael J. Wysocki wrote:
> 
> > > And of course, synchronous pm_runtime_resume should always increment the 
> > > counter.
> > 
> > Sure.
> 
> Now that I've thought about it some more, I decided that we might want
> to be more flexible.  Without subjecting you to the entire line of
> reasoning, let's just say that I'm starting to wonder whether it's such
> a good idea to tie the counter increments to the PM core runtime resume
> calls at all.
> 
> Maybe it would be better (easier to use, less constraining) to require
> the runtime_resume callback to do its own pm_runtime_get.  That way the
> driver would be entirely responsible for managing the usage counter;
> the PM core wouldn't be involved.  pm_runtime_get would simply
> increment the counter, so it could be used even in interrupt context.  
> At the moment, I don't see any need for it to queue an autoresume
> request if the device happens to be suspended.
> 
> Something like this was probably your intention all along.  :-)

More or less. :-)

In short, I think suspending (or queuing a suspend request) should fail if the
usage counter is nonzero, but the resuming (or queuing up a resume request)
should be possible regardless of its value.  The reason is that multiple
threads may in theory attempt to resume the device at the same time.

However, I'm not sure if the core should manipulate the usage counter by
itself, because it's sort of problematic (there's no good approach to decide
when to decrement the counter).

So, I'd let the callers use pm_runtime_get() to increment the counter
and pm_runtime_put() to decrement it, possibly queuing up an idle notification
if the counter happens to reach 0.  Also, I'm not sure if unbalanced
pm_runtime_put() should be regarded as a bug.

At the same time, I'd like the core to use runtime_status and the other
fields in dev_pm_info, except for the usage counter, to ensure that all
operations are only carried out when it makes sense.

Best,
Rafael
