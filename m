From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 28 Jun 2006 16:38:02 -0700
Message-ID: <200606281638.03395.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606251716.49893.david-b@pacbell.net>
	<20060628221617.GB22852@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060628221617.GB22852@elf.ucw.cz>
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

On Wednesday 28 June 2006 3:16 pm, Pavel Machek wrote:
> =

> ...but leaving machine "suspended" with display running (and
> pressumably keyboard still reactive to keypresses) is really a bit
> different from "normal" suspend-to-RAM.

Keyboard reactive is just normal wakeup event processing.  Of course,
we have pretty lousy support for wakeup events in Linux just now.  :(

Although I'm glad to say that at least for USB, wakeup events are
basically working, and the main gaps are in platform support (which
unfortunately includes ACPI).  It would still be nice to see things
like non-USB keyboards and mice be wakeup event sources though.
And of course, S1 and S3 states working ...


> Yes, S1 is probably right description of above state. IIRC I seen
> machines that left dispaly ON in S1...

I don't seem to recall seeing the ACPI spec laying down requirements
about displays.  Those should be platform-specific.   That would be
epecially true of non-ACPI systems, which get to define "standby"
and "STR" states to suit.  (And I'd kind of hope the system that Jim
sketched isn't relying on ACPI!)

- Dave
