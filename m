From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 16:30:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606151625360.8641-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.64.0606151235380.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606151235380.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, 15 Jun 2006, Linus Torvalds wrote:

> Suspending a device before everybody else has saved their state is =

> fundamentally and deeply wrong. You do not know whether other devices =

> might need that device for their state save. =

> =

> You may, for example, have devices that literally have so much state that =

> they need user help to save it - which in turn means that they must be =

> saved before you have suspended other and UNRELATED devices. X itself is =

> actually an example of this, but so might be anything with firmware, for =

> example).

If this happens you're already in trouble.  It doesn't matter that the =

unrelated devices aren't suspended; the fact that they have already saved =

their state and will no longer respond to outside stimuli means they can't =

be used.  Not to mention that their I/O queues won't be running.

Suppose a driver needs to store its state info on a networked drive and =

the network interface has already saved _its_ state?  Or it needs to =

access a USB drive and the USB controller is no longer doing DMA?

There is a clear need for a partial ordering of devices.  If device A =

needs to use device B to save its state, then A's state must be saved =

before B's.

Alan Stern
