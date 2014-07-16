From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: [PATCH v3 1/7] clk: exynos5250: add aliases for clocks used by devfreq
Date: Wed, 16 Jul 2014 23:34:05 +0530
Message-ID: <CAM4voamvYcw2EMA4s3zY86t13WVnChZ7TSJNVMZFtmObtPcjYw@mail.gmail.com>
References: <1400779322-4410-2-git-send-email-a.kesavan@samsung.com>
	<1405449222-26186-1-git-send-email-a.kesavan@samsung.com>
	<53C658EA.2050902@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:47467 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934637AbaGPSEG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 14:04:06 -0400
In-Reply-To: <53C658EA.2050902@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: "myungjoo.ham" <myungjoo.ham@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, devicetree <devicetree@vger.kernel.org>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>

Hi Tomasz,

On Wed, Jul 16, 2014 at 4:20 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Abhilash, Andrew,
>
> On 15.07.2014 20:33, Abhilash Kesavan wrote:
>> From: Andrew Bresticker <abrestic@chromium.org>
>>
>> Devfreq does not support DT-based lookup of these peripheral clocks,
>> so add aliases for them.
>
> I'm afraid I have to NAK this. This is going backwards. Please fix the
> devfreq driver instead.
Will start modifying based on discussions in the other thread.

Thanks,
Abhilash
>
> Best regards,
> Tomasz
