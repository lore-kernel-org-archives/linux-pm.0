From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] [RFC] PM / Domains: multiple states
Date: Tue, 07 Apr 2015 08:21:33 -0700
Message-ID: <7h6198rmki.fsf@deeprootsystems.com>
References: <1427963699-2638-1-git-send-email-ahaslam@baylibre.com>
	<7hvbh8sswu.fsf@deeprootsystems.com>
	<1437825.naZtzVF5nI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35022 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755341AbbDGPVi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2015 11:21:38 -0400
Received: by patj18 with SMTP id j18so82011080pat.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2015 08:21:36 -0700 (PDT)
In-Reply-To: <1437825.naZtzVF5nI@vostro.rjw.lan> (Rafael J. Wysocki's message
	of "Tue, 07 Apr 2015 13:11:36 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ahaslam@baylibre.com, linux-pm@vger.kernel.org, ulf.hansson@linaro.org

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> On Monday, April 06, 2015 05:06:57 PM Kevin Hilman wrote:
>> ahaslam@baylibre.com writes:
>> 
>> > From: Axel Haslam <ahaslam@baylibre.com>
>> >
>> > Some architectures may have intermediate
>> > power levels between on and off. each state in
>> > between may have its own set of registers to
>> > save and restore, and procedures to put the power
>> > domain into that state.
>> 
>> Maybe a bit more description is needed here, something like:
>> 
>> ...the most common of these being a "retention" state, where clocks are
>> gated, and voltage is lowered to a retention voltage so the domain is
>> not technically "off" (as in zero volts) but is in a low-power state,
>> with all or part of the logic/memory retained.
>> 
>> For those more familiar with ACPI, you might also mention the simliarity
>> to ACPI D states:
>> http://en.wikipedia.org/wiki/Advanced_Configuration_and_Power_Interface#Device_states
>
> That would be confusing IMO.  ACPI D-states should not be used to handle
> power domains (although they are sometimes).  ACPI power resources should
> be used for this purpose.

This approach is targetted at non-ACPI platforms, I was just mentioning
ACPI D-states because they're conceptually similar to having multiple
power states.

>> > This patch adds the ability to declare multiple
>> > states for a given generic power domain, the
>> > idea is that the deepest state will be entered which
>> > does not violate any of the device or sub-domain
>> > latency constraints.
>> >
>> > for this purpose, the device save and restore callbacks
>> > take in a new parameter "state" which is the state
>> > the domain is trying to go to. The implementation
>> > of these callbacks can use this to save and restore
>> > the appropriate registers. Also the power on and off
>> > callbacks and latencies are now tied to a particular
>> > state.
>> 
>> The unfortunate problem here is that the underlying framework (runtime
>> PM) doesn't yet know about multiple power states, so I'm not sure (yet)
>> how to make this work at the genpd level without also changing runtime
>> PM understand the concept of multiple power states.  
>
> Runtime PM doesn't know about multiple power state *on* *purpose*.  The
> reason why is that different bus types etc. define different sets of
> power state having nothing in common and it would be very difficult to
> try to cover all of them in one framework.  

Agreed.

> Therefore we only recognize
> the difference between "suspended" and "active" and whoever knows what
> the real states are is responsible for using them as appropriate (they
> all belong to the "suspended" metastate).

Yes, that's how things work today.  I was assuming we might want to
eventually handle that in runtime PM itself, but I'm OK if it stays in
bus/subsystem drivers too.

Kevin

