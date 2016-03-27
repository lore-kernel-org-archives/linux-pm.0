From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH v5 00/21] PM / devferq: Add generic exynos bus frequency
 driver and new passive governor
Date: Sun, 27 Mar 2016 22:57:23 +0900
Message-ID: <CAGTfZH3UYY1o6z=i5ADe0jNih6y6rkYT09Q==V2Yv+hA4Yx+ew@mail.gmail.com>
References: <1458793530-31897-1-git-send-email-cw00.choi@samsung.com>
	<56F36D65.6030504@samsung.com>
	<CANAwSgTihXTNasXaSE-L2oZcwCcovUiat_yv=Opweo3zvMjZDg@mail.gmail.com>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34093 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbcC0N5Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Mar 2016 09:57:24 -0400
In-Reply-To: <CANAwSgTihXTNasXaSE-L2oZcwCcovUiat_yv=Opweo3zvMjZDg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>

Hi Anand,

On Sun, Mar 27, 2016 at 9:28 PM, Anand Moon <linux.amoon@gmail.com> wrote:
> Hi Chanwoo Choi,
>
> On 24 March 2016 at 10:00, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> Dear Anand and Tobias,
>>
>> To Anand,
>> First of all, thanks to your test on previous patchset.
>> I removed the your tested-by tag from this version
>> because I modified the devfreq core using DEVFREQ_TRANSITION_NOTIFIER notifier.
>> I think that this patch-set need to test with this patchset.
>> If you possible, could you please test this patch-set? Thanks in advance.
>>
> I have being following this series, I have tested this series on Odroid U3.
>
> Please feel free to add my Tested tag if needed
>
> Tested-by: Anand Moon <linux.amoon@gmail.com>

Thanks for your test again.

Best Regards,
Chanwoo Choi

[snip]
