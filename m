From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH 1/3] thermal: exynos: Fix NULL pointer exception during
 kernel booting
Date: Tue, 17 Feb 2015 01:15:20 +0900
Message-ID: <CAGTfZH3tESLb3V7PNpiy-nwi+cCVq6DHxkU6+gJU-MZhNqDBzg@mail.gmail.com>
References: <1424096414-4327-1-git-send-email-cw00.choi@samsung.com>
	<1424096414-4327-2-git-send-email-cw00.choi@samsung.com>
	<20150216160633.29eac148@amdc2363>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:43876 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbbBPQPV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Feb 2015 11:15:21 -0500
In-Reply-To: <20150216160633.29eac148@amdc2363>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Amit Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, "inki.dae@samsung.com" <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Hi Lukasz,

On Tue, Feb 17, 2015 at 12:06 AM, Lukasz Majewski
<l.majewski@samsung.com> wrote:
> Hi Chanwoo,
>
>> This patch fixes the NULL pointer exception during kernel booting.
>> The thermal_zone _of_sensor_register() registers a sensor to DT
>> thermal zone and then read the current temperature by '.get_temp'
>> callback. The callback function of exynos thermal driver is
>> exynos_get_temp() which must need the 'pdata' instance of exynos_tmu
>> _platform_data structure.
>> - exynos_get_temp() -> code_to_temp() -> Must need the 'pdata'
>> instance
>>
>> But, exynos thermal driver is executed before getting the 'pdata'
>> instance. To avoid the kernel panic, have to get the platform data by
>> executing the exynos_map_dt_data() before calling
>> thermal_zone_of_sensor_register() .
>
> I've already prepared patch for this (unfortunately it isn't yet
> applied to mainline):
>
> "[PATCH] thermal: exynos: fix: Check if data->tmu_read callback is
> present before read"
>
> http://www.spinics.net/lists/linux-samsung-soc/msg42245.html

There is different issue between you patch and this patch.
Your patch check the whether data->tmu_read is NULL or not.
But, my patch check the pdata is NULL or not.

>
> Does applying this patch help?
>
> BTW: How can I reproduce this error? Could you point me the SHA1 and
> repository?

I used your patch-set of linux-soc-thermal.git (branch: next). So I
applied you patchiest on Linux 3.19 for test.
- https://git.kernel.org/cgit/linux/kernel/git/evalenti/linux-soc-thermal.git/log/?h=next

Best Regards,
Chanwoo Choi
