From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Fri, 25 Aug 2006 23:27:12 +0200
Message-ID: <20060825212712.GG9568@elf.ucw.cz>
References: <EA12F909C0431D458B9D18A176BEE4A5074D04EE@dlee02.ent.ti.com>
	<Pine.LNX.4.44L0.0608251627460.3307-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0608251627460.3307-100000@netrider.rowland.org>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > The frequency of entering this state should not interfere with my active
> > use case.
> > =

> > -B- After I've put down the USB device, I now can program the internal
> > SOC bus wrapper for the USB to allow idling of the interconnect.  I also
> > need to associate the USB remote wake interrupt with a wake up interrupt
> > to restart my interconnect.  All devices on that interconnect must be in
> > the same state for the big savings to happen.
> > =

> > Certainly for this embedded system, not coordinating the device states
> > means I can't get the big power savings.
> =

> Part of this programming has to be done in the architecture-specific
> driver for the interconnect.  There already is code being developed to
> suspend USB buses when they aren't in use (although determining _when_
> they aren't in use has not yet been implemented).  However this code
> stops

Are there some patches to test? I'd like to power down USB bus, even
when it has device connected (I do not user fingerprint scanner that
much).
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
