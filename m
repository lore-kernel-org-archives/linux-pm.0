From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: Re: [PATCH V2 03/12] PM / Domains: Add on-off notifiers
Date: Tue, 30 Apr 2013 14:55:40 +0200
Message-ID: <517FBF4C.6090806@stericsson.com>
References: <1364487098-10319-1-git-send-email-rickard.andersson@stericsson.com>	<1364487098-10319-4-git-send-email-rickard.andersson@stericsson.com>	<3261022.s2M99fPNjC@vostro.rjw.lan>	<51767DE2.7050203@stericsson.com> <CACRpkdb+JrnrQgzZ5xdtFDubexNRm2WsrLXv+5zfjN1wdowaNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu1sys200aog123.obsmtp.com ([207.126.144.155]:41772 "EHLO
	eu1sys200aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759038Ab3D3M4W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2013 08:56:22 -0400
In-Reply-To: <CACRpkdb+JrnrQgzZ5xdtFDubexNRm2WsrLXv+5zfjN1wdowaNg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "hongbo.zhang@linaro.org" <hongbo.zhang@linaro.org>, "khilman@linaro.org" <khilman@linaro.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Linus WALLEIJ <linus.walleij@stericsson.com>

On 04/29/2013 02:14 PM, Linus Walleij wrote:
> On Tue, Apr 23, 2013 at 2:26 PM, Rickard Andersson
> <rickard.andersson@stericsson.com>  wrote:
>> On 03/31/2013 12:17 AM, Rafael J. Wysocki wrote:
>>> On Thursday, March 28, 2013 05:11:29 PM Rickard Andersson wrote:
>>>> I believe notifiers are the best solution to the problem of
>>>> restoring context early when waking up after sleep.
>>> I don't.
>> Some motivation would be good.
> (...)
>>> Well, quite frankly, it is hard to say what problem this is supposed to
>>> address from your description.  Care to give some more details?
>> The problem is that some hardware blocks needs to be restored as early as
>> possible after leaving the U8500 CPU coupled sleep state ApSleep (APE power
>> domain being off).
> (APE = Application Processor Environment, on embedded)
>
> I just have this vague feeling that this is one of those embedded SoC
> vs desktop things where worlds collide.
>
> Isn't it so that on common x86 (desktop, server, laptop) the context of
> the system is saved by some BIOS/ACPI call, and then the ROM
> takes you back up with all devices put back into context?
>
> On embedded SoC's we don't have this, all states in the hardware
> has to be saved and restored with kernel code.
>
> Then there is a question about whether this shall be done centrally
> (there is one piece of code that knows all volatile registers of all
> hardware blocks in the system) which is close to what the desktop
> BIOS may do, or whether you want to do this in a distributed manner,
> so that each driver saves and restores the context of it's particular
> hardware.
>
The advantage with using the distributed approach is that all knowledge 
of a certain hardware block can be handled in one place, the driver. 
Having all knowledge in one place is a standard software design pattern.

Most drivers in the APE domain will be fine using runtime pm, but a few 
needs their context (i.e. registers) to be restored directly when 
leaving a sleep state where the APE power domain has been off. For 
example the following hardware blocks: APE clocks, ICN (main 
interconnect bus) and TPIU (Trace Port Interface Unit).
Using the TPIU block as an example: tracing with debugger (using TPIU 
block) needs to be active (context restored) directly after sleep in 
order to be able to record the execution also after waking up from 
sleep. If the TPIU context is not restored after waking up from sleep 
then the debuggers recording of the execution will also stop after 
waking up from sleep which is not a good thing when looking for 
difficult errors using a debugger.

Rafael: Can you please share your view?

Thanks in advance!
/Rickard

