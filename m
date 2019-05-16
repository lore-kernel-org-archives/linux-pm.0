From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [GIT PULL] Thermal-SoC management changes for v5.2-rc1
Date: Thu, 16 May 2019 09:55:33 -0700
Message-ID: <cd06dc28-1076-259a-ba94-bad116771da8@roeck-us.net>
References: <20190516044313.GA17751@localhost.localdomain>
 <CAHk-=wiaO_8SiEB9QM3vOTniiT67K6CBH0uHJ82-Dp_+6kxH3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wiaO_8SiEB9QM3vOTniiT67K6CBH0uHJ82-Dp_+6kxH3g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Eduardo Valentin <edubezval@gmail.com>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: Rui Zhang <rui.zhang@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 5/16/19 8:07 AM, Linus Torvalds wrote:
> On Wed, May 15, 2019 at 9:43 PM Eduardo Valentin <edubezval@gmail.com> wrote:
>>
>> - thermal core has a new devm_* API for registering cooling devices, thanks to Guenter R.
>>    I took the entire series, that is why you see changes on drivers/hwmon in this pull.
> 
> This clashed badly with commit 6b1ec4789fb1 ("hwmon: (pwm-fan) Add RPM
> support via external interrupt"), which added a timer to the pwm-fan
> handling.
> 
> In particular, that timer now needed the same kind of cleanup changes,
> and I'd like you guys (particularly Guenther, who was involved on both
> sides) to double-check my merge.
> 
> The way I solved it was to just make the pwm_fan_pwm_disable()
> callback do both the pwm_diable() _and_ the del_timer_sync() on the
> new timer. That seemed to be the simplest solution that meshed with
> the new devm cleanup model, but while I build-tested the result, I
> obviously did no actual use testing. And maybe there's some reason why
> that approach is flawed.
> 
> Guenther?

Sorry for the trouble. Looks like I did too much cleanup this time around.

Looks ok. I'll have to send a follow-up patch - we should check the
return value of devm_add_action_or_reset(). No idea why I didn't do that
in this series. I'll do that after the commit window closes (and after
I am back from vacation).

Thanks a lot for sorting this out.

Guenter
