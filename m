From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Sat, 24 Mar 2007 13:49:18 -0700
Message-ID: <200703241349.19964.david-b@pacbell.net>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703231057.16539.david-b@pacbell.net>
	<200703232139.38721.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703232139.38721.rjw@sisk.pl>
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

On Friday 23 March 2007 1:39 pm, Rafael J. Wysocki wrote:

> 	After we have frozen tasks, we need to
> call something like device_suspend(some_argument) where the argument shou=
ld
> tell drivers what to do. =


That parameter can't suffice, since the exact details depend on
system-dependent context.  Example, on one system a given sleep
state will allow a given device to issue wakeups ... on another,
it won't.

You seem to have overlooked the clk_must_disable() patches I
recently re-sent.  In conjunction with the driver model wakeup
flags, that can solve the problem on every SOC platform I've
had a reason to look at ... see how it works for AT91 USB.

(SOC "power management" documentatation invariably dwells on
clock gating ... and as previously discussed, those platforms
with "power domains", to help manage leakage current not just
clocking, can generally couple them to clocks.  So software
clock gating would normally put controllers into "retention"
mode like PCI D2, or in a few cases into a suspend" mode with
power off like PCI D3cold.  And if the state doesn't require
a given clock to be gated off, then the driver wakeup config
may direct that it's active enough to be a wakeup source.)

That is, we don't need a new method or complexified parameter
to the existing driver->suspend()...


> Say we use something like PMSG_STANDBY and now =

> do you think the meaning of it can change from one platform to another? =


No, let's not complexify that pm_message_t mistake any further.


> And if it can, how can the drivers figure out the meaning?

See summary above.  PCI devices have pci_choose_state(), which
is currently broken but ISTR is sort of fixable -- same notion,
once it does sane things.

- Dave
