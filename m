From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v11 4/6] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos4210/5250/5420
Date: Fri, 21 Nov 2014 23:32:54 +0900
Message-ID: <CAJuA9agU6A4OZ2_9ER2d5oxLAmEr=zq2c-Z3ij8AvPZYNafJRw@mail.gmail.com>
References: <1413805281-6269-1-git-send-email-thomas.ab@samsung.com>
 <1413805281-6269-2-git-send-email-thomas.ab@samsung.com>
 <1413805281-6269-3-git-send-email-thomas.ab@samsung.com>
 <1413805281-6269-4-git-send-email-thomas.ab@samsung.com>
 <1413805281-6269-5-git-send-email-thomas.ab@samsung.com>
 <CAHLCerPKv=NsLNZvwo-vhDwkved5+O4a40LvrP_7j30KjeKqUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHLCerPKv=NsLNZvwo-vhDwkved5+O4a40LvrP_7j30KjeKqUQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Linux PM list <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, lakml <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Amit,

On Wed, Nov 12, 2014 at 3:03 PM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> Hi Thomas,
>
> On Mon, Oct 20, 2014 at 5:11 PM, Thomas Abraham <thomas.ab@samsung.com> wrote:
>> The new CPU clock type allows the use of generic CPUfreq drivers. So for
>> Exynos4210/5250, switch to using generic cpufreq driver. For Exynos5420,
>> which did not have CPUfreq driver support, enable the use of generic
>> CPUfreq driver.
>>
>> Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
>> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Tested-by: Chander Kashyap <k.chander@samsung.com>
>> ---
>>  arch/arm/mach-exynos/exynos.c |   24 +++++++++++++++++++++++-
>>  1 files changed, 23 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
>> index 6b283eb..a1be294 100644
>> --- a/arch/arm/mach-exynos/exynos.c
>> +++ b/arch/arm/mach-exynos/exynos.c
>> @@ -282,6 +282,28 @@ static void __init exynos_init_irq(void)
>>         exynos_map_pmu();
>>  }
>>
>> +static const struct of_device_id exynos_cpufreq_matches[] = {
>> +       { .compatible = "samsung,exynos5420", .data = "arm-bL-cpufreq-dt" },
>
> While you're at it, can you add this to so we don't have to patch
> kernels for the Chromebook2 and Odroid-XU3?
>
>       { .compatible = "samsung,exynos5422", .data = "arm-bL-cpufreq-dt" },
>       { .compatible = "samsung,exynos5800", .data = "arm-bL-cpufreq-dt" },
>

Okay, I this has been included in the updated patches [1]

[1] http://www.spinics.net/lists/arm-kernel/msg380011.html

Thanks,
Thomas.

>
>> +       { .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
>> +       { .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
>> +       { .compatible = "samsung,exynos5440", .data = "exynos5440-cpufreq" },
>> +       { /* sentinel */ }
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
