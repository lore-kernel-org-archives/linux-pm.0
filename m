From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] thermal: imx: add NVMEM dependency
Date: Tue, 19 Sep 2017 14:22:36 +0200
Message-ID: <CAK8P3a3=bGhjwvyMCEAz3UrBZmEst+XBFpAdYsyrr+ppHg2t7w@mail.gmail.com>
References: <20170918204825.159177-1-arnd@arndb.de> <1505818394.29684.13.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505818394.29684.13.camel@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 19, 2017 at 12:53 PM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> On Mon, 2017-09-18 at 22:48 +0200, Arnd Bergmann wrote:
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 07002df4f83a..cb14f1ec5953 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -206,6 +206,7 @@ config HISI_THERMAL
>>  config IMX_THERMAL
>>       tristate "Temperature sensor driver for Freescale i.MX SoCs"
>>       depends on (ARCH_MXC && CPU_THERMAL) || COMPILE_TEST
>> +     depends on NVMEM || !NVMEM
>
> The || !NVMEM part is so that it also works when NVMEM=n, right?

Correct, this is a very strange Kconfig expression when you see it the
first time, but we do the same thing in a lot of places that can either
use another subsystem when it is enabled (but have a link-time
dependency), or can work fine without it.

      Arnd
