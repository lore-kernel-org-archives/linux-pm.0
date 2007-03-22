From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Thu, 22 Mar 2007 15:26:49 -0400
Message-ID: <20070322192647.GB20605@atomide.com>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703221129.28722.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200703221129.28722.david-b@pacbell.net>
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
Cc: alexey.y.starikovskiy@intel.com, ben@simtec.co.uk, linux-arm@lists.arm.linux.org.uk, dirk.behme@de.bosch.com, pavel@ucw.cz, johannes@sipsolutions.net, nico@cam.org, linux-pm@lists.linux-foundation.org, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

Hi,

* David Brownell <david-b@pacbell.net> [070322 14:30]:
> On Thursday 22 March 2007 6:44 am, Scott E. Preece wrote:
> > | From: "Rafael J. Wysocki" <rjw@sisk.pl>
> > | =

> > | I think we can define "standby" a bit more precisely.  Something like:
> > | - processes are frozen,
> > | - devices are suspended,
> =

> True of all sleep states, although one wants "suspended" to
> allow different levels of device functionality.  (Maybe it
> can wake up, maybe its firmware is monitoring the WLAN, etc.)

In addition to offering wakeup events for individual devices,
the device suspend states should be something like retention
and suspend, where:

Retention is where clocks are off for a device, but power is on.
In this case the device registers are maintained in hardware.

Suspend is where clocks and power are off. In this state the
device registers are maintained in software.

Laptops mostly have suspend, while socs allow both retention
and suspend in many cases.

Regards,

Tony
