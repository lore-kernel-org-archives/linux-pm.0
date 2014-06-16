From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: [PATCH RFC v2 0/7] Devfreq support for Exynos5250/5420
Date: Mon, 16 Jun 2014 12:29:50 +0530
Message-ID: <CAM4voamLW_2+DhVFo77EzM6pjcX7oPGf+nP7MQ7eekcSSSbrRg@mail.gmail.com>
References: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
	<537ED7C1.5030601@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:37007 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbaFPG7v (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jun 2014 02:59:51 -0400
In-Reply-To: <537ED7C1.5030601@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, "myungjoo.ham" <myungjoo.ham@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>

Hi Chanwoo,

On Fri, May 23, 2014 at 10:38 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> Hi,
>
> On 05/23/2014 02:21 AM, Abhilash Kesavan wrote:
>> This patchset adds devfreq support on Exynos5250 and Exynos5420.
>> The patches add the missing INT clock support for exynos5250 and
>> also add a new 5420 driver. We also have patches which add the
>> PPMU node and fix a typo in the exynos5250 driver.
>>
>> Changes since RFC v1:
>>       - Exynos5420 support has been added to the existent Exynos5250
>>         driver itself.
>>       - Rebased on Chanwoo Choi's devfreq consolidation patchset.
>>       - Removed unused clocks from the clock list
>>       - Used the PPMU nodes with different compatible strings to
>>         differentiate between exynos5250 and exynos5420.
>>
>> The patches have been tested on Exynos5250 based Snow board and Exynos5420
>> based Peach-Pit boards. They have been prepared on linux-next(20140521) with
>> the devfreq for-next branch merged. Also applied is the "devfreq resource
>> management" series from Chanwoo Choi[1].
>> [1] https://lkml.org/lkml/2014/4/25/826
>
> I sent v2 patchset as following after fixed minor issue:
> [PATCHv2 0/5] devfreq: Support resource management functions and code clean
> - https://lkml.org/lkml/2014/5/9/74
Sorry for the delayed response, I was not in office for the last
couple of weeks. I have got the link wrong here, my patchset was in
fact based on your v2 patchset.

Myungjoo and Chanwoo, do you have any other comments on this patchset
or should I re-base this on the latest devfreq tree and re-send ?

Regards,
Abhilash
>
> Best Regards,
> Chanwoo Choi
