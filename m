From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v8 6/6] clk: samsung: remove unused clock aliases and
 update clock flags
Date: Tue, 29 Jul 2014 14:11:09 +0200
Message-ID: <53D78F5D.60500@gmail.com>
References: <1406611711-25112-1-git-send-email-thomas.ab@samsung.com>	<1406611711-25112-7-git-send-email-thomas.ab@samsung.com>	<53D77B01.40702@gmail.com> <CAJuA9ahgOS7ccqiaMHn9rTS4tY3ah64rzbmQugWmL3s6HXFZVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:53799 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbaG2MLQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jul 2014 08:11:16 -0400
In-Reply-To: <CAJuA9ahgOS7ccqiaMHn9rTS4tY3ah64rzbmQugWmL3s6HXFZVQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <ta.omasab@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>

On 29.07.2014 14:04, Thomas Abraham wrote:
> Hi Tomasz,
> 
> On Tue, Jul 29, 2014 at 4:14 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> Hi Thomas,
>>
>> You can find few comments inline.
>>
>> On 29.07.2014 07:28, Thomas Abraham wrote:
>>
>> [snip]
>>
>>> @@ -714,15 +715,24 @@ static struct samsung_div_clock exynos4_div_clks[] __initdata = {
>>                                                         ^^^
>>
>> Keep in mind that following clocks are common for Exynos4210 and
>> Exynos4x12. Have you tested this series on a board based on Exynos4212
>> or 4412 to verify that it does not break the legacy driver? (I would
>> test it myself, but I am on holidays at the moment.)
> 
> Thanks for taking time to have a look at this series. I have tested
> this series with the old cpufreq driver for Exynos4412 on an
> Origen4412 board and it works fine. These divider clocks are not
> directly used or referenced by the legacy cpufreq driver. So I marked
> them as read-only here.

OK.

Best regards,
Tomasz
