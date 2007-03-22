From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Thu, 22 Mar 2007 15:42:48 -0700
Message-ID: <200703221542.49830.david-b@pacbell.net>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703221444.00905.david-b@pacbell.net>
	<Pine.LNX.4.60.0703222251330.11411@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.60.0703222251330.11411@poirot.grange>
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
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alexey.y.starikovskiy@intel.com, dirk.behme@de.bosch.com, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, johannes@sipsolutions.net, nico@cam.org, ben@simtec.co.uk
List-Id: linux-pm@vger.kernel.org

On Thursday 22 March 2007 2:56 pm, Guennadi Liakhovetski wrote:
> On Thu, 22 Mar 2007, David Brownell wrote:
> =

> > STR shuts down a lot more.  Not necessarily powering down the CPU
> > (which is what would cause the need for boot/BIOS code to have the
> > "this is really a resume" cases, and isn't always possible), but at
> > least being more agressive about powering down clocks and such.
> =

> Dave, sorry, maybe I am being dense the whole time, but - "more" than =

> what??? If you implement several modes, ok, you can compare them. But if =

> you only implement one suspend mode for whatever reason - what are you =

> comparing it to? =


How about ... that canonical trivial "standby" mode I described,
where the CPU doesn't do much more than what a power-naive idle loop
might be doing?  Almost any system can do that much.

On ARM that'd be a wait-for-interrupt instruction; some other CPUs
may have analagous instructions that explicitly try to save some power,
which might not be good for an idle loop.  And some systems may have
power saving to wrap around that WFI; the idle loop might even use them.

Take it from first principles, and assume today's typical case where
drivers don't (can't!! sigh) do anything different in standby vs STR.
Then the *only* difference will be what pm_enter/pm_exit can do ...
and that's going to be primarly "what does the CPU do".

So if pm_enter is doing fancy stuff to the CPU, like re-clocking it
or powering it off ... that's more of an STR than a "standby".  As
Rafael put it, the resume then requires a "boot-like procedure".

Of course this is all points on a spectrum, and different systems
can work very differently.  Which is why I don't like the idea of
trying to place hard requirements on what STR or standby must be;
a platform could very easily support two useful power states, where
neither fits such "hard" labels.

- Dave
