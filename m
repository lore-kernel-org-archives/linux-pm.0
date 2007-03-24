From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Sat, 24 Mar 2007 15:19:58 -0700
Message-ID: <200703241519.58916.david-b@pacbell.net>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703241349.19964.david-b@pacbell.net>
	<200703242236.51045.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703242236.51045.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: alexey.y.starikovskiy@intel.com, ben@simtec.co.uk, dirk.behme@de.bosch.com, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, johannes@sipsolutions.net, nico@cam.org, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

On Saturday 24 March 2007 2:36 pm, Rafael J. Wysocki wrote:
> On Saturday, 24 March 2007 21:49, David Brownell wrote:

> > You seem to have overlooked the clk_must_disable() patches I
> > recently re-sent.  In conjunction with the driver model wakeup
> > flags, that can solve the problem on every SOC platform I've
> > had a reason to look at ... see how it works for AT91 USB.
> =

> Do I understand correctly that the idea is to introduce some functions
> (eg. clk_must_disable()) that each platform can define differently =


The definition is the same, it's the behavior that differs.  :)

That's no change from the rest of the clock framework, of course;
essentially every chip has a unique clock tree, but the interface
to that tree is defined the same on all systems.


> and =

> that can be used by device drivers to obtain the additional information
> needed to figure out what they are expected to do in .suspend()?

Yes.  See how it works for AT91 USB.  In sleep states where the
48 MHz PLL is off, suspend() fully disables host or peripheral
controllers and resume() re-initializes them from scratch.  But
otherwise the controller will often stay partially active, so
that it can be a wakeup event source and/or maintain any current
sessions.

The UART is a funky case; it usually can't adjust its internal
clock divisor (maybe at 1200 baud it could?), but some systems
reprogram RXD as a wakeup GPIO.  That particular patch doesn't
do either of those things -- but that could be done.

- Dave
