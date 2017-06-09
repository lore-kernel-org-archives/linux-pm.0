From: Mason <slash.tmp@free.fr>
Subject: Re: Drivers taking different actions depending on sleep state
Date: Fri, 9 Jun 2017 18:27:45 +0200
Message-ID: <0181d683-511e-1ff6-3855-e00849863e74@free.fr>
References: <9dc7b7f4-e47d-59f3-3b51-52e0aefd2487@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:53806 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751616AbdFIQ2G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Jun 2017 12:28:06 -0400
In-Reply-To: <9dc7b7f4-e47d-59f3-3b51-52e0aefd2487@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>

On 09/06/2017 17:20, Mason wrote:

> Currently my platform's "mem" is a true suspend-to-RAM trigger,
> where drivers are supposed to save their state (register values
> will be lost), then Linux hands control over to firmware which
> enables RAM self-refresh and powers the chip down. When the system
> resumes, drivers restore their state from their copy in memory.
> 
> One driver is responsible for loading/unloading microcode running
> on the DSPs. This operation is required only when powering down
> the chip, but it should be avoided for "low-latency" sleeps.
> 
> The problem is that, if I understand correctly, drivers have no way
> of knowing which sleep state is being entered/exited?
> 
> How can I have the microcode driver take different decisions
> based on the sleep state?

FWIW, here's a transcript of a parallel discussion on #armlinux

Mason385	The kernel supports several "levels" of sleeps (S0, S1, S3, S4) ... is it possible for drivers to differentiate which level is being entered/exited ?
kos_tom		Mason385: ask abelloni, he knows this topic very well
Mason385	abelloni: I'd be happy to tap that knowledge of yours
Mason385	I think khilman also knows a thing or three
abelloni	it is not currently possible
Mason385	abelloni: one of the drivers is responsible for loading/unloading microcode to the DSP, and this is a very long operation (on the order of 1-2 seconds) and the author wants to be able to avoid this unload/reload for "freeze"
Mason385	the current "solution" has been to export the requested state in a global variable exported to all kernel modules (bleh)
Mason385	IIUC, there is no better way then?
abelloni	no, that is what we do on at91
Mason385	abelloni: I'm confused because there's already an argument passed to drivers to indicate the sleep state, only it's the same arg for every state. Did someone determine it is unnecessary for drivers to have that information? But then why have the parameter in the first place?
abelloni	I think up until recently, the stance was that it was unnecessary for the drivers to have that info
abelloni	I would like to change that too but currently, you can't have it
khilman		Mason385: abelloni is right (unfortunately)
Mason385	khilman: so you would also recommend exporting a global variable then?
khilman		I cannot confirm or deny such a recommendation.  
khilman		(but there is no other way)
Mason385	Don't worry, this code has negative chance to ever hit upstream
khilman		curious though: is the reason to avoid the unload/reload just for optimization of suspend/resume time?  or is it because the DSP actually loses context?
Mason385	on suspend to RAM, the chip is powered down and loses all context
khilman		so the compromise solution I've used in this case is to make the driver a bit smarter.
khilman		iow, the driver always saves context, but then on resume, checks to see if restore is actually needed before doing the full restore (which is usually the time consuming part)
khilman		often that can be done by checking some register that has a known power-on reset value (that's different from the driver programmed state)
abelloni	khilman: I think it would still be worth exporting the target state to the drivers
Mason385	khilman: I *think* even the suspend side of the problem is time-consuming
javier__	Mason385: silly question, but does it necessarily lose state because the machine is suspended to RAM and the DSP needs to be reset on resume or is because the DSP loses power?
abelloni	It may be difficult for drivers to know whether the IP has lost state
abelloni	Also, we only have one platform loosing state and now, all the previous SoC are taking the hit
khilman		abelloni: sure, but the goal is still that the drivers try to be smart.  Having the global variable is an optimization.
Mason385	javier__: there's some authentication required when S2R is involved (from the firmware)
javier__	Mason385: ah, Ok. I just asked because if it was the latter, the regulator subsystem has infrastructure to keep the regulators on during S2R
Mason385	javier__: OK so there's two issues. We are required to re-authenticate microcode when resuming from S2R (because someone "may" have tampered with the contents) and on suspend, power is cut to the DSPs and they lose context
Mason385	javier__: were you suggesting to keep power to the DSPs during S2R (I don't think that is possible in the chip)
javier__	Mason385: I wasn't suggesting since I don't know your HW and use case
Mason385	I meant if it was possible, of course 
javier__	Mason385: yes, I was just mentioning that the regulator subsys had a regulator-on-in-suspend property since we had a similar issue with a chip and solved that way
