From: David Brownell <david-b@pacbell.net>
Subject: Re: parallel suspend/resume
Date: Sun, 9 Dec 2007 21:10:23 -0800
Message-ID: <200712092110.23528.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0712071414210.27132-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0712071414210.27132-100000@netrider.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday 07 December 2007, Alan Stern wrote:
> On Fri, 7 Dec 2007, David Brownell wrote:
> 
> > > What about ordering constraints?  A lot of them aren't explicit.  We 
> > > just depend on the fact that devices get suspended in reverse order of 
> > > registration.  You can't do that in parallel.
> > 
> > Those constraints should *become* explicit ... not stay implicit!
> 
> Why do I get the feeling we've gone through this before?  :-)

Why indeed.


> > FWIW the appended patch removes that rude "order of registration"
> 
> "Rude"?  What's rude about it?  It seems most logical to me: Since the
> devices obviously worked in the intermediate stages of registration,
> ...

Rude because it keeps things implicit which should be explicit.


> > policy, so that the suspend/resume list matches the device tree.
> 
> In what respect doesn't it match the device tree now?

It's neither a depth-first nor a breadth-first traversal; it's
more of a random node visitation based on what devices were
initialized when.

Such a random visitation seems like a clear problem when a
goal is to introduce parallelism ...


> As far as I know, the only way in which the list wouldn't match the
> tree is when the tree gets reorganized by device_move(), which doesn't
> change the list at all.  (This is quite possibly a bug.)  Your patch 
> doesn't affect that.

Right, device_move() should update the list.  Different issue.


> > It's behaved OK on PCs and, in light duty, a few development boards;
> > I've carried it around most of this year.
> 
> ...  I have to agree 
> that this ordering dependency really should be made explicit.

Good.  :)


> > I'd expect this to eventually turn up some cases where Linux is
> > right now doing a bad job of exposing devices with multiple such
> > ordering constraint ... power management via I2C seems likely to
> > turn up a few of them.  We'd need some automatic way to detect
> > and report such problems so that they could be fixed.
> 
> If you really want to sniff out dependencies, you should add each new
> device to the list at a _random_ position, subject only to the
> constraint that it must not precede its parent!

Nope; what we need is the ability to finger "this specific device
has dependencies that aren't explicit".  Being able to introduce
random failures isn't really helpful.  It's the difference between
being able to use lockdep vs. having to wait until a random locking
failure crops up in a way that can usefully be diagnosed.

- Dave
