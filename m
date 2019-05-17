From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [GIT PULL] Thermal-SoC management changes for v5.2-rc1
Date: Fri, 17 May 2019 14:25:24 +0200
Message-ID: <d6da5203-c113-5cec-c12e-9af91a9ff716@i2se.com>
References: <20190516044313.GA17751@localhost.localdomain>
 <CAHk-=wiaO_8SiEB9QM3vOTniiT67K6CBH0uHJ82-Dp_+6kxH3g@mail.gmail.com>
 <4803994d-f519-a6b6-f5bb-a2f50d91ecd7@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4803994d-f519-a6b6-f5bb-a2f50d91ecd7@i2se.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Rui Zhang <rui.zhang@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 16.05.19 18:11, Stefan Wahren wrote:
> Hi Linus,
>
> On 16.05.19 17:07, Linus Torvalds wrote:
>> On Wed, May 15, 2019 at 9:43 PM Eduardo Valentin <edubezval@gmail.com> wrote:
>>> - thermal core has a new devm_* API for registering cooling devices, thanks to Guenter R.
>>>   I took the entire series, that is why you see changes on drivers/hwmon in this pull.
>> This clashed badly with commit 6b1ec4789fb1 ("hwmon: (pwm-fan) Add RPM
>> support via external interrupt"), which added a timer to the pwm-fan
>> handling.
>>
>> In particular, that timer now needed the same kind of cleanup changes,
>> and I'd like you guys (particularly Guenther, who was involved on both
>> sides) to double-check my merge.
>>
>> The way I solved it was to just make the pwm_fan_pwm_disable()
>> callback do both the pwm_diable() _and_ the del_timer_sync() on the
>> new timer. That seemed to be the simplest solution that meshed with
>> the new devm cleanup model, but while I build-tested the result, I
>> obviously did no actual use testing. And maybe there's some reason why
>> that approach is flawed.
> i will try to test on our custom i.MX6 board. Unfortunately this take
> some time since it isn't mainline yet (at least until tomorrow).

Okay, today's test based on your tree ( a6a4b66bd8f ) were successful.

Thanks
Stefan

>
> Stefan
>
>> Guenther?
>>
>>                     Linus
