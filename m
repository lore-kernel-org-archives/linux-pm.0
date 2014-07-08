From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH] cpufreq: Makefile: fix compilation for davinci platform
Date: Tue, 8 Jul 2014 16:32:52 +0100
Message-ID: <CA+V-a8sbMTqb99rDGA6giB9NkBuea6mnymR71cKR0k_jp1KBow@mail.gmail.com>
References: <1404833138-8244-1-git-send-email-prabhakar.csengg@gmail.com> <CAKohpokgr-ms9Coj7ViKq9e6K_yE_VzE1upM5UvHkNkAYueWag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37237 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbaGHPd0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jul 2014 11:33:26 -0400
In-Reply-To: <CAKohpokgr-ms9Coj7ViKq9e6K_yE_VzE1upM5UvHkNkAYueWag@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sekhar Nori <nsekhar@ti.com>, dlos <davinci-linux-open-source@linux.davincidsp.com>

On Tue, Jul 8, 2014 at 4:29 PM, Viresh Kumar <viresh.kumar@linaro.org> =
wrote:
> On 8 July 2014 20:55, Lad, Prabhakar <prabhakar.csengg@gmail.com> wro=
te:
>> From patch with commt-id:8a7b1227e303d7e927214ee0f260041aef44bb58
>> "cpufreq: davinci: move cpufreq driver to drivers/cpufreq"
>> this added dependancy only for CONFIG_ARCH_DAVINCI_DA850 where as
>> davinci_cpufreq_init() call is used by all davinci platform.
>>
>> This patch fixes following build error:
>>
>> arch/arm/mach-davinci/built-in.o: In function `davinci_init_late':
>> :(.init.text+0x928): undefined reference to `davinci_cpufreq_init'
>> make: *** [vmlinux] Error 1
>>
>> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>> ---
>>  drivers/cpufreq/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>> index 738c8b7..db6d9a2 100644
>> --- a/drivers/cpufreq/Makefile
>> +++ b/drivers/cpufreq/Makefile
>> @@ -49,7 +49,7 @@ obj-$(CONFIG_ARM_BIG_LITTLE_CPUFREQ)  +=3D arm_big=
_little.o
>>  # LITTLE drivers, so that it is probed last.
>>  obj-$(CONFIG_ARM_DT_BL_CPUFREQ)                +=3D arm_big_little_=
dt.o
>>
>> -obj-$(CONFIG_ARCH_DAVINCI_DA850)       +=3D davinci-cpufreq.o
>> +obj-$(CONFIG_ARCH_DAVINCI)             +=3D davinci-cpufreq.o
>>  obj-$(CONFIG_UX500_SOC_DB8500)         +=3D dbx500-cpufreq.o
>>  obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)       +=3D exynos-cpufreq.o
>>  obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)   +=3D exynos4210-cpufreq.o
>
> It took one year and 5 kernel releases to catch this again?
>
=46or a long time I was been working on DA850 itself, so couldn=E2=80=99=
t
notice it :(.

> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!

Regards,
--Prabhakar Lad
