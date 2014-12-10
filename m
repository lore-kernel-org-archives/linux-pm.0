From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: [PATCH 1/2] drivers: thermal: Remove ARCH_HAS_BANDGAP dependency
 for samsung
Date: Wed, 10 Dec 2014 09:26:55 +0530
Message-ID: <CAM4voamr2yxqWq51-WuiWyVpS7hCyXJY8rE7dH3Xr7WwQoayiw@mail.gmail.com>
References: <1417502073-6322-1-git-send-email-a.kesavan@samsung.com>
	<20141208104333.0e044c58@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:54113 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780AbaLJD44 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Dec 2014 22:56:56 -0500
Received: by mail-qg0-f52.google.com with SMTP id a108so1505081qge.25
        for <linux-pm@vger.kernel.org>; Tue, 09 Dec 2014 19:56:55 -0800 (PST)
In-Reply-To: <20141208104333.0e044c58@amdc2363>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Amit Kachhap <amit.daniel@samsung.com>

Hi Eduardo,

On Mon, Dec 8, 2014 at 3:13 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Abhilash,
>
>> As samsung thermal support is enabled only for ARCH_EXYNOS, there is
>> no need to select ARCH_HAS_BANDGAP from the arch-specific code.
>> Removing this dependency will also allow the driver to be enabled on
>> 64-bit SoCs.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> ---
>> This was based on the discussion regarding adding ARCH_HAS_BANDGAP
>> symbol for arm64 here:
>> http://www.spinics.net/lists/arm-kernel/msg377560.html
>>
>>  drivers/thermal/samsung/Kconfig |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/samsung/Kconfig
>> b/drivers/thermal/samsung/Kconfig index f760389..c43306e 100644
>> --- a/drivers/thermal/samsung/Kconfig
>> +++ b/drivers/thermal/samsung/Kconfig
>> @@ -1,6 +1,6 @@
>>  config EXYNOS_THERMAL
>>       tristate "Exynos thermal management unit driver"
>> -     depends on ARCH_HAS_BANDGAP && OF
>> +     depends on OF
>>       help
>>         If you say yes here you get support for the TMU (Thermal
>> Management Unit) driver for SAMSUNG EXYNOS series of SoCs. This
>> driver initialises
>
> Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>
> Acked-by: Lukasz Majewski <l.majewski@samsung.com>

Can you pick up these 2 patches if they look OK ?

Regards,
Abhilash
>
> --
> Best regards,
>
> Lukasz Majewski
>
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
