From: David Brownell <david-b@pacbell.net>
Subject: Re: Alternative Concept
Date: Tue, 20 Mar 2007 14:03:10 -0700
Message-ID: <200703201403.11846.david-b@pacbell.net>
References: <44ECFF94.3030506@gmail.com> <45FFD004.9030507@gmail.com>
	<1174394360.25744.45.camel@Dogbert.NOE.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174394360.25744.45.camel@Dogbert.NOE.nokia.com>
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
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Tuesday 20 March 2007 5:39 am, Igor Stoppa wrote:

> No, the point is that by default every driver would try to go to the
> lowest power state autonomously.

Yes.  Anyone assuming otherwise should go back to the drawing board,
since so much of the most relevant information will BY DESIGN never
be exposed outside that driver.  And must not be, since each version
of silicon will generally have its own localized quirks.


Plus there may be groups of drivers that work together.  SOC audio
is probably a decent example:  the high level driver presents just
playback and record interfaces, but internally there will be several
busses involved, a SOC-specific serial data stream controller (AC97,
McBSP, I2S, etc), an external codec, and control interfaces which
manage each of those.  That means a couple drivers collaborating...
(I have no idea if this new ALSA SOC support stuff is sanely design
from a PM perspective...)

The same thing comes up with some USB OTG configurations too.
For example, on OMAP1 or PXA27x chips, there are three on-chip
controllers (OHCI, UDC, OTG) plus an external (I2C) transceiver.
That's three or four drivers which must work together to make
sure power isn't needlessly wasted.

But in all those cases, all the PM-relevant information is local
to those drivers, and all they need is private interfaces to sort
things out.  No new "system-wide" component (policy or otherewise)
is needed.


> 	The policy layer (or whatever would =

> take care of the system point of view, in case the decentralised
> approach is not enough) would _prevent_ temporarily certain deeper power
> saving states.

Yes, but ...

There are two "power management" models.  I think you are talking
about the one most relevant to low power operation:  "runtime PM".
Something like an N770 or N800 tablet needs that(*), and of course
a Linux laptop would benefit from it quite nicely too.

The "system suspend" model works the other way around:  when the
system is forced into a specific low power state, that prevents
certain drivers from working.  For example, it's common that USB
must in effect be powered off, unable to serve as a wakeup event
source (or maintain power sessions) because a key clock must be
turned off in order to enter that state.

- Dave

(*) Plus a smart idle loop ... using NO_IDLE_HZ and entering into
    SOC-wide deep sleep states rather than just CPU idle.  A partial
    PC analogue would be using the new NO_HZ and C3 or deeper.

    To me, it's suggestive that all this discussion about power
    frameworks has mentioned neither that, nor several other
    essential mechanisms, like the "run from SRAM" case that I
    mentioned earlier.  Without addressing a few such real
    problems, the email discussions can't produce good results.
