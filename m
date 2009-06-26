From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch update] PM: Introduce core framework for
	run-time PM of I/O devices (rev. 6)
Date: Sat, 27 Jun 2009 00:32:44 +0200
Message-ID: <200906270032.45290.rjw__27165.8677644611$1246055583$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906261707260.4155-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906261707260.4155-100000@iolanthe.rowland.org>
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

On Friday 26 June 2009, Alan Stern wrote:
> On Fri, 26 Jun 2009, Rafael J. Wysocki wrote:
> 
> > > It occurs to me that the problem would be solved if were a cancel_work
> > > routine.  In the same vein, it ought to be possible for
> > > cancel_delayed_work to run in interrupt context.  I'll see what can be
> > > done.
> > 
> > Having looked at the workqueue code I'm not sure if there's a way to implement
> > that in a non-racy way.  Which may be the reason why there are no such
> > functions already. :-)
> 
> Well, I'll give it a try.
> 
> Speaking of races, have you noticed that the way power.work_done gets 
> used is racy?

Not really. :-)

> You can't wait for the completion before releasing the 
> lock, but then anything could happen.
> 
> A safer approach would be to use a wait_queue.

I'm not sure what you mean exactly.  What's the race?

> > In the meantime I reworked the patch (below) to use more RPM_* flags and I
> > removed the runtime_break and runtime_notify bits from it.  Also added some
> > comments to explain some non-obvious steps (hope that helps).
> > 
> > I also added the pm_runtime_put_atomic() and pm_runtime_put() as per the
> > comment above.
> > 
> > It seems to be a bit cleaner this way, but that's my personal view. :-)
> 
> I'll look at it over the weekend.  And I'll try to see if proper 
> cancel_work and cancel_delayed_work functions can help clean it up.

Great, thanks!

Best,
Rafael
