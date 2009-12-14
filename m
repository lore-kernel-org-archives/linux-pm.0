From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Runtime PM: Calling Device runtime PM callbacks?
Date: Mon, 14 Dec 2009 17:08:28 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912141703330.2690-100000@iolanthe.rowland.org>
References: <200912142257.40100.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912142257.40100.rjw@sisk.pl>
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
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 14 Dec 2009, Rafael J. Wysocki wrote:

> On Monday 14 December 2009, Alan Stern wrote:
> > On Mon, 14 Dec 2009, Rafael J. Wysocki wrote:
> > 
> > > There you go (untested for now).
> > > 
> > > ->runtime_idle() is still only called for the device's bus type, because
> > > otherwise it will be hard to determine the right ordering of the bus type,
> > > device type and device class callbacks.
> > 
> > Shouldn't it be the same as runtime_suspend and runtime_resume?
> 
> Well, the ordering is different in each of them ...

Why not just copy the order used by device_suspend(): class, then type,
then bus?

Actually, I don't know of any cases where the order matters.  But there 
may be some, for system suspend.  Runtime suspend is new enough that 
people will adapt.

> > What's the reason for error_ptr here?  Its value will always be the
> > same as the return value except in the case where none of the callbacks
> > are defined.  Why not just use -ENOSYS in that case and eliminate
> > error_ptr?
> 
> To preserve the existing logic.
> 
> Namely, without the patch dev->power.runtime error is not updated in the
> -ENOSYS case and that actually is for a reason (we don't want runtime_error to
> be set merely because there's no callbacks to execute).  I could check the
> return value, but what if one of the callbacks returns -ENOSYS?

Don't worry about it.  -ENOSYS means the operation isn't implemented.  
So if somebody's method implementation tells you that the method isn't 
implemented, they'll get what they deserve.  :-)

Alan Stern
