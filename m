From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH 1/2] PM / devfreq: exynos-ppmu: Add the support of PPMUv2
 for Exynos5433
Date: Thu, 23 Jul 2015 16:17:12 +0200
Message-ID: <CAGTfZH0zpUy66dpFH1hvJ2DnTVCKU7F7ThbVLMJ4d6JUKPcUiw@mail.gmail.com>
References: <1437616639-7448-1-git-send-email-cw00.choi@samsung.com>
	<1437616639-7448-2-git-send-email-cw00.choi@samsung.com>
	<20150723094324.GP5422@mwanda>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34243 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbbGWORN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 10:17:13 -0400
In-Reply-To: <20150723094324.GP5422@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Thu, Jul 23, 2015 at 11:43 AM, Dan Carpenter
<dan.carpenter@oracle.com> wrote:
> On Thu, Jul 23, 2015 at 10:57:18AM +0900, Chanwoo Choi wrote:
>> +static int exynos_ppmu_v2_disable(struct devfreq_event_dev *edev)
>> +{
>> +     struct exynos_ppmu *info = devfreq_event_get_drvdata(edev);
>> +     u32 pmnc, clear;
>> +
>> +     /* Disable all counters */
>> +     clear = (PPMU_CCNT_MASK | PPMU_PMCNT0_MASK | PPMU_PMCNT1_MASK
>> +             | PPMU_PMCNT2_MASK | PPMU_PMCNT3_MASK);
>> +
>> +     __raw_writel(clear, info->ppmu.base + PPMUv2_FLAG);
>
> Why aren't you using normal readl()/writel()?  What are the endiannesses
> here?

There are no special reason. Usually I used the __raw_readl/writel to
access the SFR registers

Thanks,
Chanwoo Choi
