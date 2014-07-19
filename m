From: Tobias Jakobi <liquid.acid@gmx.net>
Subject: Re: [PATCH v7 0/6] cpufreq: use generic cpufreq drivers for exynos
 platforms
Date: Sat, 19 Jul 2014 23:17:25 +0200
Message-ID: <53CAE065.1030605@gmx.net>
References: <1405345118-4269-1-git-send-email-thomas.ab@samsung.com> <53CAC4FB.9030703@gmx.net> <53CADAEE.2070009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:64938 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbaGSVRf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 19 Jul 2014 17:17:35 -0400
In-Reply-To: <53CADAEE.2070009@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, heiko@sntech.de, cw00.choi@samsung.com

Tomasz Figa wrote:
> Tobias,
> 
> On 19.07.2014 21:20, Tobias Jakobi wrote:
>> Hello,
>>
>> I have a question concerning an older version of this patchset, the one
>> which still included exynos4x12 support and where the clocking data was
>> provided through DT.
>>
>> I tried to get this working for my ODROID-X2, which does work well,
>> including the usage of the boost frequences. Since the X2 has an
>> Exynos4412 Prime I added additional clocking data and operating points.
>>
>> clocking data (comes from the vendor kernel):
>> <1704000 3 7 0 6 1 2 7 0 7>
>> <1600000 3 7 0 6 1 2 6 0 7>
>>
>> operating points (again from vendor kernel):
>> 1704000 1375000
>> 1600000 1350000
>>
>> Doing this I get correct output from scaling_available_frequencies and
>> scaling_boost_frequencies and the driver seems to select these
>> frequences. However when reading from cpufreq_cur_freq, which I think
>> returns the frequency of the armclk, the maximum freq never exceeds
>> 1.5GHz. So effectively the additional clocking data and opps are not used.
>>
>> I wonder this happens? Is there some kind of limit enforced?
> 
> Have you also extended the array of allowed APLL settings in
> drivers/clk/clk-exynos4.c?
> 
> Best regards,
> Tomasz
> 

Thanks Tomasz, that did the trick!


With best wishes,
Tobias

