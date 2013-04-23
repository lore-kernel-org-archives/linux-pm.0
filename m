From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 2/6] thermal:exynos4: TMU Common clock framework support
 for TMU (Thermal Monitoring Unit)
Date: Tue, 23 Apr 2013 12:45:01 +0530
Message-ID: <CAK9yfHwx_3Lkt_xnzttvBK=0xGqdxL+f=QfdYjuo3mHV8NtNQA@mail.gmail.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
	<1366389493-8239-3-git-send-email-l.majewski@samsung.com>
	<CAK9yfHxWq5CrhY=A2HMZnH3SQww2sPTBM_zQ9hoinyk1zger7g@mail.gmail.com>
	<20130423081724.03b3b422@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20130423081724.03b3b422@amdc308.digital.local>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Zhang Rui <rui.zhang@intel.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On 23 April 2013 11:47, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Sachin,
>
>> On 19 April 2013 22:08, Lukasz Majewski <l.majewski@samsung.com>
>> wrote:
>> > This patch modifies exynos_thermal.c file to use
>> > clk_disable_unprepare() and clk_prepare_enable() instead of
>> > clk_{enable|disable}.
>> >
>> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
>> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> > ---
>>
>> I have already submitted a similar patch for this:
>> http://permalink.gmane.org/gmane.linux.power-management.general/33310
>>
>>
>
> Thanks for pointing to the correct patch.
>
> However, I've got a question:
>
> The patch only changes clock names at exynos_tmu_{probe|remove}.
>
> Correct me if I'm wrong, but shouldn't we also change clock_enable to
> clk_prepare_enable at exynos_tmu_read()? (Are we guaranteed, that we
> will NOT sleep there?)

Since clk_prepare does not do anything, i thought it was sufficient to
have it once in probe and then unprepare in remove.
Do you see a real problem in this implementation. If so I can update
it to use clk_prepare_enable at other places as well.


-- 
With warm regards,
Sachin
