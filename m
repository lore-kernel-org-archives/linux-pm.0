From: Amit Kucheria <amit.kucheria@nokia.com>
Subject: Re: [RFC] PowerOP Take 3, sysfs UI core 2/5
Date: Tue, 25 Jul 2006 13:09:14 +0300
Message-ID: <1153822154.5875.16.camel@localhost>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DD018ACC7B@de01exm64.ds.mot.com>
	<200607241732.57588.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607241732.57588.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ext David Brownell <david-b@pacbell.net>
Cc: Matthew Locke <matt@nomadgs.com>, linux-pm@lists.osdl.org, Preece Scott-PREECE <scott.preece@motorola.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 2006-07-24 at 17:32 -0700, ext David Brownell wrote:
> On Monday 24 July 2006 2:58 pm, Preece Scott-PREECE wrote:
> > If they're defined dynamically, you can change them without recompiling
> > the system, building a new rootfs image, etc. This is especially useful
> > during development and tuning of systems built on new hardware, since
> > the set of Ops available (that is, that are documented by the chip
> > vendor to work) can vary over time and even board-to-board.
> =

> I could easily buy such a mechanism being dependent on EXPERIMENTAL,
> for use with developer/prototype boards ... thanks for that scenario.
> =

> But I have a harder time seeing it used in production systems, burnt
> into flash on a manufacturing line that already had to qualify that
> new hardware before the next production run (of say 10,000 units) was
> approved by the powers-that-be.
> =

> - Dave

Sometimes a certain operating point is not desired for regular operation
of the device. So it would not be in the board-xx.c file. =


But connect a peripheral and suddenly this is the most attractive OP for
the system. So the ability to add operating points from userspace might
be helpful there.

Regards,
Amit

> =

> > > I meant "they could suggest how to do the sysfs thing, in reasonable =

> > > way". Like echo new_config > file is extermely ugly, but perhaps =

> > > configfs is suitable?
> > =

> > Makes some sense.  But I'm still puzzled why _creating_ an operating
> > point would be done outside of the arch/.../board-xx.c file. =

> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
-- =

Amit Kucheria <amit.kucheria@nokia.com>
Nokia
