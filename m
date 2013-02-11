From: amit daniel kachhap <amit.daniel@samsung.com>
Subject: Re: [PATCH V2 0/2] Thermal: cpufreq cooling fix
Date: Sun, 10 Feb 2013 19:44:50 -0800
Message-ID: <CADGdYn6MS=ySn18YKWHAstajdgA-yENMpys1dC-ddaJSX50j0A@mail.gmail.com>
References: <CADGdYn5=SdybVW7zJdaXBmfj40Y4inkwtHrjikaYOwVabUz4MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:40219 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab3BKDov (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 10 Feb 2013 22:44:51 -0500
Received: by mail-ia0-f179.google.com with SMTP id x24so5979074iak.38
        for <linux-pm@vger.kernel.org>; Sun, 10 Feb 2013 19:44:50 -0800 (PST)
In-Reply-To: <CADGdYn5=SdybVW7zJdaXBmfj40Y4inkwtHrjikaYOwVabUz4MA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Gu1 <gu1@aeroxteam.fr>, linux-pm@vger.kernel.org, Hongbo Zhang <hongbo.zhang@linaro.org>, amit kachhap <amit.kachhap@gmail.com>

Hi Rui,

I tested your patches on exynos platform with a small change and it works fine.

--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -227,8 +227,8 @@ static unsigned int get_cpu_frequency(unsigned int
cpu, unsigned long level)

        ret = get_property(cpu, level, &freq, GET_FREQ);
        if (ret)
-               return freq;
-       return 0;
+               return 0;
+       return freq;

You can add for next version,
Tested-by: Amit Daniel Kachhap<amit.daniel@samsung.com>

Thanks,
Amit Daniel



On Sun, Feb 10, 2013 at 7:36 PM, amit kachhap <amit.daniel@samsung.com> wrote:
> cpufreq cooling uses different frequencies as different cooling states.
>
> But the per_cpu cpufreq_frequency_table may contain duplicate,
> invalid entries, and it may be in either ascending or descending order.
> And currently, code for parsing the per_cpu cpufreq_frequency_table
> is used in several places and inconsistent.
>
> To fix this,
> New code is introduce in Patch 1/2, which contains the logic
> of parsing per_cpu cpufreq_frequency_table, and this piece of
> code can be used to:
> 1. get the maximum cooling states
> 2. translate cpu frequency to cooling state
> 3. translate cooling state to cpu frequency
>
> Patch 2/2 converts exynos_thermal driver to use the new code
> introduced in Patch 1/2.
>
> History:
> V2: remove cpu cooling table to avoid extra memory allocation.
>
> V1: introduce code to convert per_cpu cpufreq_frequency_table
>     to clean cpu cooling table (no invalid entry,
>     no duplicate entry, in descending order).
>
> I just run build test here. It would be great that some of you
> can test it on exynos.
> any comments?
>
> thanks,
> rui
