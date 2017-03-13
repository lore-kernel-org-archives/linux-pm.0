From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 00/14] cpufreq: intel_pstate: Fixes, cleanups and optimizations
Date: Mon, 13 Mar 2017 14:48:56 -0700
Message-ID: <006601d29c43$9ef628c0$dce27a40$@net>
References: <001301d29bc3$29c351c0$7d49f540$@net> nNxJcvSS1rrlDnNxKcnZNA
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta20.telus.net ([209.171.16.93]:60995 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752024AbdCMVtD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Mar 2017 17:49:03 -0400
In-Reply-To: nNxJcvSS1rrlDnNxKcnZNA
Content-language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'LKML' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>

Hi Rafael,

Thanks for your quick reply.

On 2017.03.13 04:16 Rafael J. Wysocki wrote:
> On Mon, Mar 13, 2017 at 7:29 AM, Doug Smythies <dsmythies@telus.net> wrote:
>> On 2017.03.12 10:12 Rafael J. Wysocki wrote:
>>
>>> This patch series fixes a couple of bugs in intel_pstate, cleans up the code in
>>> it somewhat and makes some changes targeted at overhead reductions.
>>>
>>
>> If clean up and overhead reductions are being considered, is there any interest
>> in changing the PID controller to a P controller and eliminating the integral
>> and derivative code entirely?
>>
>> Why? The application is not really best suited to a PID
>> (Proportional Integral Derivative) controller.
>
> We already have the get_target_pstate_use_cpu_load() P-state selection
> routine which is not based on the PID controller and is used for
> multiple CPU models already (and for systems with ACPI system profile
> set to "mobile", which covers a lot of laptops AFAICS).

While that is a proportional control type algorithm, I am not suggesting
(at least not this time) changing to it. I am only suggesting to eliminate
the integral and derivative terms for the existing PID controller, but
keeping the existing proportional controller untouched for the
get_target_pstate_use_performance() code path.

>  Its coverage may be extended in the future.

And I will be totally onboard with that, and will help test and such,
when the time comes.

>> Integral terms are normally used to null out accumulated errors. For example
>> position errors as a function of integrated velocity, where the overall
>> position is supposed to be time * nominal velocity, but the actual velocity
>> at any sample point is not perfect.
>>
>> In signal processing, derivatives are difficult at the best of times, let alone
>> with the drastic sample time variations (anywhere from 10 milliseconds to 5 seconds)
>> experienced here. Myself, I can not think of a need for a derivative term anyhow.
>>
>> Readers might note the old non-zero integral gain for the old methods used
>> with Atom processors (being eliminated in this patch set, see patch 2 of 14).
>> However that was due to the low proportional gain used and was needed to get
>> target pstates to tick up or down as it settled to some steady state value,
>> as otherwise and with a setpoint of 97 (which is what was being used at the
>> time), it would not. I'm saying the integral term was being used in way that
>> was not intended to overcome another issue. In that scenario, and at the very
>> least, the error term should have been cleared upon integration to the point
>> where the pstate ticked up or down as a result.
>>
>> To be clear, I'm not talking about changing the proportional code at all,
>> but only about eliminating the integral and derivative code that has never
>> been used.
>>
>> If there is interest, I'll prepare and submit a patch.
>
> While it has not been used by default, there is the debugfs interface
> for tuning the PID that allows this code to be put into use, in
> theory.  It is documented even. :-)

Yes, I understand that.
>
> If anyone actively uses it, they won't be happy when it's gone.
>

But is that a reason not to make a change that makes sense? (Well
it makes sense at least to me.)

I suppose it is possible that someone might be using less p_gain_pct
and compensating with i_gain_pct instead of adjusting setpoint, just
like Atom used to do. I'm saying it is not correct to do it that way,
using an integral term.

> Please note that the patches in this series specifically don't change
> any user-observable behavior, or at least not intentionally ...

I'm not proposing anything that would result in any user-observable
behaviour change either, at least not with the default settings.
However, it is true that i_gain_pct and d_gain_pct would be gone, because
that is the whole point of it.

... Doug
