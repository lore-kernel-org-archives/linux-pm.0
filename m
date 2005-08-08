From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: Re: Runtime PM and device locking
Date: Mon, 8 Aug 2005 16:41:11 +0000
Message-ID: <20050808164111.GA7276@neo.rr.com>
References: <Pine.LNX.4.50.0508081238490.26635-100000@monsoon.he.net>
	<Pine.LNX.4.44L0.0508081600010.4454-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============71688985346267087=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0508081600010.4454-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>, Patrick Mochel <mochel@digitalimplant.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============71688985346267087==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 08, 2005 at 04:03:56PM -0400, Alan Stern wrote:
> On Mon, 8 Aug 2005, Patrick Mochel wrote:
> 
> > 
> > On Sat, 6 Aug 2005, Alan Stern wrote:
> > 
> > > Brief recap: To avoid races, the RTPM code in a driver will need to
> > > lock the device while it does its work.  The locking-order
> > > requirement for dev->sem is that locks can only be acquired going
> > > _down_ the device tree: a thread that owns a child's lock may not try
> > > to lock the parent.  However RTPM involves notifications that go _up_
> > > the tree.  This makes it impossible to acquire the locks we need.
> > >
> > > There doesn't appear to be any way to make this work as stated.  So
> > > instead, we add a second semaphore to struct device: dev->power_sem.
> > > The rule for locking is that power_sem's can only be acquired going
> > > _up_ the power DAG.  In addition, if a thread holds a device's
> > > power_sem then it may not try to lock any device's regular semaphore.
> > > (That is, first lock dev->sem, then lock dev->power_sem, then go up
> > > the DAG only acquiring power_sem's.)
> > 
> > At first thought, it seems Ok with the caveat that it should go in to a
> > separate object (the power object with which to create the power DAG).
> > This should make it a bit easier to understand and follow.

Pat, I'm not using kobjects in my power object code.  If we decide it's
necessary, how should we name the power nodes?

> 
> Good -- mainly I just wanted to check that the idea wasn't totally 
> off-base.  Putting the power_sem into the power object makes sense.

This solution is very similar to the power object tree patch I'm currently
working on.  The main difference is that I'm using pre-state-change and
post-state-change notification methods.  The advantage is that we should
be able to use an iterative algorithm, allowing for deep power trees.  I'll
post code soon.

> 
> There are still one or two patches pending for USB power management.  Once 
> those have been submitted and added to Greg's tree, I'll put together 
> something that implements most of this RTPM stuff for USB.  It'll make a 
> good working example to stimulate future discussions.

I think that would be very interesting.

Thanks,
Adam

--===============71688985346267087==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============71688985346267087==--
