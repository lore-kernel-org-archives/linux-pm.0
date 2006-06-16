From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Sat, 17 Jun 2006 09:05:27 +1000
Message-ID: <1150499128.23600.74.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606151047410.6879-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0606151047410.6879-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org


> One way to allow for a two-phase suspend would be like this:
> =

> * FREEZE all devices
> * Snapshot
> * UNFREEZE all devices (perhaps skip some devices, although I don't
> 	know how you could determine which ones)
> * Write image to disk
> * Send PRESUSPEND message to all devices (they can treat it like SUSPEND
> 	or like FREEZE, or they can ignore it if they want)
> * SUSPEND all devices
> =

> The two-phase part being the last two steps.

The prepare-for-suspend that Linus and I have discussed should happen
before the freeze loop (and finish at the very end of wakeup). It
enclose the entire suspend/resume processing imho.

Ben
