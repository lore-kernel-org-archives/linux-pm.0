From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC V2 1/2] irq: Add a framework to measure interrupt timings
Date: Thu, 21 Jan 2016 13:38:02 +0100
Message-ID: <56A0D12A.1080007@linaro.org>
References: <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org>
 <1453305636-22156-2-git-send-email-daniel.lezcano@linaro.org>
 <20160120190718.GS6357@twins.programming.kicks-ass.net>
 <alpine.DEB.2.11.1601202050050.3575@nanos> <56A0A9E3.2070306@linaro.org>
 <20160121100834.GM6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34686 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965226AbcAUMiF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2016 07:38:05 -0500
Received: by mail-wm0-f48.google.com with SMTP id u188so224524248wmu.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2016 04:38:04 -0800 (PST)
In-Reply-To: <20160121100834.GM6356@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On 01/21/2016 11:08 AM, Peter Zijlstra wrote:
> On Thu, Jan 21, 2016 at 10:50:27AM +0100, Daniel Lezcano wrote:
>
>> Actually, the handle passes dev_id in order to let the irqtimings to=
 sort
>> out a shared interrupt and prevent double sampling. In other words, =
for
>> shared interrupts, statistics should be per t-uple(irq , dev_id) but=
 that is
>> something I did not implemented ATM.
>>
>> IMO, the handler is at the right place. The prediction code does not=
 take
>> care of the shared interrupts yet.
>
> That certainly added to the confusion. But if you want per dev_id sta=
ts,
> the whole alloc framework is 'broken' too, for it allocates the stuff
> per irq.

Yep, that's correct. I was planning to re-work it later by handling the=
=20
shared interrupts, assuming they were not so common, but regarding the=20
examples below, that's wrong.

>> I tried to find a platform with shared interrupts in the ones I have
>> available around me but I did not find any. Are the shared interrupt=
s
>> something used nowadays or coming from legacy hardware ? What is the
>> priority to handle the shared interrupts in the prediction code ?
>
> They're less common (thankfully) than they used to be, but I still ha=
ve
> them:
>
> root@ivb-ep:~# cat /proc/interrupts | grep ","
>    59:          0          0          0          0          0        =
  0
>    0          0          0          0          0          0          =
0
>    0          0          0          0          0          0          =
0
>    0          0          0          0          0          0          =
0
>    0          0          0          0          0          0          =
0
>    0          0          0          0          0          0   IO-APIC
>    5-fasteoi   i801_smbus, i801_smbus
>
> root@wsm-ep:~# cat /proc/interrupts | grep ","
>   18:          0          0          0          0          0         =
 0          0          0          0          0          0          0   =
IO-APIC  18-fasteoi   ehci_hcd:usb1, uhci_hcd:usb6
>   19:    9695230   19577242   13205011    3970578     740376    11386=
93          0          0          0          0          0          0   =
IO-APIC  19-fasteoi   uhci_hcd:usb5, ata_piix
>   23:          3          0          0          0        927         =
 0          0          0          0          0          0          0   =
IO-APIC  23-fasteoi   ehci_hcd:usb2, uhci_hcd:usb4
>
> root@snb:~# cat /proc/interrupts | grep ","
>   19:   11058485          0          0          0          0         =
 0          0          0   IO-APIC  19-fasteoi   ata_piix, ata_piix
>
>
> Also there's a whole host of SOCs that has them.

Ah, I see. Thank you very much for these examples.

Sounds like, I have to handle the shared interrupts sooner than what I=20
was expecting ... :)

   -- Daniel



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

