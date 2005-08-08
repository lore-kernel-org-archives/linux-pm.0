From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Runtime PM and device locking
Date: Mon, 8 Aug 2005 16:58:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0508081645010.4470-100000@iolanthe.rowland.org>
References: <20050808164111.GA7276@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============40789872883406875=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050808164111.GA7276@neo.rr.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============40789872883406875==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 8 Aug 2005, Adam Belay wrote:

> This solution is very similar to the power object tree patch I'm currently
> working on.  The main difference is that I'm using pre-state-change and
> post-state-change notification methods.  The advantage is that we should
> be able to use an iterative algorithm, allowing for deep power trees.  I'll
> post code soon.

I'm looking forward to seeing it.  However, I think an iterative algorithm 
may be impractical, to a greater or lesser extent.  (Not to mention the 
fact that in any particular case we never need both pre- and post- 
notifications.)

Consider a device that has many power parents (P1 - Pn).  A typical 
power-state change for this device might have to go like this:

	Do something to the device.

	Notify P1.

	Do some more to the device.

	Notify P2.

	Do some more to the device.

	...

	Notify Pn.

	Do the last thing to the device.

It's awkward enough as straight-line code.  If you were to use an 
iterative algorithm, the driver would need to include n-1 otherwise 
useless intermediate states: the state where P2 needs to be notified, ..., 
the state where Pn needs to be notified.  I would prefer to avoid putting 
that kind of burden on driver authors.  Then there's the question of how 
you handle an error return from Pk, for some k <= n.

Also, I've been assuming that the implementation of the notification
methods would not be generic -- it would be different for each type of
bus.  For instance, USB already has routines that come close to being
these notifications: usb_suspend_device and usb_resume_device.  In
general, different buses will need to know different things about power
changes in their children.  This makes it hard to come up with a common
function prototype or format, and makes it hard to use an iterative
algorithm.

Alan Stern


--===============40789872883406875==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============40789872883406875==--
