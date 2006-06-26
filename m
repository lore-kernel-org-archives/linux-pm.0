From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sun, 25 Jun 2006 17:16:49 -0700
Message-ID: <200606251716.49893.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<1151150259.15365.316.camel@localhost.localdomain>
	<20060625230335.GA2519@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060625230335.GA2519@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Sunday 25 June 2006 4:03 pm, Pavel Machek wrote:

> Actually, what you are doing is _not_ suspend-to-RAM. You are doing
> (trying to do?) very advanced kind of runtime power management on PC
> platform (that happens to use S3).

What Jim said ... nothing about that wireless stuff is special.
You can do _exactly_ the same thing today, as follows:

  - Linux-USB peripheral, using "gadget" stack, running wireless
    hardware and software to do the routing, and supporting remote
    wakeup of the host;

  - Linux USB host, telling that peripheral to enter the USB suspend
    state and enabling remote wakeup for when a WLAN packet should
    be sent to the USB host.

The essential difference is just that the USB peripheral firmware
in the Broadcom thing is likely not using Linux for its RTOS.

Similarly with the display ... nothing prevents suspend states
from leaving a display on if that's more appropriate.


That said, it might be more appropriate to view the host side
sleep state as a "standby" (S1) than "suspend to RAM" (S3) in
the cases where quick wakeup is a priority.  (To ACPI, the speed
of those transitions is a key differentiator.)  And of course, the
fact that ACPI defines (very loosely!) S1 and S3 doesn't mean
there aren't a whole collection of S1 and S3 states that a
given hardware platform could define and use.

- Dave
