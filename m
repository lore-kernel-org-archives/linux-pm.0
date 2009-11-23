From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime resume of children
Date: Mon, 23 Nov 2009 21:44:31 +0100
Message-ID: <200911232144.31499.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0911221642110.31173-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0911221642110.31173-100000@netrider.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 22 November 2009, Alan Stern wrote:
> Rafael:
> 
> Here's the situation.  Device A has children B1, ..., Bn (possibly
> others too).  I need to guarantee that whenever A is active, so are the
> children.

But it's perfectly valid to have an inactive device under an active parent, so
I guess this is not a general case.

> One direction seems easy enough.  I can make the idle handler for the
> B's first check that A and all the B's are ready to be suspended, then
> suspend all the B's, and then suspend A.  This works because the PM and 
> driver cores never directly suspend a device; all the do is notify the 
> idle handler.
> 
> The other direction is a little more complicated.  Resumes initiated by
> the bus code aren't troublesome; they can always be written so as to
> resume the B's along with the A's.  The real problem arises when A is
> resumed directly by the PM or driver cores.  For example, consider what
> would happen when one of B1's children sends a remote wakeup signal.  
> The PM core would automatically resume B1 and A, but there would be no
> chance for the bus code to resume the other B's.

pm_runtime_resume() schedules an idle request for 'dev' at the end,
which theoretically may resume the B's that are still suspended.  There still
would be a delay, though.

> I can't make the runtime_resume method for A call pm_runtime_resume()  
> for all the B's.  It would deadlock inside __pm_runtime_resume() where
> the code to resume B1 waits for A's resume to complete.
> 
> Calling pm_request_resume() for all the B's instead isn't a very good
> solution.  For one thing, it's silly to add latency by using a work
> queue instead of just doing the resumes directly.  There are also
> problems of synchronization, such as the fact that other code expects
> all the B's to be resumed when A's resume completes.
> 
> Do you have any ideas on how to approach this?  How about allowing A's
> runtime_resume method to set A->power.runtime_status to RPM_ACTIVE,
> before it tries to resume the B's?  That would avoid the deadlock.

I don't see a problem with that as long as the A's runtime_resume returns 0 in
such a case.

Thanks,
Rafael
