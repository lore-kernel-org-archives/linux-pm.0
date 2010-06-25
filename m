From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [update 2] Re: [RFC][PATCH] PM: Avoid losing wakeup
 events during suspend
Date: Fri, 25 Jun 2010 11:09:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006251056430.1604-100000__3078.78279495544$1277478643$gmane$org@iolanthe.rowland.org>
References: <201006250106.41855.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006250106.41855.rjw@sisk.pl>
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
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 25 Jun 2010, Rafael J. Wysocki wrote:

> > That's not the point.  If a wakeup handler queues a work item (for
> > example, by calling pm_request_resume) then it wouldn't need to guess a
> > timeout.  The work item would be guaranteed to run before the system
> > could suspend again.
> 
> You seem to be referring to the PM workqueue specifically.  Perhaps it would be
> better to special-case it and stop it by adding a barrier work during suspend
> instead of just freezing?  Then, it wouldn't need to be singlethread any more.

The barrier work would have to be queued to each CPU's thread.  That
would be okay.

Hmm, it looks like wait_event_freezable() and
wait_event_freezable_timeout() could use similar changes: If the
condition is true then they shouldn't try to freeze the caller.

> Still, I think the timeout is necessary anyway in case the driver simply
> doesn't handle the event and user space needs time to catch up.  Unfortunately,
> the PCI wakeup code doesn't know what happens next in advance.

That could all be handled by the lower driver.  Still, a 100-ms timeout
isn't going to make a significant difference, since a suspend/resume 
cycle will take a comparable length of time.

Alan Stern
