From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] Automatic suspend
Date: Thu, 19 Feb 2009 13:56:51 +0100
Message-ID: <200902191356.53584.rjw__48005.0496677451$1235048422$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0902181826500.23001-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0902181826500.23001-100000@iolanthe.rowland.org>
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 19 February 2009, Alan Stern wrote:
> On Thu, 19 Feb 2009, Rafael J. Wysocki wrote:
> 
> > > If some devices are autosuspended after a local inactivity timeout, I
> > > don't want to wait for those devices to autosuspend if I know the code
> > > that needed to run is done. This could cause delays in the normal
> > > case,
> > 
> > Isn't it a matter of adjusting the inactivity timeouts in a suitable way?
> 
> It's not that simple.  A single device driver has a very local view, 
> not suitable for deciding whether the entire system should go to sleep.
> 
> So for example, a disk driver might think it's appropriate to spin down 
> the disk after 10 seconds of inactivity.  But an overall system monitor 
> might realize that nothing is going on right now and want to put the 
> system to sleep immediately, without waiting the 10 seconds for the 
> disk to autosuspend.

Now, the question is what criteria would the overall system monitor use to make
such a decision.

> > > and it could prevent suspend if a background process (not using
> > > wakelocks) is accessing a disk more frequently than its idle timeout.
> > 
> > Well, actually, shouldn't it prevent suspend from happening?  Arguably, it just
> > means that the disk is continuously being accessed with respect to the inactive
> > timeout granularity.
> 
> That's true, but it shows the problem of making the autosleep decision
> based on disk activity.  An auto-sleep should not have to wait for
> every device (or some suitable subset) to become idle for some minimum
> time; it should be able to kick in at short notice.

Again, the decision to trigger automatic suspend has to be based on some
well defined criteria and the (in)activity of devices seems to be one of them.

Thanks,
Rafael
