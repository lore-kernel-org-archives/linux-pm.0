From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Toward runtime power management in Linux
Date: Tue, 2 Aug 2005 10:35:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0508021018440.4931-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.50.0508012316380.2764-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============93507733801138926=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0508012316380.2764-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============93507733801138926==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 1 Aug 2005, Patrick Mochel wrote:

> > I agree that a parent may have to cope with situations where two children
> > are trying to change state at the same time.  struct device->semaphore
> > should help there.  This doesn't affect what I wrote, however.  Link-state
> > changes don't involve races, because a link state describes the
> > connection between one specific parent and one specific child.  If two
> > different links change state at the same time, that's not a race.
> 
> For two children changing state at the same time, it is not a race. But,
> there could be potentially racy conditions when notifying the parent.
> Maybe. As I think about it more, I'm not sure it's possible to get mixed
> up, since there should always be _some_ delay between a parent receiving a
> notification that a child has suspended and the parent actually suspending
> itself.

This is why we want the driver to lock the parent before notifying it.  
And since the driver will already be holding the child's lock, this is a 
case where we need to acquire locks in the wrong order (going up the 
tree).

> > Me neither.  In fact, I would go so far as to say that this is the main
> > impediment to RTPM implementations at the moment.  If I knew the answer to
> > the locking-order problem, I could fix up the USB RTPM code right now.
> 
> What exactly is the impediment? The locking constraints?

Yes.  In a separate message you worried about what happens when there are 
multiple parents.  I don't see that being a problem here, because for 
power-state notifications we will only need to lock one parent at a time:
the one currently being notified.

Right now I'm leaning toward a solution that explicitly allows acquiring
locks in either order (up or down), with the proviso that a process trying
to lock upward will lose if another process is trying to lock the same
devices downward.  That is, if A > B, P1 has locked A, P2 has locked B,
and P2 is trying to lock A while P1 is trying to lock B, then P2's locking
attempt will fail rather than block.  That should be sufficient to avoid 
deadlock.

I think this is the sort of behavior we want to see.  Lock acquisition
going down the tree tends to be for more important reasons, like unbinding
drivers and unregistering devices.  Lock acquisition going up tends to be
for less important things (like RTPM) which will usually be made
irrelevant by the downward-going process anyhow.  After all, there's no
point having a thread trying to change a power state block another thread
that wants to unregister the device!

Now I just need to come up with a clean way to implement it...

Alan Stern


--===============93507733801138926==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============93507733801138926==--
