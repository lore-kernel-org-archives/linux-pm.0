From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC/RFT 00/10] i2c: move handling of suspended adapters to the
 core
Date: Tue, 18 Dec 2018 22:44:38 +0100
Message-ID: <0e6b0ea6-e472-19f2-bb2f-61a1d66e6091@redhat.com>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <2094a0d4-733f-7f74-abd2-bdb28edd0f80@redhat.com>
 <20181211234102.GA6701@kunai>
 <e8c68ef5-5085-e304-4959-82c4959f4511@redhat.com>
 <20181218201725.2uqfmsethlkasdvc@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218201725.2uqfmsethlkasdvc@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 18-12-18 21:17, Wolfram Sang wrote:
> Hans, all,
> 
>>> ... this. I don't know what these flags do (and reading SMART in there
>>> gives me more a 'uh-oh' feeling)
>>
>> On x86 the lines between runtime suspend and system-suspend are blurring
>> with technologies like "connected standby" and in general devices moving
>> to suspend2idle as system-suspend state, I guess this also applies to
>> modern smartphone platforms but I'm not following those closely.
> 
> I'd guess so, too. I am not aware of any existing mechanism for that at
> the moment, though. If somebody does, please enlighten us.
> 
>> The "SMART" bit is really not all that smart, SMART_PREPARE means that
>> the drivers pm prepare callback will return positive non 0 (e.g. 1) to
>> indicate that the device may not be kept in its runtime suspended
>> state when transitioning to system-suspend, otoh when the prepare
>> callback returns 0 and the SMART_PREPARE flag is set then *all* suspend/
>> resume handling can be skipped during a system suspend.
> 
> Thanks for the detailed explanation! Much appreciated.
> 
>>> Looking at the open coded version you did for the designware driver, I
>>> wonder now if it is better to just leave it at driver level? Need to
>>> sleep over it, though.
>>
>> I myself was thinking in the same direction (leave the entire suspended
>> check at the driver level).
> 
> So, I was giving it some more thoughts, and my feeling is to still apply
> this series with the review comments addressed. Plus, clearly mark the
> new 'is_suspended' flag and the helper function as *optional* to allow
> for driver specific solutions as well. The then-to-be-added
> documentation would state that it is mostly useful for seperated system
> suspend and runtime suspend. For more complex situations, custom
> solutions are accepted, too. Which means your patch for designware
> should be added to the series.
> 
> My take is there are enough drivers out there already which can benefit
> from this new helper. If it turns out to be useless somewhen in the
> future, we can still remove it.
> 
> What do you (and all others, of course) think?

I've been thinking along the same lines: your series for the drivers
with separate runtime and system suspend handlers, "custom" driver
specific code for troublesome cases like i2c-designware.

Do you want me to send out a new version of my patch for the i2c-designware
code?

Regards,

Hans
