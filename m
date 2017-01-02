From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 3/3] power: supply: bq24735-charger: allow chargers to
 share the ac-detect gpio
Date: Mon, 2 Jan 2017 09:31:24 +0100
Message-ID: <c3d66181-3076-0d0f-d74e-ec0205b3f547@axentia.se>
References: <1481673405-4547-1-git-send-email-peda@axentia.se>
 <1481673405-4547-4-git-send-email-peda@axentia.se>
 <20161214165921.jsatcznbljd7anqi@earth>
 <20161214170114.ckozfple475kqajh@earth>
 <e1667d9d-17bf-2fe5-8a65-af73b6507cbd@axentia.se>
 <CACRpkda+7XLBMo11vB_V030or3b+-LRufrziVVgct4Gr_2E+KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkda+7XLBMo11vB_V030or3b+-LRufrziVVgct4Gr_2E+KQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2016-12-30 08:49, Linus Walleij wrote:
> On Wed, Dec 14, 2016 at 6:41 PM, Peter Rosin <peda@axentia.se> wrote:
>> On 2016-12-14 18:01, Sebastian Reichel wrote:
>>> [of course I forgot to actually add gpio people, let's try again]
>>>
>>> On Wed, Dec 14, 2016 at 05:59:21PM +0100, Sebastian Reichel wrote:
>>>> Hi,
>>>>
>>>> On Wed, Dec 14, 2016 at 12:56:45AM +0100, Peter Rosin wrote:
>>>>> If several parallel bq24735 chargers have their ac-detect gpios wired
>>>>> together (or if only one of the parallel bq24735 chargers have its
>>>>> ac-detect pin wired to a gpio, and the others are assumed to react the
>>>>> same), then all driver instances need to check the same gpio. But the
>>>>> gpio subsystem does not allow sharing gpios, so handle that locally.
>>>>
>>>> Adding GPIO subsystem people to see if they can come up with
>>>> something in the gpiod API for this usecase.
>>
>> Right, I don't like how my new code steps away from gpio descriptors.
> 
> The issue of shared gpiods have come up over and over again.
> For example the messy regulator code needs this too.
> 
> It is better if we implement something like gpiod_get_shared()
> in the gpiolib of these cases.
> 
> Just put a refcount in struct gpio_desc in drivers/gpio/gpiolib.h
> for this case I guess?

I actually tried that, but ran into atomicy issues with the
FLAG_REQUESTED bit and gave up. Didn't really try all that hard
though, but I simply didn't feel comfortable with going near such
fundamental designs...

Cheers,
peda
