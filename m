From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Runtime PM: Calling Device runtime PM callbacks?
Date: Mon, 14 Dec 2009 18:09:01 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912141805170.2690-100000@iolanthe.rowland.org>
References: <200912142328.15796.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912142328.15796.rjw@sisk.pl>
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

> > > > > ->runtime_idle() is still only called for the device's bus type, because
> > > > > otherwise it will be hard to determine the right ordering of the bus type,
> > > > > device type and device class callbacks.
> > > > 
> > > > Shouldn't it be the same as runtime_suspend and runtime_resume?
> > > 
> > > Well, the ordering is different in each of them ...
> > 
> > Why not just copy the order used by device_suspend(): class, then type,
> > then bus?
> 
> Do you mean in _idle?

Idle is very similar to suspend.  They should use the same order.

I guess there's one extra thing to look out for: If one of the idle
callbacks does pm_runtime_suspend() then there's no point invoking the
later callbacks.

> > Actually, I don't know of any cases where the order matters.  But there 
> > may be some, for system suspend.  Runtime suspend is new enough that 
> > people will adapt.
> 
> Still, calling them in the reverse order in resume is kind of logical ...

Yes.

Alan Stern
