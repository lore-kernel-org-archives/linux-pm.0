From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC/PATCH] dt: bindings: Define bindings for device idle states
Date: Mon, 29 Aug 2016 11:34:34 +0200
Message-ID: <CAPDyKFpQ-kG0jkOXwVWJkwT41JjTg=KwNv4z-E7UUBqfKMNHgg@mail.gmail.com>
References: <1472207073-4901-1-git-send-email-ulf.hansson@linaro.org> <20160826135842.GA9303@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37759 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757017AbcH2Jeh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Aug 2016 05:34:37 -0400
Received: by mail-wm0-f43.google.com with SMTP id i5so82105270wmg.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Aug 2016 02:34:36 -0700 (PDT)
In-Reply-To: <20160826135842.GA9303@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rob Herring <robh+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Brendan Jackman <Brendan.Jackman@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Axel Haslam <ahaslam@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 26 August 2016 at 15:58, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> @@ -0,0 +1,102 @@
>> +Device idle states
>> +========================
>> +
>> +A device are often capable of entering a low power state(s) when it becomes
>> +idle, hence the terminology of device idle states. Entering an idle state for a
>> +device helps it to avoid wasting power and reduces the leakage of current.
>
> First things first: what do these states _really_ represent? We have
> GPIOs in device tree, we have clock domains. What are these?

On most ARM SoCs which I am familiar of and which isn't using ACPI,
these kind of resources may can be considered as "power resources"
connected to a generic device. Although it's of course highly
dependent on the SoC. Other typical resources are clocks, pinctrls,
regulators etc.

To enter a low power state, these devices may not explicitly have to
change some internal logic, but instead relies on external "power
resources " to be put into low power mode.

I guess one could compare this to what can be described in the ACPI's
Device Power Management.

>
> Actually I don't think I like this. We should describe the hardware,
> not particular use case.

I am not describing use cases, but I am trying invent a generic
binding that describes a generic device's idle states. At least to me,
this is characteristics of the HW.

Rob requested a flexible future proof binding, but perhaps you think
this became too generic/flexible?

>
> On what hardware would you use these new bindings?

Lot's of ARM SoCs, especially those that don't use ACPI.

>
>> +Required properties:
>> +- compatible:                Must contain "simple-dev, idle-state".
>> +- entry-latency-ns:  An u32 value in nano-seconds representing the worst case
>> +                     latency required for the device to enter the idle state.
>> +- exit-latency-ns:   An u32 value in nano-seconds representing the worst case
>> +                     wakeup latency of the device, after entry-latency-ns has
>> +                     passed.
>
> u32 nanoseconds have 4sec limit, right? So anything with spinning
> harddrive is out?

In most cases 4 sec is probably good enough.

We could increase it to u64 or we could have another compatible string
for those idle states types that requires this.

>
>> +== Assigning idle states to devices ==
>> +
>> +Required properties:
>> + - dev-idle-states:  A list of phandles pointing to the supported
>> +                     device idle states nodes. The list must be ordered as
>> +                     the shallower state - the earlier in the list.
>
> Does such ordering really neccessarily exist?

On several devices that I am aware of yes. Although, again this
SoC/device specific.

If this becomes a problem for some devices, we can assign them another
compatible string used deal with those idle state types.

Kind regards
Uffe
