From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Thu, 22 Jun 2006 16:28:15 +1000
Message-ID: <1150957695.3633.29.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606211844590.5498@g5.osdl.org>
	<1150946286.947.50.camel@localhost.localdomain>
	<200606212252.31918.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606212252.31918.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


> Nope ... setpci may have been used to tweak things at runtime, and
> in ways that affect system correctness.  Admittedly that's not the
> most common scenario, but I've had to use it on some systems.
> =

> So saving PCI config space "late" is a far better approach.  It's
> hardware state that _can_ be snapshotted, with care.

Yes, well, maybe but then you have to define what "late" is ... my point
boils down to basically: if you care about the changes that can be done
to the state, then you don't want to lose them between save_state and
suspend. If you don't, you can snapshot at any time ... an early
save_state might be a _convenience_ for some drivers but I also think it
will cause confusion and breakage due to the reasons I've explained.

Thus I maintain that save_state and suspend have to be one and only
thing. One we have that, well, doing the pci config space saving there
is easy and ... it's what we already do ! funny heh ? :)

Ben.
