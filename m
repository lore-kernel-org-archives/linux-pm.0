From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] PM / core: Add WAKEUP_POWERED driver flag
Date: Fri, 10 Nov 2017 10:44:01 +0100
Message-ID: <CAPDyKFprpgEb_JsCPWWS0z2gomq8HZSKtktfgANqnRyHa-8jtg@mail.gmail.com>
References: <1510154134-1248-1-git-send-email-ulf.hansson@linaro.org>
 <1510154134-1248-3-git-send-email-ulf.hansson@linaro.org> <CAJZ5v0jFLL2pBNPo=J3MdwfcA9C+nSMe_S6iBYLoEA8SjbOJ+A@mail.gmail.com>
 <CAPDyKFpn5m+t-hBcFT1RebqaTtyLna9JCNJtsFA6yZwurKTxvw@mail.gmail.com> <CAJZ5v0iFoMgA++wqS9K9i_+rXn2EBP17dUB_AcA4P83GUnWo2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iFoMgA++wqS9K9i_+rXn2EBP17dUB_AcA4P83GUnWo2g@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

[...]

>>>
>>> First off, how does the driver know that the device has to be in full
>>> power for wakeup to work?
>>
>> Because the device is accessed as part of dealing with the wakeup.
>
> Yes, it is, In the working state of the system.  In the system wakeup
> case it may not be.
>
> Essentially, what happens then is that driver-provided interrupt
> handlers don't run as a rule and system wakeup is triggered by the
> low-level handler at the IRQ chip level.  Next, the PM callbacks
> invoked for the device are expected to clean up the wakeup status etc.
>
> Of course, power still is necessary for that to work, but it may be
> not be in-band.  That may be either in-band power used for normal
> operations and provided through the interconnect used by the device or
> it may be special wakeup power provided out-of-band.
>
> Also the wakeup signal itself may be an in-band device interrupt (like
> the ones used for signaling IO events during normal operation) or it
> may be a special wakeup signal (like PCI PME) in which case, from the
> driver's perspective, the wakeup signaling is out-of-band.
>
> Usually, the driver doesn't know how this is set up for the particular
> device in the particular platform and hence my question. :-)
>
> The case at hand seems to be when the wakeup power is in-band or the
> wakeup signal is an in-band interrupt (in which case power needs to be
> provided to the interconnect at least).

Correct!

>
> If they both are out-of-band, the middle layer should know that,
> because as a rule it will be involved in setting up both of them.
> Otherwise, in principle, it should assume that in-band power needs to
> be provided for wakeup to work and avoid turning things off if wakeup
> is enabled.

Agree!

>
>>>
>>> Second, this requirement sort of implies that the device cannot go
>>> into a low-power state during runtime suspend too, so it basically
>>> remains stays at full power even when runtime-suspended.
>>
>> No, not really, because that depends on the current situation.
>>
>> An Ethernet device can surely go into a low power state, at runtime
>> suspend, when the interface is down, for example.
>
> But then it is not expected to generate wakeup signals I suppose.

Correct.

>
> [BTW, I wonder how it detects when the cable is connected again to it.
> I know what happens in PCI NICs, but that clearly is not the case
> here.]
>
> Well, anyway, it looks like the case when the device is
> runtime-suspended right before system suspend and it is going to stay
> suspended is not interesting here, because the state will be retained
> whatever it is then.

Correct.

>
> An interesting case seems to be when the device is not
> runtime-suspended when system suspend triggers.
>

Yes.

The principle is that the driver needs to runtime resume its device,
if not already, during system suspend, as to be able to configure the
in-band interrupt, then instruct the upper layers that the device
needs to stay in its current power state.

>>>
>>> Does it then mean that the middle layer is expected to simply avoid
>>> changing the power state of the device when enabled to wake up the
>>> system, or is there more to that?  In the former case, it may be
>>> better to rename the flag to something along the lines of "don't
>>> change power state if wakeup enabled".
>>
>> Yes, correct.
>>
>> I can try to clarify that in the description and unless you have a
>> suggestion for a better name of the flag, I try to come up with
>> something for that too.
>
> I was thinking about something like DPM_FLAG_IN_BAND_WAKEUP or similar.

Perfect!

>
> But please note that there are cases in which the middle layer has
> information on what power states to put devices into for wakeup to
> work and IMO that should take precedence over the flag as a rule.

Yeah, let me try to clarify that in the doc.

[...]

Kind regards
Uffe
