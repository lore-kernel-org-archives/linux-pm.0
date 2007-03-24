From: David Brownell <david-b@pacbell.net>
Subject: Re: charging batteries from USB [was: Re: Alternative
	Concept]
Date: Fri, 23 Mar 2007 18:17:25 -0700
Message-ID: <200703231817.25963.david-b@pacbell.net>
References: <44ECFF94.3030506@gmail.com>
	<200703201258.03926.david-b@pacbell.net>
	<46047526.5020707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46047526.5020707@gmail.com>
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
To: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Friday 23 March 2007 5:47 pm, Dmitry Krivoschekov wrote:
> David Brownell wrote:
> >> For example, in USB you are able to enable/disable autosuspend rule,
> >> don't know if it's possible to disable it at runtime though.
> >
> > There are patches to allow disabling it at runtime through sysfs
> > attributes of any given device.
> >
> > The primary reason to have one is bugs in those external devices,
> > where they don't behave according to the USB spec.  That's the
> =

> If I didn't miss something, the primary reason was to allow
> devices to charge batteries from the bus, so, does USB
> specs restrict this somehow? Or, what's wrong with that?

You're mixing up two distinct issues:

 - Minimizing power use by the USB host ... to stretch its battery
   life, or otherwise shrink its power usage, starting with current
   delivered between on USB (between VBUS and GND).

 - How the peripheral uses whatever VBUS current it draws ... which
   can power arbitrary electronics, including a battery charger, but
   might be nothing more than powering the USB link.  (FWIW that's all
   the Nokia 800 does with VBUS; that helps stretch battery life.)

Clearly there's some competition there.  The default policy allows
autosuspend.  The primary reason to disable autosuspend is, as I
said, that some devices don't work well with it.  (Flakey circuits
or firmware, etc.)

However, enabling autosuspend *does* have a side effect that would
matter for those few devices that use VBUS to recharge a battery:
the VBUS current going to a suspended device is almost certainly
not enough to recharge anything substantial.  So -- for those few
devices that do recharge batteries over USB -- yes, another reason
to disable autosuspend might be to help recharge a battery.

- Dave
