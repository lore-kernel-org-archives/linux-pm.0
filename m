From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Changes to Runtime PM
Date: Fri, 10 Sep 2010 21:37:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009102131210.14441-100000@netrider.rowland.org>
References: <201009110028.51857.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009110028.51857.rjw@sisk.pl>
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

On Sat, 11 Sep 2010, Rafael J. Wysocki wrote:

> > > > 	First check for things that make the function impossible:
> > > > 	power.runtime_error set, usage_count or child_count set
> > > > 	wrong, or disable_depth > 0.  If these checks fail, return
> > > > 	immediately.
> > > 
> > > OK
> > > 
> > > > 	Then check the current status and the pending requests to
> > > > 	see if they rule out the current function:
> > > > 
> > > > 		idle is allowed only in RPM_ACTIVE and when there
> > > > 		are no pending requests (but the suspend timer can
> > > > 		be running);
> > > > 
> > > > 		suspend is not allowed if the status is RPM_SUSPENDED
> > > > 		or RPM_RESUMING, or if there is a pending resume
> > > > 		(either a request or a deferred resume);
> > > > 
> > > > 		resume is not allowed if the status is RPM_ACTIVE.
> > > 
> > > OK, but that need not apply to the _ldle() variants.
> > 
> > I don't understand.  Are you referring to the "idle is allowed only..." 
> > paragraph above?  What's the connection with resume?
> 
> Sorry, I thought *_request_*() and wrote _idle().  Must be too tired. :-)

I'm still not sure what you mean.  I meant those conditions to apply to
both the synchronous and asynchronous calls (except of course that we
will allow async suspend if the status is RPM_RESUMING).  Did you have
something else is mind?

Alan Stern
