From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v2 4/4] power: supply: Add Spreadtrum SC27XX fuel gauge
 unit driver
Date: Wed, 26 Sep 2018 16:33:36 +0800
Message-ID: <CAMz4kuLy0inoJFav=hTmpLStMP6Tv4wHy-QQOx91z-omikXYWQ@mail.gmail.com>
References: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
 <707ebff8a188d41de374314414c8bfd927183d33.1537930252.git.baolin.wang@linaro.org>
 <CACRpkdYxV1OBrr6e29OTzE5QCTgt+-2yJGEuYtNM_Mw=41PSyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYxV1OBrr6e29OTzE5QCTgt+-2yJGEuYtNM_Mw=41PSyg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>, Craig Tatlor <ctatlor97@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

On 26 September 2018 at 16:09, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Sep 26, 2018 at 5:00 AM Baolin Wang <baolin.wang@linaro.org> wrote:
>
>> This patch adds the Spreadtrum SC27XX serial PMICs fuel gauge support,
>> which is used to calculate the battery capacity.
>>
>> Original-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> Changes from v1:
>>  - Use battery standard properties to get internal resistance and ocv table.
>>  - Change devm_gpiod_get_optional() to devm_gpiod_get().
>>  - Add power_supply_changed() when detecting battery present change.
>>  - Return micro volts for sc27xx_fgu_get_vbat_ocv().
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> I see that you need to have the internal resistance as parameter to
> this equation so it needs to come in. (I guess as factor/typical
> internal resistance as suggested.)
>
> IIUC this reliance on an uncertain internal resistance is the reason
> why fuel gauges / coloumb counters are seen as crude ways to
> estimate battery capacity, and their accuracy and reliability worsen
> over the lifetime of the battery, and this is why safety-critical devices
> include ways to measure the internal resistance as well.

Yes. Thanks for your reviewing.

>
> But the hardware is as it is, and probably for some good reasons,
> like cost.
>
> Yours,
> Linus Walleij



-- 
Baolin Wang
Best Regards
