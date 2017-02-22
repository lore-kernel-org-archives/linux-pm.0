From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH/RFC 0/6] PSCI: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts
 power
Date: Wed, 22 Feb 2017 15:24:01 +0000
Message-ID: <ecc87d46-6a77-3c8f-d67e-974d20b8a603@arm.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <94167d3a-e005-3af0-d290-a1086684d570@arm.com>
 <3c8b3f2d-8604-f999-4208-a82f171b64f2@arm.com>
 <1975396.x0czmkNPOW@aspire.rjw.lan>
 <35840771-e16f-d6fe-3a89-1b3f51f4a8f3@arm.com>
 <CAMuHMdXpKrJn9NrkAarvMtytk9gHEFcRoZLCsWBFgriUCeWo=Q@mail.gmail.com>
 <f649d707-8b0a-5ca9-b021-93ae8cf66b33@arm.com>
 <CAJZ5v0iheYM-qj8=bO3NZhoM5=8+TikYhm23EZV72HxNxUXDsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAJZ5v0iheYM-qj8=bO3NZhoM5=8+TikYhm23EZV72HxNxUXDsg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Len Brown <len.brown@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Pavel Machek <pavel@ucw.cz>, Sudeep Holla <sudeep.holla@arm.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org



On 22/02/17 14:50, Rafael J. Wysocki wrote:
> On Wed, Feb 22, 2017 at 3:32 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

[...]

>>
>> OK, I thought I had told this before. What do you mean by PSCI system
>> suspend can't wakeup from the configured wakeup source. You just said
>> above that you can wake up from the switch.
>>
>> Just enabling the wakeup sources in Linux doesn't mean you can enter
>> system suspend anytime. You must enter only the state from which you can
>> resume. And in your case if you can't wakeup from WLAN or wakeup source
>> you have configured then simply don't enter system suspend.
> 
> Well, not quite.
> 
> The sysfs wakeup setting for devices only means whether or not to
> enable the generation of wakeup signals for them while suspending.  It
> allows to *prevent* devices from waking up the system, but it doesn't
> guarantee that they will actually wake up if enabled.
> 
> Now, the platform doesn't decide on the sleep state it will go to on
> the basis of what devices have been enabled to wake up the system.
> The states ("shallow", "deep") have to be defined upfront, including
> what devices can wake up from the "shallow" and what devices can wake
> up from the "deep" states (these lists need not be the same).  [As I
> said before, the assumption is that all of them will be able to wake
> up the system from suspend-to-idle.]
> 
> So, if user space triggers a transition to the "shallow" state, say,
> it will be possible to wake up the system from it by devices that (a)
> can wake it up from the "shallow" state as defined for the given
> platform and (b) have been enabled to wake up the system via sysfs.
> 
> Conversely, if you have a system power state such that only a subset
> of devices can wake up from it, it needs to be defined as either
> "shallow" or "deep" and the list of possible wakeup sources is part of
> that definition.

Completely agreed.

And yes the current assumption is that the set of wake-up source in DT
applies to the suspend-to-idle case and may/may not from the deeper
s2ram state.

Sorry if I conveyed something else in my emails. I was mostly referring
to the patch set and the way it's hacking up. I still fail to understand
what Geert is doing different in his "shallow" state that "s2idle" can't
achieve that state. So my comments were more aligned to that when I made
the above comment.

-- 
Regards,
Sudeep
