From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V6 1/4] cpufreq: exynos: Add cpufreq driver for exynos5440
Date: Mon, 8 Apr 2013 14:46:33 +0530
Message-ID: <CAKohpo=t_YTCTRCfnwQ+GPF=frsTGDigT3RZHJuVQ+R+YZU7Hg@mail.gmail.com>
References: <1365409058-32643-1-git-send-email-amit.daniel@samsung.com>
	<1365409058-32643-2-git-send-email-amit.daniel@samsung.com>
	<CAKohpo=CFTo2UCnECeeuKdz34cuedV_tqn7zGA9bzU_PiJ46qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=CFTo2UCnECeeuKdz34cuedV_tqn7zGA9bzU_PiJ46qg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene.kim@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, cpufreq@vger.kernel.org, Inderpal Singh <inderpal.singh@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On 8 April 2013 14:17, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 8 April 2013 13:47, Amit Daniel Kachhap <amit.daniel@samsung.com> wrote:
>
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index f3f3b14..bce2195 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -42,6 +42,15 @@ config ARM_EXYNOS5250_CPUFREQ
>>           This adds the CPUFreq driver for Samsung EXYNOS5250
>>           SoC.
>>
>> +config ARM_EXYNOS5440_CPUFREQ
>> +       def_bool SOC_EXYNOS5440
>> +       depends on HAVE_CLK && PM_OPP && OF
>
> Don't you need a depend on your Soc or mach or arch? Don't send another
> version for this now.. Just send a new patch over this patchset.

Sorry, i overlooked def_bool... This comments stands invalid.
