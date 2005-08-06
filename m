From: Alan Stern <stern@rowland.harvard.edu>
Subject: Runtime PM and device locking
Date: Sat, 6 Aug 2005 15:28:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0508061527220.5101-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============66789008369642744=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============66789008369642744==
Content-Type: TEXT/PLAIN; charset=US-ASCII

Pat:

After considerable thought, this is the only way I can figure out to
handle device locking while doing runtime PM (RTPM).

Brief recap: To avoid races, the RTPM code in a driver will need to
lock the device while it does its work.  The locking-order
requirement for dev->sem is that locks can only be acquired going
_down_ the device tree: a thread that owns a child's lock may not try
to lock the parent.  However RTPM involves notifications that go _up_
the tree.  This makes it impossible to acquire the locks we need.

There doesn't appear to be any way to make this work as stated.  So
instead, we add a second semaphore to struct device: dev->power_sem.
The rule for locking is that power_sem's can only be acquired going
_up_ the power DAG.  In addition, if a thread holds a device's
power_sem then it may not try to lock any device's regular semaphore.
(That is, first lock dev->sem, then lock dev->power_sem, then go up
the DAG only acquiring power_sem's.)

If a driver needs to prevent power changes while it's doing some other
work, it must lock dev->power_sem.  That's not so bad.  However it
must release power_sem before doing anything that would affect the
device's children.  It can safely hold dev->sem the whole time.
However an RTPM notification routine can never acquire dev->sem.

The lack of full synchronization between RTPM notifications and other
activities means we need a few special precautions.  In particular, we
have to worry about a notification racing with an unbind.  To prevent
such races, we will need to add to struct device a field that
indicates the condition of driver binding: UNBOUND, BINDING, BOUND, or
UNBINDING.  (There already is a private field like this in USB's
struct interface.)  When sending a notification, a process must
acquire parent->power_sem and then immediately check to see whether
the parent's condition is UNBINDING or UNBOUND.  If it is then the
process must release parent->power_sem without trying to send the
notification.  Of course, we can create helper functions to care of
these things.

There will be a lot of tricky details, but I think it can be made to
work.  What's your opinion?

Alan Stern


--===============66789008369642744==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============66789008369642744==--
