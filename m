From: Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH] ARM: dts: Add missing CPU frequencies for Exynos5422/5800
Date: Mon, 19 Dec 2016 19:05:27 +0530
Message-ID: <5857E21F.2080903@samsung.com>
References: <5220084.l31t5oJbsy@amdc3058>
 <CGME20161213191823epcas5p346582b73ad9b401d9e773a1b076f1f61@epcas5p3.samsung.com>
 <26ffeee4-ff43-b3d3-3267-5fcbc50e2974@osg.samsung.com>
 <2340115.HEG9AYUCMD@amdc3058>
 <CAD=FV=W6R8cNuR+gTnNRF6d-TNgzUeYTwuCp27efoMsd0YOH3g@mail.gmail.com>
 <20161216073720.GA3489@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20161216073720.GA3489@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Doug Anderson <dianders@chromium.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Arjun K V <arjun.kv@samsung.com>, Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Andreas Faerber <afaerber@suse.de>, Thomas Abraham <thomas.ab@samsung.com>, Ben Gamari <ben@smart-cactus.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 12/16/2016 01:07 PM, Krzysztof Kozlowski wrote:
> On Thu, Dec 15, 2016 at 04:52:58PM -0800, Doug Anderson wrote:
>>> [ I added Arjun to Cc:, maybe he can help in explaining this issue
>>>    (unfortunately Inderpal's email is no longer working). ]
>>>
>>> Please also note that on Exynos5422/5800 SoCs the same ARM rail
>>> voltage is used for 1.9 GHz & 2.0 GHz OPPs as for the 1.8 GHz one.
>>> IOW if the problem exists it is already present in the mainline
>>> kernel.
>>
>> Interesting.  In the ChromeOS tree I see significantly higher voltages
>> needed...  Note that one might naively look at
>> <https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.8/drivers/cpufreq/exynos5420-cpufreq.c#178>.
>>
>> 1362500, /* L0  2100 */
>> 1312500, /* L1  2000 */
>>
>> ..but, amazingly enough those voltages aren't used at all.  Surprise!
>>
>> I believe that the above numbers are actually not used and the ASV
>> numbers are used instead.  See
>> <https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.8/arch/arm/mach-exynos/include/mach/asv-exynos542x.h#452>
>>
>> { 2100000,
>> 1350000, 1350000, 1350000, 1350000, 1350000,
>> 1337500, 1325000, 1312500, 1300000, 1287500,
>> 1275000, 1262500, 1250000, 1237500 },
>>
>> I believe that interpretation there is: some bins of the CPU can run
>> at 2.1 GHz just fine at 1.25 V but others need up to 1.35V.
>
> That is definitely the case. One could just look at vendors ASV table
> (for 1.9 GHz):
> { 1900000, 1300000, 1287500, 1262500, 1237500, 1225000, 1212500,
>                      1200000, 1187500, 1175000, 1162500, 1150000,
> 		             1137500, 1125000, 1112500, 1112500},
>
> The theoretical difference is up to 1.875V! From my experiments I saw
> BIN1 chips which should be the same... but some working on 1.2V, some on
> 1.225V (@1.9 GHz). I didn't see any requiring higher voltages but that
> does not mean that there aren't such...
>
>> ...so if you're running at 2.1 GHz at 1.25V then perhaps you're just
>> running on a CPU from a nice bin?
>
> Would be nice to see a dump of PKG_ID and AUX_INFO chipid registers
> along with name of tested board. Because the "Tested on XU3" is not
> sufficient.
>
I agree, we should be dumping PKG_ID and other chip info to know on 
which BIN sample this patch is tested on...
As far as Peach-{pit/pi} boards are concerns, this is what I can remember:
1> 5420 (PIT) -> max recommended target frequency is 1800 MHz for A15
2> 5800 (PI)-> max recommended target frequency can go upto 2000 MHz, 
with INT rail locking.
INT rail locking schemes never made to mainline, so to be safer side 
instead of bumping the clock and voltages better to keep it at safer 
range for pit and pi, probably thats why it was kept at 1800MHz.
I am not sure if the same limitation applies to Odroid-XU3 samples.


> Best regards,
> Krzysztof
>
>
>
