From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v3] ARM: EXYNOS: Fix suspend/resume sequences
Date: Mon, 21 Jul 2014 12:23:51 +0200
Message-ID: <53CCEA37.4060104@gmail.com>
References: <53C51B57.9040404@samsung.com> <1405434287-22710-1-git-send-email-t.figa@samsung.com> <53C53A1A.6060701@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <53C53A1A.6060701@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Kukjin Kim <kgene.kim@gmail.com>
Cc: Tomasz Figa <t.figa@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Chander Kashyap <k.chander@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

Hi,

On 15.07.2014 16:26, Tomasz Figa wrote:
> Forgot to CC Daniel and linux-pm. Sorry for the noise.
> 
> On 15.07.2014 16:24, Tomasz Figa wrote:
>> Due to recent consolidation of Exynos suspend and cpuidle code, some
>> parts of suspend and resume sequences are executed two times, once from
>> exynos_pm_syscore_ops and then from exynos_cpu_pm_notifier() and thus it
>> breaks suspend, at least on Exynos4-based boards. In addition, simple
>> core power down from a cpuidle driver could, in case of CPU 0 could
>> result in calling functions that are specific to suspend and deeper idle
>> states.
>>
>> This patch fixes the issue by moving those operations outside the CPU PM
>> notifier into suspend and AFTR code paths. This leads to a bit of code
>> duplication, but allows additional code simplification, so in the end
>> more code is removed than added.
>>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>> ---
>>  arch/arm/mach-exynos/pm.c        | 164 ++++++++++++++++++---------------------
>>  drivers/cpuidle/cpuidle-exynos.c |  25 +-----
>>  2 files changed, 80 insertions(+), 109 deletions(-)
>>

This is an important regression fix for 3.16 and today 3.16-rc6 was
already released...

Kukjin, could you pick up this patch and few others you missed and make
sure that it is included in 3.16-rc7? If you are busy, maybe Arnd or
Olof could take them directly?

Best regards,
Tomasz
