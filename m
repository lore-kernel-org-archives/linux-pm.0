From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 1/5] devcore introduce wakeup_event callback
Date: Mon, 8 Sep 2008 19:56:23 -0700
Message-ID: <200809081956.23522.david-b__31285.5643606328$1220930194$gmane$org@pacbell.net>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
	<20080908092305.221009807@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080908092305.221009807@sli10-desk.sh.intel.com>
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
To: shaohua.li@intel.com
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 08 September 2008, shaohua.li@intel.com wrote:
> --- linux.orig/include/linux/pm.h=A0=A0=A0=A0=A0=A0=A02008-09-08 13:55:57=
.000000000 +0800
> +++ linux/include/linux/pm.h=A0=A0=A0=A02008-09-08 13:56:51.000000000 +08=
00
> @@ -125,6 +125,8 @@ typedef struct pm_message {
> =A0 *=A0=A0=A0=A0=A0make ANY assumptions about the hardware state right p=
rior to @restore().
> =A0 *=A0=A0=A0=A0=A0On most platforms, there are no restrictions on avail=
ability of
> =A0 *=A0=A0=A0=A0=A0resources like clocks during @restore().
> + * @wakeup_event: Checks if a wakeup event occurs. If yes, wakeup event =
should
> + * =A0 =A0 =A0be disabled.

And ... what else??  What does the return value indicate?
Should anything be done with it other than printing it out
if it's nonzero and we're debugging?


> =A0 *
> =A0 * All of the above callbacks, except for @complete(), return error co=
des.
> =A0 * However, the error codes returned by the resume operations, @resume=
(),
> @@ -151,6 +153,7 @@ struct pm_ops {
> =A0=A0=A0=A0=A0=A0=A0=A0int (*thaw)(struct device *dev);
> =A0=A0=A0=A0=A0=A0=A0=A0int (*poweroff)(struct device *dev);
> =A0=A0=A0=A0=A0=A0=A0=A0int (*restore)(struct device *dev);
> +=A0=A0=A0=A0=A0=A0=A0int (*wakeup_event)(struct device *dev);

My reaction to adding this method is:  why do it here rather
than at the bus level?

In my particular experience there are two basic types of wakeup
event:

  - Regular IRQs.  Common on SOC systems; the IRQ comes in,
    the driver knows it must wake up.  Does not need any
    driver model hook; enable_irq_wake()/disable_irq_wake()
    suffice.

    I've seen USB remote wakeup working just fine on several
    different embedded Linuxes using only regular IRQ hooks.

  - Side-band signaling.  Think of this as an IRQ mechanism
    that's not used for "normal" driver operation, and you
    won't be far off.  Examples:

     * PCI PME# (and its PCIE analogue).  Bus-specific; it's
       pretty much a kind of shared IRQ line coupled with a
       special config-space register protocol.

     * ACPI GPEs.  Bus-specific ... and similar to GPIO IRQs.
       Also sharable; bytecode is used to map the GPE and
       some register state to the ACPI device(s) which
       issued that GPE.

     * Pin-change events.  Not quite isomorphic with (GPIO)
       IRQs; sometimes used with pins that aren't used for
       events (or even GPIOs!) during normal operation.
       Device-specific.

That is, I don't see why these events should expect to be
filtered through the driver core.  If there's a reason to
do that, please enlighten me!

- Dave

p.s. Related to this, I don't see the point behind
     patch 2/5 ...


> =A0};
> =A0
> =A0/**
