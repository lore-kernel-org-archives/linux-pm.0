From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] PowerOP Take 3, sysfs UI core 2/5
Date: Tue, 25 Jul 2006 22:05:35 -0700
Message-ID: <200607252205.37086.david-b@pacbell.net>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DD018ACC7B@de01exm64.ds.mot.com>
	<200607241732.57588.david-b@pacbell.net>
	<1153822154.5875.16.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1153822154.5875.16.camel@localhost>
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
To: linux-pm@lists.osdl.org
Cc: Matthew Locke <matt@nomadgs.com>, Preece Scott-PREECE <scott.preece@motorola.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 25 July 2006 3:09 am, Amit Kucheria wrote:
> On Mon, 2006-07-24 at 17:32 -0700, ext David Brownell wrote:
> > On Monday 24 July 2006 2:58 pm, Preece Scott-PREECE wrote:
> > > If they're defined dynamically, you can change them without recompili=
ng
> > > the system, building a new rootfs image, etc. This is especially usef=
ul
> > > during development and tuning of systems built on new hardware, since
> > > the set of Ops available (that is, that are documented by the chip
> > > vendor to work) can vary over time and even board-to-board.
> > =

> > I could easily buy such a mechanism being dependent on EXPERIMENTAL,
> > for use with developer/prototype boards ... thanks for that scenario.
> > =

> > But I have a harder time seeing it used in production systems, burnt
> > into flash on a manufacturing line that already had to qualify that
> > new hardware before the next production run (of say 10,000 units) was
> > approved by the powers-that-be.
> > =

> > - Dave
> =

> Sometimes a certain operating point is not desired for regular operation
> of the device. So it would not be in the board-xx.c file. =

> =

> But connect a peripheral and suddenly this is the most attractive OP for
> the system.

And you'd know that in advance, and thus could predefine that OP.  :)

Even in the worst case, where you somehow add a driver without
upgrading the rest of the kernel in flash, that driver should be
able to define an OP without userspace.  (I suppose there are some
product vendors willing to do that type of field upgrade.)

I'm still not persuaded that a UI for OP creation is needed except
for development.  Feel free to keep trying to persuade me though;
I'm just pushing back on what I see as weak points, since that's
the best way I know to come up with good solutions.

- Dave


> So the ability to add operating points from userspace might =

> be helpful there.
> =

> Regards,
> Amit
> =

> > =

> > > > I meant "they could suggest how to do the sysfs thing, in reasonabl=
e =

> > > > way". Like echo new_config > file is extermely ugly, but perhaps =

> > > > configfs is suitable?
> > > =

> > > Makes some sense.  But I'm still puzzled why _creating_ an operating
> > > point would be done outside of the arch/.../board-xx.c file. =

> > _______________________________________________
> > linux-pm mailing list
> > linux-pm@lists.osdl.org
> > https://lists.osdl.org/mailman/listinfo/linux-pm
> -- =

> Amit Kucheria <amit.kucheria@nokia.com>
> Nokia
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
> =
