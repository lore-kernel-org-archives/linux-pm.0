From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] PM / Wakeup: Add missing memory barriers
Date: Wed, 26 Jan 2011 21:36:46 +0100
Message-ID: <201101262136.46577.rjw__45724.7406513945$1296074361$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1101261514280.1879-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1101261514280.1879-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, January 26, 2011, Alan Stern wrote:
> On Tue, 25 Jan 2011, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > The memory barrier in wakeup_source_deactivate() is supposed to
> > prevent the callers of pm_wakeup_pending() and pm_get_wakeup_count()
> > from seeing the new value of events_in_progress (0, in particular)
> > and the old value of event_count at the same time.  However, if
> > wakeup_source_deactivate() is executed by CPU0 and, for instance,
> > pm_wakeup_pending() is executed by CPU1, where both processors can
> > reorder operations, the memory barrier in wakeup_source_deactivate()
> > doesn't affect CPU1 which can reorder reads.  In that case CPU1 may
> > very well decide to fetch event_count before it's modified and
> > events_in_progress after it's been updated, so pm_wakeup_pending()
> > may fail to detect a wakeup event.  This issue can be addressed by
> > adding a read memory barrier in pm_wakeup_pending() that will enforce
> > events_in_progress to be read before event_count.
> > 
> > For similar reason, a read memory barrier should be added to
> > pm_get_wakeup_count().
> 
> How come this is implemented using memory barriers rather than a lock?  
> Is it because this is potentially a fairly hot path?

Yes, that's the reason.

> New memory barriers are supposed to have comments present in the code, 
> explaining why they are needed.

Of course I can add them.

> Ideally you could do away with the need for synchronization entirely.  
> For example, events_in_progress and event_count could be stored as two 
> 16-bit values stuffed into a single atomic variable.  Then they could 
> both be read or updated simultaneously.

I thought about that too, but didn't actually implement it.

Well, I guess it would be better.

Thanks,
Rafael
