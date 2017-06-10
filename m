From: Mason <slash.tmp@free.fr>
Subject: Re: Drivers taking different actions depending on sleep state
Date: Sat, 10 Jun 2017 11:16:48 +0200
Message-ID: <7b4435e5-5903-2678-fddb-34e884f5d53f@free.fr>
References: <9dc7b7f4-e47d-59f3-3b51-52e0aefd2487@free.fr>
 <0181d683-511e-1ff6-3855-e00849863e74@free.fr> <20170609213049.GA28596@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:32914 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbdFJJRP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 10 Jun 2017 05:17:15 -0400
In-Reply-To: <20170609213049.GA28596@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>

On 09/06/2017 23:30, Pavel Machek wrote:
> On Fri 2017-06-09 18:27:45, Mason wrote:
>> On 09/06/2017 17:20, Mason wrote:
>>
>>> Currently my platform's "mem" is a true suspend-to-RAM trigger,
>>> where drivers are supposed to save their state (register values
>>> will be lost), then Linux hands control over to firmware which
>>> enables RAM self-refresh and powers the chip down. When the system
>>> resumes, drivers restore their state from their copy in memory.
>>>
>>> One driver is responsible for loading/unloading microcode running
>>> on the DSPs. This operation is required only when powering down
>>> the chip, but it should be avoided for "low-latency" sleeps.
>>>
>>> The problem is that, if I understand correctly, drivers have no way
>>> of knowing which sleep state is being entered/exited?
>>>
>>> How can I have the microcode driver take different decisions
>>> based on the sleep state?
> 
> Well... question "does my chip lose state during standby/mem on _this_
> machine" is more complex then "is it standby or mem", right?

I think it's binary...
If power to the DSPs is cut, then they lose state.
If the DSPs remain powered, then they maintain state.

"mem" powers the entire chip down, including the DSPs
(by implementation's choice) but we are investigating
a lower-latency sleep state that wouldn't cut power.

> You should really ask the regulator framework, not core code.

The issue is that power cutting is not handled in Linux,
it is done by firmware. So I'm not sure what there is
to ask to the regulator framework?

>> Mason385	javier__: there's some authentication required when S2R is involved (from the firmware)
>> javier__	Mason385: ah, Ok. I just asked because if it was the latter, the regulator subsystem has infrastructure to keep the regulators on during S2R
>> Mason385	javier__: OK so there's two issues. We are required to
>> re-authenticate microcode when resuming from S2R (because someone
>> "may" have tampered with the contents) and on suspend, power is cut
>> to the DSPs and they lose context
> 
> I'm not sure what you are developing. Someone also "may" have modified
> the microcode while you were running. Someone also "may" have modified
> the kernel in RAM. Not sure what you are developing, but protecting
> against attacker with direct hardware access is impossible and not
> welcome.

There is no point in discussing the technical relevance
of these requirements, because they are *mandatory* for
certification. No certification, no customer.

So the feature must be implemented, whether it increases
"security" or not. FTR, what is being bitterly defended
is Hollywood's pixels.

Regards.
