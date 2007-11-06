From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Add the "icebox"
Date: Tue, 6 Nov 2007 10:08:17 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0711060934260.3883-100000@iolanthe.rowland.org>
References: <200711052311.08392.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711052311.08392.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 5 Nov 2007, Rafael J. Wysocki wrote:

> On Monday, 5 of November 2007, Alan Stern wrote:
> > Rafael:
> > 
> > This patch adds the icebox, for use by kernel threads that want to 
> > freeze themselves without using the freezer -- which is likely to crop 
> > up when the freezer gets eliminated.
> > 
> > It's straightforward enough.  It could be used as-is, for example for 
> > freezing workqueue threads.  Using it for other sorts of kernel threads 
> > seems to be rather difficult, requiring a fair amount of extra code 
> > that's hard to centralize since each thread will have to be woken up 
> > its own way.
> > 
> > Do you have any particular suggestions?
> 
> I like the idea, but I think that start_icebox() should be called after
> freeze_processes().  Similarly, IMO it's better to call stop_icebox() before
> thaw_processes().

The same thought occurred to me.  But consider: If at some point we do 
remove the freezer, then freezable kernel threads will rely on the 
PM_HIBERNATION_PREPARE notification to know when they should go into 
the icebox.  Hence the icebox has to be started before the 
notifications are sent, and that means before freeze_processes.  (In 
fact, once the freezer is gone it won't even make sense to ask whether 
start_icebox comes before or after freeze_processes!)

The experience of working on this has made we wonder whether we really 
should get rid of the freezer entirely.  Even if it is kept merely for 
freezing the handful of kernel threads (not user tasks!) that want to 
be frozen, it's still likely to be more efficient that having a bunch
of independent notifier routines, each sending a particular thread to 
the icebox.  If we do keep the freezer then maybe it's okay to start 
the icebox after the notications are sent.

Alan Stern
