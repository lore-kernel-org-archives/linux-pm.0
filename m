From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH] PM: Introduce generic DVFS framework
	with device-specific OPPs
Date: Wed, 27 Apr 2011 15:46:12 +0200
Message-ID: <201104271546.12757.rjw@sisk.pl>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<201104261309.47629.rjw@sisk.pl>
	<BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, April 27, 2011, MyungJoo Ham wrote:
> Hello,
> 
> 2011/4/26 Rafael J. Wysocki <rjw@sisk.pl>:
> > Hi,
> >
...
> >> +
> >> +/**
> >> + * dvfs_tickle_device() - Guarantee maximum operation speed for a while
> >> + *                   instaneously.
> >> + * @dev:     the device to be tickled.
> >> + * @duration_ms:     the duration of tickle effect.
> >> + *
> >> + * Tickle sets the device at the maximum frequency instaneously and
> >> + * the maximul frequency is guaranteed to be used for the given duration.
> >          ^^^^^^^
> > I guess that should be "maximum".
> 
> Yes. :)
> 
> >
> >> + * For faster user reponse time, an input event may tickle a related device
> >> + * so that the input event does not need to wait for the DVFS to react with
> >> + * normal interval.
> >> + */
> >
> > Can you explain how this function is supposed to be used, please?
> 
> Ok, I'll show you a usage example
> 
> The system: a touchscreen based computer with DVFS'able GPU.
> Use case: a user scrolls the screen with fingers suddenly. (think of
> an iPhone or Android device's home screen filled wit icons)
> While there is no touchscreen input (thus, the screen does not move
> fast), we do not use GPU too much; thus it is scaled to run at slower
> rate (let's say 100MHz).
> If a user suddenly touches screen and starts moving, the screen should
> follow it; thus, requires much output from GPU.
> With normal DVFS-GPU, it would take some time to speed it up because
> it should monitor the GPU usage and react afterwards.
> 
> With the API given, "tickle" may be included in the user input event.
> So that GPU can be scaled to maximum frequency immediately.

So in this case the input subsystem would be calling dvfs_tickle_device()
(or whatever it is finally called) for the GPU, right?

I'm afraid you'd need a user space interface for that and let the
application (or library) handling the touchpad input control the "tickle".
Otherwise it would be difficult to arrange things correctly (the association
between the input subsystem and the GPU is not obvious at the kernel level).

Ideally, though, the working OPP for the GPU should depend on the number of
processing requests per a unit of time, pretty much like for a CPU.

> If the monitoring frequency is 50ms, DVFS will likely to react with
> about 75ms of delay.
> For example, if the touch event has occurred at 25ms after the last
> DVFS monitoring event, at the next DVFS monitoring event, the measured
> load will be about 50%, which usually won't require DVFS to speed up.
> Then, DVFS will react at the next monitoring event; thus, it took 50ms
> + 25ms.
> 
> 75ms is enough to give some impression to users. These days, many
> mobile devices require 60Hz-based UI, which is about 16ms.
> 
> Anyway, this happens with drivers/cpufreq also. We have been testing
> "tickling" associated with drivers/cpufreq/cpufreq.c. This has been
> reduced user response time significantly removing the need for tuning
> the threshold values.

I think I understand the problem, but I'm not sure if there's a clean way
to trigger the "tickle" from the kernel level.

Thanks,
Rafael
