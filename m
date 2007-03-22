From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Thu, 22 Mar 2007 22:37:48 +0100
Message-ID: <200703222237.49801.rjw@sisk.pl>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703221129.28722.david-b@pacbell.net>
	<20070322192647.GB20605@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070322192647.GB20605@atomide.com>
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
To: linux-pm@lists.linux-foundation.org
Cc: alexey.y.starikovskiy@intel.com, linux-arm@lists.arm.linux.org.uk, dirk.behme@de.bosch.com, pavel@ucw.cz, johannes@sipsolutions.net, nico@cam.org, ben@simtec.co.uk, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

On Thursday, 22 March 2007 20:26, Tony Lindgren wrote:
> Hi,
> =

> * David Brownell <david-b@pacbell.net> [070322 14:30]:
> > On Thursday 22 March 2007 6:44 am, Scott E. Preece wrote:
> > > | From: "Rafael J. Wysocki" <rjw@sisk.pl>
> > > | =

> > > | I think we can define "standby" a bit more precisely.  Something li=
ke:
> > > | - processes are frozen,
> > > | - devices are suspended,
> > =

> > True of all sleep states, although one wants "suspended" to
> > allow different levels of device functionality.  (Maybe it
> > can wake up, maybe its firmware is monitoring the WLAN, etc.)
> =

> In addition to offering wakeup events for individual devices,
> the device suspend states should be something like retention
> and suspend, where:
> =

> Retention is where clocks are off for a device, but power is on.
> In this case the device registers are maintained in hardware.
> =

> Suspend is where clocks and power are off. In this state the
> device registers are maintained in software.
> =

> Laptops mostly have suspend, while socs allow both retention
> and suspend in many cases.

I think there can be more low-power states that just "standby",
"STR", "STD", etc., but for example "standby" should be at least comparable
between different platforms.

Greetings,
Rafael
