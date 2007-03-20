From: David Brownell <david-b@pacbell.net>
Subject: Re: Alternative Concept
Date: Tue, 20 Mar 2007 16:29:33 -0700
Message-ID: <200703201629.34032.david-b@pacbell.net>
References: <200703182104.27555.david-b@pacbell.net>
	<200703201504.47956.david-b@pacbell.net>
	<20070320220632.GK3545@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070320220632.GK3545@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 20 March 2007 3:06 pm, Pavel Machek wrote:
> Hi!
> =

> > > But we do not want new subsystem. We want power management to
> > > work. Take a look how Alan added pm to usb... and just do it like
> > > him. If some code makes sense to be shared, share it. But start with
> > > support for platform you care about and don't overdesign it.
> > =

> > Note, Alan didn't do it by himself.  The autosuspend stuff built on
> > previous work in USB PM, and this DID get discussed -- as concrete
> > proposals -- before he did all that good stuff.
> =

> Okay, you are right. But I do not remember any "handwaving"
> phase... (And sorry for not giving credit where it was due, obviously
> Alan did not do it all by himself).

No, I don't think there was a handwaving phase there either.

There were specific problems to be addressed, and specific solutions
came out of discussions of how to address them.  (Which is not at all
the way these "concept" discusions have gone.)

I think the canonical example was one I first heard from Len Brown a
few years back:  laptop with USB mouse.  If that mouse can (auto)suspend,
with remote wakeup to kick it out of that state, then the USB host
controller doesn't need be active.  If that controller isn't doing DMA
every millisecond, the CPU can enter C3.  So the savings cascade in a
very clean way, once all the parts are present.

To get there, first we needed USB suspend, and remote wakeup, to work.
That was a bunch of work.  Then we needed proper "runtime suspend" to
behave for the host controller drivers too.  More work ... they all
had to act the same.  (I'd say that work first started around the time
of the 2.6.9 kernels...)  Once all that was stable, the autosuspend
work could begin.


All this "alternative concept" stuff seems to be starting from the
"big piece of blank paper, and dreams" school of design.

- Dave
