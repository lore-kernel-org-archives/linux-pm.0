From: Leela Krishna Amudala <leela.krishna@linaro.org>
Subject: Re: [PATCH] ARM: EXYNOS: Use wfi macro in platform_do_lowpower
Date: Fri, 23 May 2014 11:43:30 +0530
Message-ID: <CAM7CM0kG-fWcAo9rTwRj1iPD7EFSDVZWaPc93XmLVE=s_ePDpw@mail.gmail.com>
References: <1400745455-27920-1-git-send-email-leela.krishna@linaro.org> <537E497B.9020404@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <537E497B.9020404@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Kukjin Kim <kgene.kim@samsung.com>, Amit Kucheria <amit.kucheria@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Kgene,


On Fri, May 23, 2014 at 12:31 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 05/22/2014 09:57 AM, Leela Krishna Amudala wrote:
>>
>> This patch is originally based on commit b3377d186572 ("ARM: 7064/1:
>> vexpress: Use wfi macro in platform_do_lowpower.")
>>
>> Current Exynos CPU hotplug code includes a hardcoded WFI
>> instruction, in ARM encoding.  When the kernel is compiled in Thumb-=
2
>> mode, this is invalid and causes the machine to hang hard when a CPU
>> is offlined.
>>
>> Use wfi macro instead of the hardcoded WFI instruction.
>>
>> Signed-off-by: Leela Krishna Amudala <leela.krishna@linaro.org>
>
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>

Can you please take action on this patch.

Best Regards,
Leela Krishna.

>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software f=
or ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
