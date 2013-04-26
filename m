From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH v2 0/4] Thermal:exynos: Thermal Measurement Unit fix and
 Samsung SoCs support
Date: Fri, 26 Apr 2013 12:15:50 +0530
Message-ID: <CAK9yfHzup+_HfJo49xDO=Ne_P66WoCvwu8aan-KVEtnhh9EkTQ@mail.gmail.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
	<1366893045-31586-1-git-send-email-l.majewski@samsung.com>
	<51794E3A.10009@ti.com>
	<20130425182843.70a2d7d3@amdc308.digital.local>
	<CAK9yfHz63uGH+HwpmGQ9gzsqa4AsKEQ47QR8TrfJ4joUP2kZYw@mail.gmail.com>
	<20130426083917.0b40adda@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20130426083917.0b40adda@amdc308.digital.local>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Zhang Rui <rui.zhang@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, t.figa@samsung.com, Myungjoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On 26 April 2013 12:09, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Sachin,
>
>> >
>> > Yes, this is a similar patch. However I've changed more clocks to
>> > clk_prepare_enable (clk_unprepare_disable). I've spoken about this
>> > with Sachin recently.
>>
>> The above description is actually for the below patch. Lukasz will
>> test and see if additional changes are needed.
>> If so he will send an incremental patch to address it.
>
> From tests, which I've done so far, TMU is working correctly.

Thanks for the confirmation.


-- 
With warm regards,
Sachin
