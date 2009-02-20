From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] Automatic suspend
Date: Fri, 20 Feb 2009 21:56:11 +0100
Message-ID: <200902202156.13480.rjw__3365.48759737543$1235163629$gmane$org@sisk.pl>
References: <200902192215.18365.rjw@sisk.pl> <200902201657.01145.rjw@sisk.pl>
	<f73f7ab80902200807j743a37d7hc42283bc7b9dbe6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <f73f7ab80902200807j743a37d7hc42283bc7b9dbe6f@mail.gmail.com>
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
To: Kyle Moffett <kyle@moffetthome.net>
Cc: Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday 20 February 2009, Kyle Moffett wrote:
> On Fri, Feb 20, 2009 at 10:56 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > * Introduce /sys/power/sleep that will work like /sys/power/state, but:
> >  - First, it will call ->acknowledge() for each driver (via bus types) to
> >    check if any of them wants to postpone the suspend (this will prevent tasks
> >    from being frozen unnecessarily if it is known in advance that the suspend
> >    should not happen at the moment).
> >  - Next, it will check the "I_do_not_want_automatic_suspend_to_occur" flag
> >    of each process and the suspend will be aborted if it is true for any of
> >    them (quite frankly, I think that should be integrated with the freezer,
> >    in particular the tasks that have TIF_FREEZE set shouldn't be able to set
> >    this flag and it should be checked in the freezer loop for every task with
> >    TIF_FREEZE unset).
> >  - Next, it will proceed with suspending just like /sys/power/state does (the
> >    drivers that missed the opportunity to abort the suspend by returning
> >    'false' from ->acknowledge() can still abort the suspend by failing their
> >    ->suspend() routines).
> >
> > Then, the decision making logic will be able to use /sys/power/sleep whenever
> > it wishes to and the kernel will be able to refuse to suspend if it's not
> > desirable at the moment.
> 
> Then, for a userspace process handling input events:
> 
> 1)  Unset "no-suspend flag"
> 2)  Poll event device
> 3)  When the poll returns true, set the "no-suspend flag"
> 4)  Read the event device and process the event(s)
> 5)  Go back to step 1
> 
> The event driver would responsible for atomically preventing suspend
> from the moment a button is pressed until it is actually delivered to
> a userspace process.  Since at that time the userspace process will be
> preventing suspend, there will be no window in which we could go to
> sleep with pending events.

That's correct.

How would you like to prevent it from happening?

Rafael
