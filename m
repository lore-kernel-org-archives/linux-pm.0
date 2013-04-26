From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH v2 0/4] Thermal:exynos: Thermal Measurement Unit fix and
 Samsung SoCs support
Date: Fri, 26 Apr 2013 10:35:21 +0530
Message-ID: <CAK9yfHz63uGH+HwpmGQ9gzsqa4AsKEQ47QR8TrfJ4joUP2kZYw@mail.gmail.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
	<1366893045-31586-1-git-send-email-l.majewski@samsung.com>
	<51794E3A.10009@ti.com>
	<20130425182843.70a2d7d3@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20130425182843.70a2d7d3@amdc308.digital.local>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Zhang Rui <rui.zhang@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, t.figa@samsung.com, Myungjoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

 Hi Eduardo,

On 25 April 2013 21:58, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Eduardo,
>
>> Hello Lukasz,
>>
>> On 25-04-2013 08:30, Lukasz Majewski wrote:
>> > This patch series provide various fixes for TMU block.
>> > First of all it fixes a problem with get_cpu_frequency() lockup at
>> > cpu_cooling.c.
>> >
>> > Secondly a proper regulator definition (VDD_TS) has been added.
>> > Moreover device tree definitions and documentation entry are now in
>> > place.
>> >
>> > Dependencies (those patches shall be applied on top of):
>> > - "clk: exynos4: Add clock entries for TMU"
>>
>> Is this one same as  [1/6] clk:exynos4:TMU Thermal Measurement Unit
>> clock added to common clock framework in your previous series?

The one sent by Lukasz has been dropped as an equivalent patch sent by
me is already under review.

>
> Yes, this is a similar patch. However I've changed more clocks to
> clk_prepare_enable (clk_unprepare_disable). I've spoken about this with
> Sachin recently.

The above description is actually for the below patch. Lukasz will
test and see if additional changes are needed.
If so he will send an incremental patch to address it.

>
>>
>> > - "Thermal: exynos: Add clk_{un}prepare APIs"
>> Same as
>> thermal:exynos4: TMU Common clock framework support for TMU (Thermal
>> Monitoring Unit)
>> in your previous series?
>

>
>>
>> > - "Thermal: exynos: Add compatible string for exynos4412"

These 2 have been merged in the thermal next tree.

>> >
>> This should be same as thermal:exynos4: Enable support for Exynos4412
>> SoCs in your previous series?
>
> Yes.
>

-- 
With warm regards,
Sachin
