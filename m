From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/8] mfd: axp20x: probe axp20x_adc driver for AXP813
Date: Thu, 7 Dec 2017 10:03:49 +0100
Message-ID: <41fcadb9-4fa9-65e8-5ef3-5844bcba1b1d@free-electrons.com>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
 <302c93023d8c4a54cafe321d912df484e39727b7.1512396054.git-series.quentin.schulz@free-electrons.com>
 <20171205080855.arr7vlgnxoxmyedd@flea.lan>
 <2021a653-d01e-f46f-2438-0760f579e0dc@free-electrons.com>
 <CAGb2v67nD+WAEEyridP1K=k_KgBprWmbNNL7FPdZWv9ZYdrjJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGb2v67nD+WAEEyridP1K=k_KgBprWmbNNL7FPdZWv9ZYdrjJg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Chen-Yu,

On 07/12/2017 09:54, Chen-Yu Tsai wrote:
> On Thu, Dec 7, 2017 at 4:51 PM, Quentin Schulz
> <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>> Hi Maxime,
>>
>> On 05/12/2017 09:08, Maxime Ripard wrote:
>>> On Mon, Dec 04, 2017 at 03:12:49PM +0100, Quentin Schulz wrote:
>>>> This makes the axp20x_adc driver probe with platform device id
>>>> "axp813-adc".
>>>>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>>>> ---
>>>>  drivers/mfd/axp20x.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>>>> index 2468b43..42e54d1 100644
>>>> --- a/drivers/mfd/axp20x.c
>>>> +++ b/drivers/mfd/axp20x.c
>>>> @@ -878,7 +878,9 @@ static struct mfd_cell axp813_cells[] = {
>>>>              .resources              = axp803_pek_resources,
>>>>      }, {
>>>>              .name                   = "axp20x-regulator",
>>>> -    }
>>>> +    }, {
>>>> +            .name                   = "axp813-adc",
>>>> +    },
>>>
>>> Any particular reason you're not adding it to the DT?
>>>
>>
>> No, no particular reason. It's just the way it is currently for AXP209
>> and AXP22x so did the same for AXP813.
>>
>> I'll add DT "support" in next version for all AXPs supported by this
>> driver. Or is it worthy of a small separate patch series?
> 
> IIRC there's no DT support because there's no need to reference
> it in the device tree.
> 

No current need but that does not mean there won't be a need later for
drivers to map IIO channels from the ADC driver (i.e. some components
wired to GPIOs of the PMIC for example).

Quentin
-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
