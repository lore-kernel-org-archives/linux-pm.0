From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC/RFT 00/10] i2c: move handling of suspended adapters to the
 core
Date: Wed, 12 Dec 2018 11:09:41 +0100
Message-ID: <e8c68ef5-5085-e304-4959-82c4959f4511@redhat.com>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <2094a0d4-733f-7f74-abd2-bdb28edd0f80@redhat.com>
 <20181211234102.GA6701@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211234102.GA6701@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 12-12-18 00:41, Wolfram Sang wrote:
> Hi Hans,
> 
> thanks for testing this series!
> 
>> Note that the i2c-sprd driver changes in your patchset also get close
>> to triggering this problem, but they dodge the bullet because there
>> are separate system-wide and runtime suspend handlers and only the
>> system-wide handlers call the new i2c_mark_adapter_suspended() function.
> 
> Yes, this what I assumed to be all around - seperate handlers for RPM
> and PM. And I also assumed that they could be seperated if they aren't
> already. Until I read...
> 
>> As I explain in the commit message of the first attached patch
>> simply always using split handlers is not really an option because
>> of adapter drivers using DPM_FLAG_SMART_PREPARE or
>> DPM_FLAG_SMART_SUSPEND.
> 
> ... this. I don't know what these flags do (and reading SMART in there
> gives me more a 'uh-oh' feeling)

On x86 the lines between runtime suspend and system-suspend are blurring
with technologies like "connected standby" and in general devices moving
to suspend2idle as system-suspend state, I guess this also applies to
modern smartphone platforms but I'm not following those closely.

What this means on x86 is that the firmware is not doing any suspend
handling anymore and the OS / device-drivers get to do all the suspend.
For many devices this means that if they are runtime-suspended, and there
is no difference between the runtime and system suspend handling at the
driver level, they can be left as is, so during a system suspend they are
not touched at all (and left runtime suspended during system resume).

The "SMART" bit is really not all that smart, SMART_PREPARE means that
the drivers pm prepare callback will return positive non 0 (e.g. 1) to
indicate that the device may not be kept in its runtime suspended
state when transitioning to system-suspend, otoh when the prepare
callback returns 0 and the SMART_PREPARE flag is set then *all* suspend/
resume handling can be skipped during a system suspend.

SMART_SUSPEND means that if the device is runtime-suspended it may be left
as such, this only gets checked if the driver either does not have the
SMART_PREPARE flag, or the prepare callback indicated that skipping the
entire suspend/resume handling is not ok.

So this is not that scary, but it does require driver authors to know
what they are doing...

> but if the handlers can't be split, the
> issues you were seeing are a consequence, yes.
> 
> For me, this sadly spoils the whole concept. The patches you add make
> things even more complicated. Not happy about that.

Agreed, they don't fill me with happiness either.

> Looking at the open coded version you did for the designware driver, I
> wonder now if it is better to just leave it at driver level? Need to
> sleep over it, though.

I myself was thinking in the same direction (leave the entire suspended
check at the driver level).

Regards,

Hans
