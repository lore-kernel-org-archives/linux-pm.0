From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: allow runtime_suspend methods to call
	pm_schedule_suspend
Date: Fri, 19 Mar 2010 21:49:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1003192149060.26600-100000@netrider.rowland.org>
References: <201003192225.59192.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003192225.59192.rjw@sisk.pl>
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

On Fri, 19 Mar 2010, Rafael J. Wysocki wrote:

> On Friday 19 March 2010, Alan Stern wrote:
> > This patch (as1361) changes the runtime PM interface slightly; it
> > allows suspend requests to be scheduled while the runtime_suspend
> > method is running.  If the method succeeds then the scheduled request
> > is cancelled, whereas if the method fails then an idle notification is
> > sent only if no request was scheduled.
> > 
> > Being able to schedule suspend requests from within a runtime_suspend
> > method is useful for drivers that need to test for idleness and
> > suspend the device all while holding a single spinlock, or for drivers
> > that want to check for idleness by polling.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Looks good.
> 
> Do you need it in 2.6.34 or is it sufficient to queue it up for 2.6.35 (I'd prefer so)?

2.6.35 is good enough.

Alan Stern
