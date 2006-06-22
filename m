From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Thu, 22 Jun 2006 11:08:15 +1000
Message-ID: <1150938496.16303.107.camel@localhost.localdomain>
References: <20060614103404.GC28536@elf.ucw.cz>
	<1150852207.12507.30.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606201933510.5498@g5.osdl.org>
	<200606211418.16236.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606211418.16236.david-b@pacbell.net>
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
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wed, 2006-06-21 at 14:18 -0700, David Brownell wrote:
> On Tuesday 20 June 2006 7:40 pm, Linus Torvalds wrote:
> > =

> > It's not up to the driver to worry about request queues. =


Linus, You are contradicting yourself a bit I think... On one mailed,
you agreed that suspend() would happen in a "live" systems with no
quiescing of subsystems and now you say drivers shouldn't bother
blocking their request queues (or rather, stop processing them, but many
drivers handle their own requests queueing mecanism, if at all, against,
that term encompass both real "request queues" in the block driver
sense, packet queues in network drivers, ioctls, other callbakcs like
set_multicast_filter or whatever ramdom things that can be called by
your subsystem or as the result of userland actions).

> Maybe for block drivers.  But USB and network controller drivers
> are fundamentally about managing request queues, by collaborating
> with upper level drivers.

Yes and the upper level, in the case of ethernet drivers for example,
provides a very simple way of managing that queue. A single call blocks
it and properly synchronizes with the xmit callback. You still need to
be careful with ioctl, set_multicast/mac/... etc... though but you have
to anyway.

> Alternatively, you may be observing that just like block queues
> are managed by the upper layer code, so are USB queues managed
> by the usb_driver entities that freeze their own contributions,
> like network interfaces manage their network queues.  (Though in
> both cases the controller drivers must still wait for queues to
> empty before they are fully quiesced).

Block queues aren't entirely managed by upper layers neither

Ben.
