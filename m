From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH/RFC 0/6] PSCI: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts power
Date: Wed, 22 Feb 2017 02:14:54 +0100
Message-ID: <1975396.x0czmkNPOW@aspire.rjw.lan>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be> <94167d3a-e005-3af0-d290-a1086684d570@arm.com> <3c8b3f2d-8604-f999-4208-a82f171b64f2@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <3c8b3f2d-8604-f999-4208-a82f171b64f2@arm.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, February 21, 2017 06:45:13 PM Sudeep Holla wrote:
> 
> On 21/02/17 18:27, Sudeep Holla wrote:
> > 
> > 
> > On 21/02/17 17:51, Sudeep Holla wrote:
> >>
> >>
> >> On 21/02/17 17:34, Geert Uytterhoeven wrote:
> > 
> > [...]
> > 
> >>>
> >>> The SoC can wake-up. It's just not guaranteed that it can wake-up using
> >>> the wakeup-source configured from Linux. Which wakeup-sources are available
> >>> depends on the actual PSCI implementation.  It's not specified by the PSCI
> >>> specification.
> >>>
> >>>> Just botching whatever shallow state you can enter on a particular SoC
> >>>> into standard "mem" state sounds *horrible* to me.
> >>>
> >>> That's more or less what /sys/power/mem_sleep does, though.
> >>>
> >>
> >> OK, I will go through that in detail.
> >>
> > 
> > OK, I went through the patch and the main intention is was added.
> > So I will begin by summarizing my understanding:
> > 
> > A new suspend interface(/sys/power/mem_sleep) is added to allow the
> > "mem" string in /sys/power/state to represent multiple things that can
> > be selected.
> > 
> > Before:
> > A. echo freeze > /sys/power/state ---> Enters s2idle
> > B. echo mem > /sys/power/state ---> Enters s2r(a.k.a now deep mem sleep)
> > 
> > After:
> > 1. echo freeze > /sys/power/state ---> Enters s2idle still same
> > 2. echo s2idle > /sys/power/mem_sleep
> >    echo mem > /sys/power/state ---> Also enter s2idle
> > 3. echo deep > /sys/power/mem_sleep
> >    echo mem > /sys/power/state ---> Also enter s2r(same as [B] above)
> > 
> > Please note I have carefully dropped standby/shallow as we will not
> > support that state on ARM64 platforms(refer previous discussions for the
> > same)
> > 
> > Now IIUC, you need 2 above. So, since this new interface allow mem to
> > mean "s2idle", we need to fix the core to register default suspend_ops
> > to achieve what you need. 
> 
> I take this back, you have everything you need in place, nothing needs
> to be done. I just checked again. If I don't register PSCI suspend_ops,
> I still get mem in /sys/power/state with s2idle in /sys/power/mem_sleep
> which is exactly what we need. Again we don't support standby/shallow
> state on ARM64/PSCI.

Except for one thing which may or may not be a concern here.

Suspend to idle should only go into states in which all of the available wakeup
devices work.  If there are devices that cannot wake you up from a given state,
this isn't "idle" any more, is it?

As for the device wakeup disable/enable interface, it is for controlling
whether or not a given device should be allowed to generate wakeup signals at
all.

The information on what states a given device can wake up the system from is
platform-specific and generally would need to be taken into consideration at
the platform level.

Thanks,
Rafael
