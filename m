From: Hongbo Zhang <hongbo.zhang@linaro.org>
Subject: Re: [PATCH V5 1/2] Thermal: Add ST-Ericsson DB8500 thermal driver.
Date: Thu, 15 Nov 2012 17:23:52 +0800
Message-ID: <CAJLyvQxJeNgGc8sQiV_qmKCfvfWQKyR8S5ZMNCtETvJLMQH-oQ@mail.gmail.com>
References: <1352460548-3494-1-git-send-email-hongbo.zhang@linaro.com>
	<1352460548-3494-2-git-send-email-hongbo.zhang@linaro.com>
	<1352967218.2080.15.camel@rzhang1-mobl4>
	<CAJLyvQyu_oU7xx92JTOj6bvF+7-hOJfM=kTHj6JMogaYjC+Jww@mail.gmail.com>
	<1352970823.2080.22.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1352970823.2080.22.camel@rzhang1-mobl4>
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, amit.kachhap@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, linaro-kernel@lists.linaro.org, STEricsson_nomadik_linux@list.st.com, kernel@igloocommunity.org, "hongbo.zhang" <hongbo.zhang@linaro.com>
List-Id: linux-pm@vger.kernel.org

this is a driver for ST-Ericsson u8500 board(Snowball), with a ARM core=
 inside.
so you should compile like this:
make  ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- u8500_defconfig
make  ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- uImage


On 15 November 2012 17:13, Zhang Rui <rui.zhang@intel.com> wrote:
> On Thu, 2012-11-15 at 16:32 +0800, Hongbo Zhang wrote:
>> On 15 November 2012 16:13, Zhang Rui <rui.zhang@intel.com> wrote:
>> > On Fri, 2012-11-09 at 19:29 +0800, hongbo.zhang wrote:
>> >> From: "hongbo.zhang" <hongbo.zhang@linaro.com>
>> >>
>> >> This driver is based on the thermal management framework in therm=
al_sys.c. A
>> >> thermal zone device is created with the trip points to which cool=
ing devices
>> >> can be bound, the current cooling device is cpufreq, e.g. CPU fre=
quency is
>> >> clipped down to cool the CPU, and other cooling devices can be ad=
ded and bound
>> >> to the trip points dynamically.  The platform specific PRCMU inte=
rrupts are
>> >> used to active thermal update when trip points are reached.
>> >>
>> >> Signed-off-by: hongbo.zhang <hongbo.zhang@linaro.com>
>> >> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
>> >> Reviewed-by: Francesco Lavra <francescolavra.fl@gmail.com>
>> >
>> >> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> >> index e1cb6bd..54c8fd0 100644
>> >> --- a/drivers/thermal/Kconfig
>> >> +++ b/drivers/thermal/Kconfig
>> >> @@ -31,6 +31,26 @@ config CPU_THERMAL
>> >>         and not the ACPI interface.
>> >>         If you want this support, you should say Y here.
>> >>
>> >> +config DB8500_THERMAL
>> >> +     bool "DB8500 thermal management"
>> >
>> > why is this bool?
>>
>> platform specific PRCMU interfaces are used, and those interfaces ar=
e
>> not exported, so my driver cannot be compiled as a module.
>>
> ok.
> But I still alway get this error message when set DB8500_THERMAL,
> include/linux/mfd/dbx500-prcmu.h:459:19: error: redefinition of
> =91prcmu_abb_read=92
> include/linux/mfd/db8500-prcmu.h:673:19: note: previous definition of
> =91prcmu_abb_read=92 was here
> include/linux/mfd/dbx500-prcmu.h:464:19: error: redefinition of
> =91prcmu_abb_write=92
> include/linux/mfd/db8500-prcmu.h:678:19: note: previous definition of
> =91prcmu_abb_write=92 was here
> include/linux/mfd/dbx500-prcmu.h:475:19: error: redefinition of
> =91prcmu_config_clkout=92
> include/linux/mfd/db8500-prcmu.h:643:19: note: previous definition of
> =91prcmu_config_clkout=92 was here
> include/linux/mfd/dbx500-prcmu.h:537:19: error: redefinition of
> =91prcmu_ac_wake_req=92
> include/linux/mfd/db8500-prcmu.h:683:19: note: previous definition of
> =91prcmu_ac_wake_req=92 was here
> include/linux/mfd/dbx500-prcmu.h:542:20: error: redefinition of
> =91prcmu_ac_sleep_req=92
> include/linux/mfd/db8500-prcmu.h:688:20: note: previous definition of
> =91prcmu_ac_sleep_req=92 was here
>
> $ grep prcmu_abb_read include/linux/mfd/*
> include/linux/mfd/db8500-prcmu.h:int prcmu_abb_read(u8 slave, u8 reg,=
 u8
> *value, u8 size);
> include/linux/mfd/db8500-prcmu.h:static inline int prcmu_abb_read(u8
> slave, u8 reg, u8 *value, u8 size)
> include/linux/mfd/dbx500-prcmu.h:int prcmu_abb_read(u8 slave, u8 reg,=
 u8
> *value, u8 size);
> include/linux/mfd/dbx500-prcmu.h:static inline int prcmu_abb_read(u8
> slave, u8 reg, u8 *value, u8 size)
>
> this functions are defined in both db8500-prmcu.h and dbx500-prcmu.h,
> plus linux/mfd/dbx500-prcmu.h includes linux/mfd/db8500-prcmu.h.
>
> I do not know how it works before, but this is a bug to me.
>
> thanks,
> rui
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
