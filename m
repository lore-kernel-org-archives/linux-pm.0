From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 00/14] cpufreq: intel_pstate: Fixes, cleanups and optimizations
Date: Mon, 13 Mar 2017 12:16:00 +0100
Message-ID: <CAJZ5v0jFgdLkS+HOQ_8+bcBytAwpMFOu7bpkX+mF_bNc6YPe4w@mail.gmail.com>
References: <001301d29bc3$29c351c0$7d49f540$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f173.google.com ([74.125.82.173]:35173 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751846AbdCMLQC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2017 07:16:02 -0400
In-Reply-To: <001301d29bc3$29c351c0$7d49f540$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>

On Mon, Mar 13, 2017 at 7:29 AM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2017.03.12 10:12 Rafael J. Wysocki wrote:
>
>> This patch series fixes a couple of bugs in intel_pstate, cleans up the code in
>> it somewhat and makes some changes targeted at overhead reductions.
>>
>
> If clean up and overhead reductions are being considered, is there any interest
> in changing the PID controller to a P controller and eliminating the integral
> and derivative code entirely?
>
> Why? The application is not really best suited to a PID
> (Proportional Integral Derivative) controller.

We already have the get_target_pstate_use_cpu_load() P-state selection
routine which is not based on the PID controller and is used for
multiple CPU models already (and for systems with ACPI system profile
set to "mobile", which covers a lot of laptops AFAICS).  Its coverage
may be extended in the future.

> Integral terms are normally used to null out accumulated errors. For example
> position errors as a function of integrated velocity, where the overall
> position is supposed to be time * nominal velocity, but the actual velocity
> at any sample point is not perfect.
>
> In signal processing, derivatives are difficult at the best of times, let alone
> with the drastic sample time variations (anywhere from 10 milliseconds to 5 seconds)
> experienced here. Myself, I can not think of a need for a derivative term anyhow.
>
> Readers might note the old non-zero integral gain for the old methods used
> with Atom processors (being eliminated in this patch set, see patch 2 of 14).
> However that was due to the low proportional gain used and was needed to get
> target pstates to tick up or down as it settled to some steady state value,
> as otherwise and with a setpoint of 97 (which is what was being used at the
> time), it would not. I'm saying the integral term was being used in way that
> was not intended to overcome another issue. In that scenario, and at the very
> least, the error term should have been cleared upon integration to the point
> where the pstate ticked up or down as a result.
>
> To be clear, I'm not talking about changing the proportional code at all,
> but only about eliminating the integral and derivative code that has never
> been used.
>
> If there is interest, I'll prepare and submit a patch.

While it has not been used by default, there is the debugfs interface
for tuning the PID that allows this code to be put into use, in
theory.  It is documented even. :-)

If anyone actively uses it, they won't be happy when it's gone.

Please note that the patches in this series specifically don't change
any user-observable behavior, or at least not intentionally ...

Thanks,
Rafael
