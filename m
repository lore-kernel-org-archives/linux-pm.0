From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 7 May 2010 14:30:25 +0100
Message-ID: <20100507133025.GA23983__26237.3456768275$1273239086$gmane$org@rakim.wolfsonmicro.main>
References: <Pine.LNX.4.44L0.1005051511040.1885-100000@iolanthe.rowland.org>
	<m2oa55d774e1005051356n3610d780ra42200c1785e02bd@mail.gmail.com>
	<20100505234025.GB4838@opensource.wolfsonmicro.com>
	<l2kd6200be21005052125rc43217a2r8c65bc98e7a5d3d4@mail.gmail.com>
	<20100507100406.GA21498@rakim.wolfsonmicro.main>
	<w2kd6200be21005070357r9aad2896l355168a23bf85eae@mail.gmail.com>
	<20100507112102.GC21498@rakim.wolfsonmicro.main>
	<81818215-44A2-4B74-A43F-E2644C950F5C@mit.edu>
	<20100507122520.GD21498@rakim.wolfsonmicro.main>
	<z2wa55d774e1005070537k8e3cb6baxc74e998e930d254d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <z2wa55d774e1005070537k8e3cb6baxc74e998e930d254d@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: Paul Walmsley <paul@pwsan.com>, Theodore Tso <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, rebecca@android.com, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Fri, May 07, 2010 at 05:37:21AM -0700, Brian Swetland wrote:
> On Fri, May 7, 2010 at 5:25 AM, Mark Brown

> > It's unfortunate that I only noticed that this was actually wakelocks
> > very late in the day but I think I can get an implementation which
> > handles paths that ignore suspends done quickly.

> Do you mean an implementation of embedded linux audio or an
> implementation of suspend blockers "which handles paths that ignore
> suspends"?  I assume you mean the former, but maybe I misunderstand.

I mean that I will extend the embedded audio subsystem that the kernel
already has (ASoC, in sound/soc) to support ignoring suspends for some
audio paths so that they can be kept up during suspend.  This will be
primarily intended for use with opportunistic suspend but not specific
to it.

I have no intention of touching suspend blockers, except in that some of
the drivers I'm responsible for should probably use suspend blockers for
similar reasons to the other users you're merging but that's less urgent.

> We've done a lot of work around multicore SoCs where the baseband
> generally owns a lot of the audio routing and so on,

Multicore isn't really the term here - obviously on something like the
OMAP4 or the current nVidia devices you've got a multicore AP but may or
may not have an integrated baseband.  The distinction is down to how
much visibility the AP has of the audio hardware, which is in general
orthogonal to how the silicon is split and packaged.

>                                                      but we do as
> general policy not disable audio, codecs, and amps while playback or
> record is underway.

Yeah, I know.  I have been keeping an eye on the Android stuff, though
none of the audio side has been mainlined yet.

>                      I suppose for environments more like a pc laptop
> where the expectation is the world stops when you close the lid a
> different policy would be preferable.

Yes, quite.  It all depends on what the intention of the user is when
they do a suspend.  Clearly if the suspend was initiated automatically
because the system is apparently idle the intention is different to if
it was initiated because the user performed some explicit action.

> We typically fire up codecs and amps when playback starts (if they
> were off), and usually set a timer for a couple seconds after playback
> stops to spin them down (since you tend to have to delay while they're
> powering up to avoid pops, etc, and if the system just played a short
> sound there's a reasonable chance it'll follow that with another).

This is exactly what ASoC does - the two biggest wins it offers are that
it allows reuse of the code specific to a given piece of silicon on all
boards using that silicon and that it provides automatic runtime power
management in the core by keeping track of which audio paths are live.

There is the slight wrinkle that you don't really want to *fully* power
down devices that don't have ground referenced outputs since they take
a relatively long time to bring their reference level up without audible
artifacts in the output.
