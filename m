From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Fri, 16 Jun 2006 11:21:59 +1000
Message-ID: <1150420919.7725.75.camel@localhost.localdomain>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606141846.55839.david-b@pacbell.net>
	<20060615084153.GC9423@elf.ucw.cz>
	<200606150957.42449.david-b@pacbell.net>
	<20060615180350.GG23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606151125060.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606151125060.5498@g5.osdl.org>
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


> And we currently don't have _anything_ like that. Playing games with =

> sending different commands down the "suspend()" thing is not ever going t=
o =

> work. Drivers are going to do it wrong. We really need to add a =

> "save_state()" callback, and it needs to be called that, so that people =

> realize that they should not suspend in it.
> =

> It would actually simplify and clarify a lot of the confusion we have now=
. =


But how can you save a sate and use it for resume if the device can
still operate on further requests ? Your state won't be consistent
anymore... the state your resume function will get will _not_ match the
last known hardware state. Pretty annoying.

Also that means that for things like STD and kexec, you still need a
second step "suspend" phase to actually stop DMAs which involve stopping
processing.

> I already fixed one driver (sky2) that simply didn't save it's PCI state, =

> it just suspended (and then in resume it tried to "restore" the state =

> that had never been saved). And I _bet_ that was because it's just a very =

> natural thing to do when you look at "suspend()" as an independent op.

Network drivers rarely need to save anything :) Most of their state is
in the netdev structure (MAC address, multicast filters, etc...) thus
it's in many case fairly easy to just restore the whole driver from that
without needing a specific state saving phase.

> So it's actually important - _especially_ for device drivers - to have =

> logical and _distinct_ operations, because device driver writers seldom =

> see the big picture. But if you tell a device driver writer that he needs =

> to save the state, he'll understand that. He might even understand the =

> notion of shutting down the receive side for devices that need it. But if =

> you tell a device driver writer that they need to write a "suspend" =

> function, that's exactly what he will do.

As long as you explain me how my saves state gets _any_ kind of
relevance if it's not atomically stopping any activity on that driver
that will invalidate the saved state.

Ben.
