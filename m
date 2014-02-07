From: Naveen Krishna Ch <naveenkrishna.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v12 3/4] thermal: samsung: Add TMU support for Exynos5420 SoCs
Date: Fri, 7 Feb 2014 15:04:35 +0530
Message-ID: <CAHfPSqCDk6bQhC2P4r134AYkqs9mk0msHzfhZ3ZQUNo1JFk7xA@mail.gmail.com>
References: <1378268629-2886-3-git-send-email-ch.naveen@samsung.com>
 <1387433191-7861-1-git-send-email-ch.naveen@samsung.com> <3663519.7JfYNffMTG@amdc1227>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3663519.7JfYNffMTG@amdc1227>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, eduardo.valentin-l0cyMroinI0@public.gmane.org, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amit.daniel-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cpgs-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hello All,

On 19 December 2013 17:04, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> On Thursday 19 of December 2013 11:36:31 Naveen Krishna Chatradhi wrote:
>> Exynos5420 has 5 TMU channels, the TRIMINFO register is
>> misplaced for TMU channels 2, 3 and 4
>> TRIMINFO at 0x1006c000 contains data for TMU channel 3
>> TRIMINFO at 0x100a0000 contains data for TMU channel 4
>> TRIMINFO at 0x10068000 contains data for TMU channel 2
>>
>> This patch
>> 1 Adds the neccessary register changes and arch information
>>    to support Exynos5420 SoCs.
>> 2. Handles the gate clock for misplaced TRIMINFO register
>> 3. Updates the Documentation at
>>    Documentation/devicetree/bindings/thermal/exynos-thermal.txt
>>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> Acked-by: Amit Daniel Kachhap <amit.daniel-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>> Changes since v11:
>> 1. Added description for clocks in the Documentation
>> 2. corrected the clock name in clk_get() function as per description
>>
>> Changes since v10:
>> 1. using renamed compatible "samsung,exynos5420-tmu-ext-triminfo"
>>    and passing same clock as triminfo_apbif clock for channel 2
>> 2. removed the "exynos5420-tmu-triminfo-clk" compatible
>>  .../devicetree/bindings/thermal/exynos-thermal.txt |   45 ++++++++-
>>  drivers/thermal/samsung/exynos_tmu.c               |   52 +++++++++-
>>  drivers/thermal/samsung/exynos_tmu.h               |    1 +
>>  drivers/thermal/samsung/exynos_tmu_data.c          |   99 ++++++++++++++++++++
>>  drivers/thermal/samsung/exynos_tmu_data.h          |    8 ++
>>  5 files changed, 200 insertions(+), 5 deletions(-)
>
> Reviewed-by: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>
> Best regards,
> Tomasz
>
Ping.



-- 
Shine bright,
(: Nav :)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
