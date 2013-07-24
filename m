From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: backup/restore concept?
Date: Wed, 24 Jul 2013 13:57:47 -0400
Message-ID: <51F0159B.1090206@ti.com>
References: <CANMsd01y=eeQ356m=82PrdfZ0q50MpE53DoeQS6sDT=HaaZFzw@mail.gmail.com> <CAKohpo=i6xcUEXzkcJ9onHDc+O_TvKB1m_mwobuVbxF=BCwazg@mail.gmail.com> <51F00D11.6020905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59710 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab3GXR5w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2013 13:57:52 -0400
In-Reply-To: <51F00D11.6020905@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Lists linaro-dev <linaro-dev@lists.linaro.org>, Ryan <ryanphilips19@googlemail.com>, linux-pm@vger.kernel.org

On Wednesday 24 July 2013 01:21 PM, Nishanth Menon wrote:
> On 07/24/2013 12:49 AM, Viresh Kumar wrote:
>> Adding more relevant list in cc.
>>
>> On 23 July 2013 16:05, Ryan <ryanphilips19@googlemail.com> wrote:
>>> Hi,
>>>
>>> I have some doubts on backup and restore operation. From what i understand:
>>>
>>> We copy all registers values & addresses of all controllers in the SOC
>>> to the internal RAM or SRAM.
>>> before we put CPU to sleep?
>>>
>>> I want to know if we also copy the code segment into SRAM and what
>>> happens after wakeup.
>>> If so, where exactly we need to copy and how cpu jumps here after
>>> wakeup. or is there any other mechanism
>>> that is used. What executes first since DDR is in self-refresh.
>>>
>>> I use OMAP4 and this is my understanding. I could not understand much
>>> other than in OFF mode
>>> all the controller registers get copied to SRAM. Does anything else
>>> also gets copied too?
>>> or am i missing any basics here.
> This understanding is not accurate. OMAP behavior for "OFF mode" is as follows (as part of suspend/resume):
> - drivers do their own "context save" - saving of registers based on their need.
> - SAR registers are saved (note - this is *not* every possible register on OMAP - but a core subset).
> - cpu goes to WFI triggering h/w statemachine flow. (wfi instruction is in DDR)
>    - as part of "OFF mode" DDR is put into self refresh automatically by memory controller.
> 
> on wakeup
> - core registers are restored by hardware
> - DDR is brought out of selfrefresh,
> - execution resume in resume function pointer
> - drivers restore their own modules as needed.
> 
> So, there is no real black magic here :)
> 
:)
Also if you are interested in how the SRAM copy stuff work, look
at OMAP3 entry into OFF state and memory self refresh is triggered
from code running from SRAM. On the wakeup though, we directly jump
to DDR address.

regards,
Santosh
