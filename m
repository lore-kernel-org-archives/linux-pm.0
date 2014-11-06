From: amit daniel kachhap <amit.daniel@samsung.com>
Subject: Re: [PATCH 02/12] drivers: mfd: Add support for Exynos PMU driver
Date: Thu, 6 Nov 2014 11:47:52 +0530
Message-ID: <CADGdYn4BjvZnXP6QU_NrOR_UDnXUqMQ=eSeUOD01cZUnt9nfvw@mail.gmail.com>
References: <000601cff985$5b8911f0$129b35d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <000601cff985$5b8911f0$129b35d0$@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Pankaj Dubey <pankaj.dubey@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Lee Jones <lee.jones@linaro.org>, LAK <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Sangbeom Kim <sbkim73@samsung.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 6, 2014 at 11:18 AM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> On Wednesday, November 05, 2014 7:18 PM, Sylwester Nawrocki wrote:
>> On 04/11/14 04:18, Pankaj Dubey wrote:
>> > 2: Since PM domain relies on PMU registers and does not have its own
>> > DT binding, MFD client and MFD device is most suitable for making
>> > this kind of platform drivers.
>>
>> We have DT binding for the Exynos power domains:
>> Documentation/devicetree/bindings/arm/exynos/power_domain.txt
>> In fact the IO memory regions used in the power domain bindings fall
>> within the
>> (sparse) PMU registers region.
>>
>
> Correct. But currently there is no platform driver for those DT bindings so we have two options:
> 1) Register a new platform driver for each of those DT nodes, which are using a very small subset of PMU register region. And we end up getting platform driver's probe for each pd nodes.
> 2) Register an Exynos power domain driver which will be a client driver of main Exynos PMU driver, and will get platform data from it. And in this probe parse all pd device nodes and populate all related information from those nodes into Exynos_pm_domain struct instances and keep list of these instances. Same has been proposed in Amit's patch.
>
> I would prefer second method, as next, we can move pm sleep functionality (which also uses PMU register sets) also into such small mfd client driver. And as far as I know for pm sleep currently there is no DT nodes.
>
>> There is also DT binding for the PMU subsystem:
>> Documentation/devicetree/bindings/arm/samsung/pmu.txt
>
> Yes, and currently I have used same binding to convert PMU implementation into a platform driver [1]. Now what we trying to address is same PMU implementation can be reused for ARM64 based SoC if we have to move it into "drivers/mfd/" or "drivers/power/" or may be "drivers/soc".
>
> [1]: http://www.spinics.net/lists/linux-samsung-soc/msg37572.html
>
> Currently we moved into "drivers/mfd" and patches from Amit shows an use case where power domain implementation has been converted into platform driver, but its probe will be called by MFD subsystem and will not be bind to DT nodes of pd  as it will be a client device to main PMU device. Please check this [2], [3].
>
> [2]: http://www.spinics.net/lists/linux-samsung-soc/msg38446.html
> [3]: http://www.spinics.net/lists/linux-samsung-soc/msg38447.html
>
>>
>> I guess a platform device driver in drivers/power would be a better
>> fit than drivers/mfd. I doubt introducing an mfd driver now makes much
>> sense, we have already DT bindings for PHYs, the power domains, etc.
>>
>
> The reason behind making it a mfd driver is, to make following design for pm domain and pm sleep functionality.
>                          ----------------------
>                         | Exynos - PMU  |
>                         | MFD device      |
>                         | drivers/mfd/     |
>                         ------------------------
>                                 |
>                   -----------------------------------------------
>                 |                                       |
>           -------------------------------               ------------------------------------
>         |  Exynos -pd                 |         |   Exynos - pm-sleep         |
>         |  PMU's client device        |         |   PMU's client device      |
>         | (drivers/soc/samsung/) |              | (drivers/soc/samsung/) |
>         --------------------------------                ---------------------------------
I will post this sleep driver shortly. I also suggest to keep
everything in drivers/soc/samsung as all these drivers very much SoC
specific.
>
> As Lee mentioned MFD can be used to register the device ( I am assuming he is referring to use of " mfd_add_devices" from Exynos -PMU driver, to make it a mfd device) but it should be kept outside of "drivers/mfd". I just looked for current users of "mfd_add_devices" but only drivers from "drivers/mfd" only are calling this API, also once we call this API it will become an MFD device then why not keep into "drivers/mfd" or maybe I have little understanding of purpose of "drivers/mfd".
>
> But still if it's OK to register Exynos -PMU as MFD device even if it's not in "drivers/mfd" folder, then I would suggest better to keep it in "drivers/soc/samsung/" as it's very much SoC specific. As "drivers/power" looks like place to keep external power supply drivers such as batteries, AC, USB etc.
>
> Thanks,
> Pankaj Dubey
>
>> --
>> Thanks,
>> Sylwester
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
