From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Sat, 24 Mar 2007 22:36:49 +0100
Message-ID: <200703242236.51045.rjw@sisk.pl>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703232139.38721.rjw@sisk.pl>
	<200703241349.19964.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703241349.19964.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: alexey.y.starikovskiy@intel.com, ben@simtec.co.uk, dirk.behme@de.bosch.com, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, johannes@sipsolutions.net, nico@cam.org, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

On Saturday, 24 March 2007 21:49, David Brownell wrote:
> On Friday 23 March 2007 1:39 pm, Rafael J. Wysocki wrote:
> =

> > 	After we have frozen tasks, we need to
> > call something like device_suspend(some_argument) where the argument sh=
ould
> > tell drivers what to do. =

> =

> That parameter can't suffice, since the exact details depend on
> system-dependent context.  Example, on one system a given sleep
> state will allow a given device to issue wakeups ... on another,
> it won't.
> =

> You seem to have overlooked the clk_must_disable() patches I
> recently re-sent.  In conjunction with the driver model wakeup
> flags, that can solve the problem on every SOC platform I've
> had a reason to look at ... see how it works for AT91 USB.

Do I understand correctly that the idea is to introduce some functions
(eg. clk_must_disable()) that each platform can define differently and
that can be used by device drivers to obtain the additional information
needed to figure out what they are expected to do in .suspend()?

Rafael
