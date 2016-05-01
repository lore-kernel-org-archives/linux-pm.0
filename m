From: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
Subject: Re: Re: [PATCH v2 2/6] mfd: axp20x: Add register bits
 for axp20x-ac-power
Date: Sun, 1 May 2016 16:24:20 +0200
Message-ID: <70789f3b-32c2-7d9c-1091-e4fd40b9a754@computerlinguist.org>
References: <1462093047-7885-1-git-send-email-haas@computerlinguist.org>
 <1462093047-7885-3-git-send-email-haas@computerlinguist.org>
 <CAGb2v67g6rmnsKwjP3d25y5FV4BpYcenU1gX5NF4PbhOhJSxNA@mail.gmail.com>
Reply-To: haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCD4V7EG6QFRBGVDTC4QKGQEEMQYGQI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v67g6rmnsKwjP3d25y5FV4BpYcenU1gX5NF4PbhOhJSxNA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: wens-jdAy2FN1RRM@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 05/01/2016 11:48 AM, Chen-Yu Tsai wrote:
> Hi,
> 
> On Sun, May 1, 2016 at 4:57 PM, Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org> wrote:
>> This change adds some register bit definitions used by the
>> axp20x-ac-power driver.
>>
>> Signed-off-by: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
>> ---
>>  include/linux/mfd/axp20x.h | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
>> index d82e7d5..c4c6dfa 100644
>> --- a/include/linux/mfd/axp20x.h
>> +++ b/include/linux/mfd/axp20x.h
>> @@ -90,6 +90,17 @@ enum {
>>  #define AXP22X_ALDO3_V_OUT             0x2a
>>  #define AXP22X_CHRG_CTRL3              0x35
>>
>> +
>> +/* Fields of AXP20X_PWR_INPUT_STATUS */
>> +#define AXP20X_PWR_STATUS_AC_PRESENT     BIT(7)
>> +#define AXP20X_PWR_STATUS_AC_AVAILABLE   BIT(6)
>> +#define AXP20X_PWR_STATUS_AC_VBUS_SHORT  BIT(1)
>> +#define AXP20X_PWR_STATUS_AC_VBUS_SEL    BIT(0)
>> +
>> +/* Fields of AXP20X_ADC_EN1 */
>> +#define AXP20X_ADC_EN1_ACIN_VOLT BIT(5)
>> +#define AXP20X_ADC_EN1_ACIN_CURR BIT(4)
>> +
> 
> We keep the bit definitions of each register in each separate driver.
> The drivers only define the ones they use.
> 
> ChenYu

Hi ChenYu,

i believe Maxime Ripard requested that these defines be moved to the
header: https://groups.google.com/d/msg/linux-sunxi/nEUg87cV6KI/TvdB6MBZBAAJ

What do you think?

Thanks for the review!

Michael
