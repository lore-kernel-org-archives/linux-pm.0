From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH/RFC 0/6] PSCI: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts
 power
Date: Wed, 22 Feb 2017 11:03:22 +0000
Message-ID: <35840771-e16f-d6fe-3a89-1b3f51f4a8f3@arm.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <94167d3a-e005-3af0-d290-a1086684d570@arm.com>
 <3c8b3f2d-8604-f999-4208-a82f171b64f2@arm.com>
 <1975396.x0czmkNPOW@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1975396.x0czmkNPOW@aspire.rjw.lan>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On 22/02/17 01:14, Rafael J. Wysocki wrote:
> On Tuesday, February 21, 2017 06:45:13 PM Sudeep Holla wrote:

[...]

>>
>> I take this back, you have everything you need in place, nothing needs
>> to be done. I just checked again. If I don't register PSCI suspend_ops,
>> I still get mem in /sys/power/state with s2idle in /sys/power/mem_sleep
>> which is exactly what we need. Again we don't support standby/shallow
>> state on ARM64/PSCI.
> 
> Except for one thing which may or may not be a concern here.
> 
> Suspend to idle should only go into states in which all of the available wakeup
> devices work.  If there are devices that cannot wake you up from a given state,
> this isn't "idle" any more, is it?
> 

True. In this Renasas platform, since the platform doesn't have PSCI
system suspend, we can only support s2idle and not s2ram. In this case
we don't ask platform to enter some system state whereas we suspend all
the devices(leaving wakeup capable devices active) and ask platform to
enter deepest idle state on all the CPUs. I still don't understand the
issue Geert is facing.

Geert, so far you have failed to explain what's different from the new
state you are adding and the existing s2idle.

> As for the device wakeup disable/enable interface, it is for controlling
> whether or not a given device should be allowed to generate wakeup signals at
> all.
> 
> The information on what states a given device can wake up the system from is
> platform-specific and generally would need to be taken into consideration at
> the platform level.
> 

Exactly, that's what I am trying to convince Geert ;)

-- 
Regards,
Sudeep
