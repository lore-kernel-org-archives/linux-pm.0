From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 4/5] ARM: dts: exynos: add support for ISP power domain to
 exynos4x12 clocks device
Date: Thu, 15 Sep 2016 14:06:18 +0200
Message-ID: <6e52af56-8b0e-d8c4-62c2-6efeee0e912d@samsung.com>
References: <1472737551-15272-1-git-send-email-m.szyprowski@samsung.com>
 <1472737551-15272-5-git-send-email-m.szyprowski@samsung.com>
 <20160908002254.GD13062@codeaurora.org>
 <CGME20160912102332eucas1p145e79669788329b44343da62dcbe50ca@eucas1p1.samsung.com>
 <f340cca5-6cd6-6bd1-3b9a-ccd58cbc0091@samsung.com>
 <20160912222852.GH7243@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20160912222852.GH7243-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Stephen,

On 2016-09-13 00:28, Stephen Boyd wrote:
> On 09/12, Marek Szyprowski wrote:
>> On 2016-09-08 02:22, Stephen Boyd wrote:
>>> On 09/01, Marek Szyprowski wrote:
>>>> Exynos4412 clock controller contains some additional clocks for FIMC-ISP
>>>> (Camera ISP) subsystem. Registers for those clocks are partially located
>>>> in the SOC area, which belongs to ISP power domain.
>>>>
>>>> This patch extends clock controller node with ISP clock sub-node and link
>>>> (phandle) to ISP power domain.
>>>>
>>>> Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>>> ---
>>>>   arch/arm/boot/dts/exynos4x12.dtsi | 5 +++++
>>>>   1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
>>>> index 3394bdcf10ae..4daea67546b9 100644
>>>> --- a/arch/arm/boot/dts/exynos4x12.dtsi
>>>> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
>>>> @@ -74,6 +74,11 @@
>>>>   		compatible = "samsung,exynos4412-clock";
>>>>   		reg = <0x10030000 0x20000>;
>>>>   		#clock-cells = <1>;
>>>> +
>>>> +		isp-clock-controller {
>>>> +			compatible = "samsung,exynos4412-isp-clock";
>>>> +			power-domains = <&pd_isp>;
>>>> +		};
>>> Why can't we extend support in power domains code to have
>>> multiple domains for a single device node? i.e. power-domains =
>>> <&pd_isp>, <&pd_foo>, <&pd_bar>, and then pick the right one with
>>> power-domain-names or something like that? Making a subnode
>>> (which seems to turn into a child platform device?) seems like a
>>> quick solution for larger problems.
>> The larger problem here is the fact that clock controller is
>> partially located
>> in different power areas of SoC. Majority of the clock controllers
>> is located
>> in the area which is typically always powered (besides system sleep case),
>> while a few Camera ISP registers are located in the ISP block, which have
>> separate power domain. Having a separate nodes for sub-parts of the
>> device is
>> rather common approach, already practices by some more complex devices.
>>
>> I see some serious design problems with multiple entries in power domains
>> property. First how to show that some part of the device IS NOT in
>> any domain?
> Is that even possible? Every device should be in some power
> domain, even if it's just an "always on" power domain that we
> don't really control from software.

Right now none dts of which I'm aware of doesn't define the power domain for
the parts of the SoC, which are always on and doesn't need any additional
management.

>
>> The question is how the automated assignment to domains would be handled for
>> such case?
> I don't get this part. Do you mean how we indicate to the driver
> which power domain to use at the right time?

This was about Linux device core, which assigns device to its power domain
and ensures that the power domain is in right state during device probe and
then during device operation. Currently core supports only one domain per
device, so the question was which domain to chose if there are more than
one listed.

>
>> The second is related to Linux kernel internals. Right now device
>> drivers are
>> not aware of the power domains - there are no direct calls to power domains
>> code, everything is hidden behind runtime pm which does all the hard work.
> Right. Runtime PM will need to be improved to allow this case.
>
>> Similar situation is on Exynos 542x/5800, which will look more or less like
>> this:
>>
>>          clock: clock-controller@10010000 {
>>               compatible = "samsung,exynos5420-clock";
>>               reg = <0x10010000 0x30000>;
>>               #clock-cells = <1>;
>> +
>> +            gsc-clock-controller {
>> +                 compatible = "samsung,exynos5420-gsc-clock";
>> +                 power-domains = <&gsc_pd>;
>> +            };
>> +
>> +            isp-clock-controller {
>> +                 compatible = "samsung,exynos5420-isp-clock";
>> +                 power-domains = <&isp_pd>;
>> +            };
>> +
>> +            mfc-clock-controller {
>> +                 compatible = "samsung,exynos5420-mfc-clock";
>> +                 power-domains = <&mfc_pd>;
>> +            };
>> +
>> +            msc-clock-controller {
>> +                 compatible = "samsung,exynos5420-msc-clock";
>> +                 power-domains = <&msc_pd>;
>> +            };
>> +
>> +            disp-clock-controller {
>> +                 compatible = "samsung,exynos5420-disp-clock";
>> +                 power-domains = <&disp_pd>;
>> +            };
>>           };
>>
>> The patch is not yet ready, so I didn't include it in this patchset.
> Ok. From a DT perspective the sub-nodes seem to be a workaround
> for how the linux device model is mapped to power domains. I'm
> not sure we want to make subnodes in the clk controller just to
> make sub devices that we can target from the clk registration
> path. Those sub nodes aren't devices at all. I understand why
> it's being done this way, I just don't see how it fits into DT
> design methodologies.

I don't think that using sub-nodes for describing details of the given
hardware block is something uncommon in DT. Please check pin control
or PMICs (especially regulator providers). Same for various "port"
sub-nodes often used by various video/display devices and bridges.

The above presented method describes well which sub-part of clock
controller is placed in which power domain.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
