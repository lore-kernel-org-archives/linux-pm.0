From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Add the "icebox"
Date: Wed, 7 Nov 2007 10:47:14 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0711071036540.4444-100000@iolanthe.rowland.org>
References: <1194425920.4055.1.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1194425920.4055.1.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 7 Nov 2007, Johannes Berg wrote:

> > This patch adds the icebox, for use by kernel threads that want to 
> > freeze themselves without using the freezer -- which is likely to crop 
> > up when the freezer gets eliminated.
> 
> There obviously isn't a way to wait for all tasks that want to enter the
> icebox since there's no task flag for this, will tasks need to add extra
> locking? Or otherwise how do we make sure that a task hasn't *just* gone
> past icebox() and starts executing the code that the icebox() is
> supposed to prevent?

The idea was that kernel threads would have a PM-notifier routine and
would be sent to the icebox when the routine gets a
PM_{HIBERNATION|SUSPEND|RESTORE}_PREPARE message.  Presumably the
notifier routine wouldn't return until the thread was safely on its way
to the icebox.

You are correct that this would require some additional locking, plus 
the extra notifier routine, plus ways to handle timeouts, plus maybe 
some other stuff.  That's why I said in my earlier message that 
keeping the freezer around for these sorts of threads would be a good 
idea -- it would avoid all this new overhead.

The icebox would still be useful, however, for user tasks that try to
do I/O after a system-sleep transition has begun.  Right now this can't
happen, thanks to the freezer (except that it _can_ happen on PPC where
the freezer isn't used for suspend).  Once the freezer no longer
affects user tasks, kernel drivers will have to do _something_ when a
user task submits an I/O request during a system sleep.  That
"something" will be to go to the icebox.

Alan Stern
