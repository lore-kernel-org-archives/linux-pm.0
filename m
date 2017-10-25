From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Subject: Re: How to power gate a specific single device from outside?
Date: Wed, 25 Oct 2017 14:15:36 +0200
Message-ID: <CAHKzcEORSo2X7uEsOzeR7WpzN+2T4pYAdh1QDZ5nd9kBD-w=sA@mail.gmail.com>
References: <CAHKzcEP6dQ1PxB35yCW_R1W8yZCCsJN_HqiZ6uq2d+sZp_9EYw@mail.gmail.com>
 <20171025005635.57f1b926@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171025005635.57f1b926@alans-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 25 October 2017 at 01:56, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>
> For a lot of devices if you close it then it will try and put the device
> into a low power state. If a driver isn't doing that then (unless there
> are hardware constraints preventing it) it would make sense to fix it.
>
> There are some things entirely in your control - big ones. In particular
> the brightness of laptop panels, pulling everything off one CPU socket,
> disabling the nmi watchdog, hard disk power settings, stopping processes
> that wake up a lot.
>
> Many of those you can set anyway for best power behaviour (see powertop).
>

Thanks Alan for your feedback.

This is not really what I'm looking for. I do an embedded design and
need to have more fine-grained control over certain IP blocks inside
the SoC and outside when entering "backup" mode or "selective suspend"
or whatever we call it.

The whole idea is to save maximum power in case of voltage outage on
the main rail to let the system still do some emergency activities
when it's on the backup battery. A simple circuit (or more complex
power switch IC) will discover voltage outage, switch to a
battery-backed rail and will generate an irq to SoC.

Now, what I need in the kernel is to _selectively_ suspend devices
that are not needed in the "backup/emergency" mode.

If current state of the power frameworks for system sleep, runtime pm,
genpd etc. are not able to handle this transition, and as far as I
understand these subsystems they cannot handle this straight away, I
propose to extend with a new power state PM_SUSPEND_EMERGENCY or so to
suspend unnecessary blocks of the system and leave the rest to operate
in emergency mode.

In DT we could specify which devices should go in low power state when
in emergency mode eg.
node {
    ....
    suspend-in-emergency;
    .....
}

So the device driver knows if it should be suspended in
PM_SUSPEND_EMERGENCY or not.  The driver has to provide a callback in
pm_ops to handle this transition or we could reuse suspend callback if
possible.

Just a brief idea. Does it make sense to anyone?

/Waldek
