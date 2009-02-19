From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFD] Automatic suspend
Date: Thu, 19 Feb 2009 09:59:41 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902190956570.3012-100000__17545.5325436362$1235056247$gmane$org@iolanthe.rowland.org>
References: <200902191356.53584.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902191356.53584.rjw@sisk.pl>
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 19 Feb 2009, Rafael J. Wysocki wrote:

> On Thursday 19 February 2009, Alan Stern wrote:
> > On Thu, 19 Feb 2009, Rafael J. Wysocki wrote:
> > 
> > > > If some devices are autosuspended after a local inactivity timeout, I
> > > > don't want to wait for those devices to autosuspend if I know the code
> > > > that needed to run is done. This could cause delays in the normal
> > > > case,
> > > 
> > > Isn't it a matter of adjusting the inactivity timeouts in a suitable way?
> > 
> > It's not that simple.  A single device driver has a very local view, 
> > not suitable for deciding whether the entire system should go to sleep.
> > 
> > So for example, a disk driver might think it's appropriate to spin down 
> > the disk after 10 seconds of inactivity.  But an overall system monitor 
> > might realize that nothing is going on right now and want to put the 
> > system to sleep immediately, without waiting the 10 seconds for the 
> > disk to autosuspend.
> 
> Now, the question is what criteria would the overall system monitor use to make
> such a decision.
> 
> > > > and it could prevent suspend if a background process (not using
> > > > wakelocks) is accessing a disk more frequently than its idle timeout.
> > > 
> > > Well, actually, shouldn't it prevent suspend from happening?  Arguably, it just
> > > means that the disk is continuously being accessed with respect to the inactive
> > > timeout granularity.
> > 
> > That's true, but it shows the problem of making the autosleep decision
> > based on disk activity.  An auto-sleep should not have to wait for
> > every device (or some suitable subset) to become idle for some minimum
> > time; it should be able to kick in at short notice.
> 
> Again, the decision to trigger automatic suspend has to be based on some
> well defined criteria and the (in)activity of devices seems to be one of them.

I don't know what criteria the system monitor would use.  It might have 
to be platform-specific.  The Android people seem to have a pretty good 
idea of what criteria will work for them.

Inactivity of devices isn't always a good criterion.  There might be a
background task which wakes up every few seconds to do something as
long as the system is awake, thereby keeping some device always active.  
The activity from this background task shouldn't prevent an auto-sleep.

Alan Stern
